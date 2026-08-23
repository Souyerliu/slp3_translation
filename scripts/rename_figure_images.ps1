[CmdletBinding()]
param(
    [switch]$Apply
)

$ErrorActionPreference = 'Stop'

$projectRoot = Split-Path -Parent $PSScriptRoot
$chapterDirectories = Get-ChildItem -LiteralPath $projectRoot -Directory |
    Where-Object { $_.Name -match '^Chapter\s+\d{2}$' } |
    Sort-Object Name

$imagePattern = '(?:!\[[^\]]*\]\((?:\.\./)?images/([^\)]+)\)|<img\b[^>]*\bsrc=["''](?:\.\./)?images/([^"'']+)["''][^>]*>)'
$captionPattern = '^\s*Figure\s+(\d+\.\d+)\b'
$panelLabelPattern = '^\s*(?:\(?[a-z]\)|[a-z]\))\s*.*$'
$utf8NoBom = [System.Text.UTF8Encoding]::new($false)

# These captions were damaged or separated from their images during PDF-to-Markdown
# conversion, so adjacency alone cannot recover them reliably.
$manualFigureGroups = @{
    'Chapter 08' = @(
        [pscustomobject]@{ Figure = '8.5'; Sources = @('36621909ec31864cfde70796baa3bb254f44c450696a962a0601ca7b692df780.jpg') }
    )
    'Chapter 10' = @(
        [pscustomobject]@{ Figure = '10.7'; Sources = @('9c341fa0b814632f512c0bf813a7f0b3a157c710cbd161190498fd42853aaa13.jpg') }
    )
    'Chapter 13' = @(
        [pscustomobject]@{ Figure = '13.11'; Sources = @('5ea52562d617a5ef8767ee3deef56c0c98271773dcc3860e5dfe4541d9f9252c.jpg') }
    )
    'Chapter 17' = @(
        [pscustomobject]@{ Figure = '17.8'; Sources = @('75818c8f53c31e3f74b106dc8bb0d17078c249614c71b7f5e86482ecaad1b08a.jpg') }
    )
    'Chapter 23' = @(
        [pscustomobject]@{ Figure = '23.13'; Sources = @(
            '8f52bdf425a6cf1c1921d78d49d7249c5edf4f23a2746bfdbc544f542c3d9384.jpg',
            '59f2a2224ba51c5be253476e2c9abe2b490e3a104e8ca66c88e86efdfb0fc542.jpg',
            '7edcfc3e4abe03f1c275edac2763b4676427c3897591ddb79fe4716b78f04a39.jpg'
        ) }
    )
    'Chapter 25' = @(
        [pscustomobject]@{ Figure = '25.5'; Sources = @('1828b3d297438caaddca2151b1bfa2d667e5929af608e11c0c162f13343376ca.jpg') }
    )
}

$totalRenames = 0
$totalUnmatched = 0

foreach ($chapterDirectory in $chapterDirectories) {
    $primaryMarkdownFiles = @(Get-ChildItem -LiteralPath $chapterDirectory.FullName -File -Filter '*.md')
    if ($primaryMarkdownFiles.Count -ne 1) {
        Write-Warning "$($chapterDirectory.Name): expected one primary Markdown file, found $($primaryMarkdownFiles.Count); skipped."
        continue
    }

    $markdownFile = $primaryMarkdownFiles[0]
    $allMarkdownFiles = @(Get-ChildItem -LiteralPath $chapterDirectory.FullName -File -Filter '*.md' -Recurse)
    $text = [System.IO.File]::ReadAllText($markdownFile.FullName)
    $lines = [System.Text.RegularExpressions.Regex]::Split($text, '\r?\n')
    $allReferences = [System.Collections.Generic.List[object]]::new()
    $mappings = [System.Collections.Generic.List[object]]::new()

    for ($lineIndex = 0; $lineIndex -lt $lines.Count; $lineIndex++) {
        $imageMatches = [regex]::Matches($lines[$lineIndex], $imagePattern, 'IgnoreCase')
        foreach ($imageMatch in $imageMatches) {
            $sourceName = if ($imageMatch.Groups[1].Success) {
                $imageMatch.Groups[1].Value
            } else {
                $imageMatch.Groups[2].Value
            }
            $allReferences.Add([pscustomobject]@{
                Line = $lineIndex + 1
                File = $sourceName
            })
        }
    }

    foreach ($manualGroup in @($manualFigureGroups[$chapterDirectory.Name])) {
        if ($null -eq $manualGroup) {
            continue
        }

        for ($imageIndex = 0; $imageIndex -lt $manualGroup.Sources.Count; $imageIndex++) {
            $originalSourceName = $manualGroup.Sources[$imageIndex]
            $extension = [System.IO.Path]::GetExtension($originalSourceName).ToLowerInvariant()
            $suffix = if ($manualGroup.Sources.Count -gt 1) {
                [char]([int][char]'a' + $imageIndex)
            } else {
                ''
            }
            $targetName = "figure$($manualGroup.Figure)$suffix$extension"
            $reference = $allReferences |
                Where-Object { $_.File -eq $originalSourceName -or $_.File -eq $targetName } |
                Select-Object -First 1
            if ($null -eq $reference) {
                throw "$($chapterDirectory.Name): manual source is not referenced: $originalSourceName"
            }

            $sourceName = if ($reference.File -eq $targetName) {
                $targetName
            } else {
                $originalSourceName
            }

            $mappings.Add([pscustomobject]@{
                Figure = $manualGroup.Figure
                Line = $reference.Line
                Source = $sourceName
                Target = $targetName
            })
        }
    }

    for ($lineIndex = 0; $lineIndex -lt $lines.Count; $lineIndex++) {
        $captionMatch = [regex]::Match($lines[$lineIndex], $captionPattern, 'IgnoreCase')
        if (-not $captionMatch.Success) {
            continue
        }

        $figureNumber = $captionMatch.Groups[1].Value
        $precedingImages = [System.Collections.Generic.List[object]]::new()
        $scanIndex = $lineIndex - 1

        while ($scanIndex -ge 0) {
            $candidate = $lines[$scanIndex].Trim()
            if ($candidate.Length -eq 0) {
                $scanIndex--
                continue
            }

            $precedingImageMatches = [regex]::Matches($candidate, $imagePattern, 'IgnoreCase')
            if ($precedingImageMatches.Count -gt 0) {
                $imagesOnLine = [System.Collections.Generic.List[object]]::new()
                foreach ($precedingImageMatch in $precedingImageMatches) {
                    $sourceName = if ($precedingImageMatch.Groups[1].Success) {
                        $precedingImageMatch.Groups[1].Value
                    } else {
                        $precedingImageMatch.Groups[2].Value
                    }
                    $imagesOnLine.Add([pscustomobject]@{
                        Line = $scanIndex + 1
                        File = $sourceName
                    })
                }
                for ($insertIndex = $imagesOnLine.Count - 1; $insertIndex -ge 0; $insertIndex--) {
                    $precedingImages.Insert(0, $imagesOnLine[$insertIndex])
                }
                $scanIndex--
                continue
            }

            if ($candidate -match $panelLabelPattern) {
                $scanIndex--
                continue
            }

            break
        }

        for ($imageIndex = 0; $imageIndex -lt $precedingImages.Count; $imageIndex++) {
            $sourceName = $precedingImages[$imageIndex].File
            $extension = [System.IO.Path]::GetExtension($sourceName).ToLowerInvariant()
            $suffix = if ($precedingImages.Count -gt 1) {
                [char]([int][char]'a' + $imageIndex)
            } else {
                ''
            }
            $targetName = "figure$figureNumber$suffix$extension"

            $mappings.Add([pscustomobject]@{
                Figure = $figureNumber
                Line = $precedingImages[$imageIndex].Line
                Source = $sourceName
                Target = $targetName
            })
        }
    }

    $duplicateSources = @($mappings | Group-Object Source | Where-Object Count -gt 1)
    $duplicateTargets = @($mappings | Group-Object Target | Where-Object Count -gt 1)
    if ($duplicateSources.Count -gt 0 -or $duplicateTargets.Count -gt 0) {
        throw "$($chapterDirectory.Name): ambiguous duplicate source or target names."
    }

    $mappedNames = @($mappings | ForEach-Object Source)
    $unmatched = @($allReferences | Where-Object { $_.File -notin $mappedNames })
    $totalRenames += $mappings.Count
    $totalUnmatched += $unmatched.Count

    Write-Output ("{0}: rename={1}, unmatched={2}" -f $chapterDirectory.Name, $mappings.Count, $unmatched.Count)
    foreach ($mapping in $mappings) {
        Write-Output ("  L{0}: {1} -> {2}" -f $mapping.Line, $mapping.Source, $mapping.Target)
    }
    foreach ($reference in $unmatched) {
        Write-Output ("  UNMATCHED L{0}: {1}" -f $reference.Line, $reference.File)
    }

    if (-not $Apply) {
        continue
    }

    $imageDirectory = Join-Path $chapterDirectory.FullName 'images'
    foreach ($mapping in $mappings) {
        $sourcePath = Join-Path $imageDirectory $mapping.Source
        $targetPath = Join-Path $imageDirectory $mapping.Target
        if (-not (Test-Path -LiteralPath $sourcePath -PathType Leaf)) {
            throw "Missing source image: $sourcePath"
        }
        if ($sourcePath -ne $targetPath -and (Test-Path -LiteralPath $targetPath)) {
            throw "Target image already exists: $targetPath"
        }
    }

    foreach ($mapping in $mappings) {
        $sourcePath = Join-Path $imageDirectory $mapping.Source
        $targetPath = Join-Path $imageDirectory $mapping.Target
        if ($sourcePath -ne $targetPath) {
            Move-Item -LiteralPath $sourcePath -Destination $targetPath
        }
    }

    foreach ($referencingMarkdownFile in $allMarkdownFiles) {
        $referencingText = [System.IO.File]::ReadAllText($referencingMarkdownFile.FullName)
        $updatedText = $referencingText
        foreach ($mapping in $mappings) {
            $updatedText = $updatedText.Replace("images/$($mapping.Source)", "images/$($mapping.Target)")
        }
        if ($updatedText -ne $referencingText) {
            [System.IO.File]::WriteAllText($referencingMarkdownFile.FullName, $updatedText, $utf8NoBom)
        }
    }
}

$mode = if ($Apply) { 'applied' } else { 'preview' }
Write-Output ("TOTAL: mode={0}, rename={1}, unmatched={2}" -f $mode, $totalRenames, $totalUnmatched)
