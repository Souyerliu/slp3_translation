param(
    [Parameter(Mandatory = $false)]
    [string]$RootDirectory = ".",

    [Parameter(Mandatory = $false)]
    [string]$FallbackImageDirectory = ".\MinerU-Skill\ed3book_aug26_3a047d\markdown\images"
)

$ErrorActionPreference = "Stop"

function Get-SafeName {
    param([string]$Text)

    $plain = [regex]::Replace($Text, '<[^>]+>', '')
    $plain = [Net.WebUtility]::HtmlDecode($plain)
    $plain = $plain -replace '[^\p{L}\p{Nd}._-]+', '_'
    $plain = ($plain -replace '_+', '_').Trim('_', '.')
    if ([string]::IsNullOrWhiteSpace($plain)) {
        $plain = "Section"
    }
    if ($plain.Length -gt 90) {
        $plain = $plain.Substring(0, 90).TrimEnd('_', '.')
    }
    return $plain
}

function Get-LocalImageReferences {
    param([string]$Text)

    $references = [Collections.Generic.List[string]]::new()
    foreach ($match in [regex]::Matches($Text, '!\[[^]]*\]\(([^)]+)\)')) {
        $references.Add($match.Groups[1].Value)
    }
    foreach ($match in [regex]::Matches($Text, '(?i)<img\b[^>]*\bsrc\s*=\s*["'']([^"'']+)["'']')) {
        $references.Add($match.Groups[1].Value)
    }
    return $references | Where-Object { $_ -notmatch '^(https?:|data:)' } | Sort-Object -Unique
}

$root = (Resolve-Path -LiteralPath $RootDirectory).Path
$fallbackImages = if (Test-Path -LiteralPath $FallbackImageDirectory) {
    (Resolve-Path -LiteralPath $FallbackImageDirectory).Path
} else {
    $null
}

$chapterDirectories = Get-ChildItem -LiteralPath $root -Directory -Filter 'Chapter *' | Sort-Object Name
if ($chapterDirectories.Count -ne 26) {
    throw "Expected 26 Chapter directories in $root, found $($chapterDirectories.Count)."
}

$plans = [Collections.Generic.List[object]]::new()
$imagesToRestore = [Collections.Generic.List[object]]::new()

foreach ($chapterDirectory in $chapterDirectories) {
    if ($chapterDirectory.Name -notmatch '^Chapter (\d{2})$') {
        throw "Unexpected chapter directory name: $($chapterDirectory.Name)"
    }
    $chapterNumber = [int]$matches[1]
    $markdownFiles = Get-ChildItem -LiteralPath $chapterDirectory.FullName -Filter '*.md' -File
    if ($markdownFiles.Count -ne 1) {
        throw "Expected one source Markdown file in $($chapterDirectory.Name), found $($markdownFiles.Count)."
    }
    $sourceMarkdown = $markdownFiles[0]
    $sectionsDirectory = Join-Path $chapterDirectory.FullName "sections"
    if (Test-Path -LiteralPath $sectionsDirectory) {
        throw "Destination already exists; refusing to overwrite: $sectionsDirectory"
    }

    $text = [IO.File]::ReadAllText($sourceMarkdown.FullName)
    $sourceBaseTitle = $sourceMarkdown.BaseName -replace '^\d{2}_', ''
    $boundaries = [Collections.Generic.List[object]]::new()
    $boundaries.Add([pscustomobject]@{
        Index = 0
        Kind = "intro"
        Label = ""
        Title = $sourceBaseTitle
    })

    $expectedSection = 1
    $terminalHeadings = @{}
    $headingMatches = [regex]::Matches($text, '(?m)^#{1,6}[ \t]+[^\r\n]*(?:\r?\n|$)')
    $numberPattern = [regex]::new(
        '(?<![\d.])' + [regex]::Escape("$chapterNumber.") + '(?<section>\d+)(?!\.)'
    )

    foreach ($headingMatch in $headingMatches) {
        $headingLine = $headingMatch.Value.TrimEnd("`r", "`n")
        $headingText = [regex]::Replace($headingLine, '^#{1,6}[ \t]+', '')
        $numberMatch = $numberPattern.Match($headingText)

        if ($numberMatch.Success -and [int]$numberMatch.Groups['section'].Value -eq $expectedSection) {
            $sectionLabel = "$chapterNumber.$expectedSection"
            $sectionTitle = $headingText.Substring($numberMatch.Index + $numberMatch.Length).Trim()
            $boundaries.Add([pscustomobject]@{
                Index = $headingMatch.Index
                Kind = "numbered"
                Label = $sectionLabel
                Title = $sectionTitle
            })
            $expectedSection++
            continue
        }

        $plainHeading = [regex]::Replace($headingText, '<[^>]+>', '').Trim()
        if ($plainHeading -in "Historical Notes", "Exercises" -and -not $terminalHeadings.ContainsKey($plainHeading)) {
            $boundaries.Add([pscustomobject]@{
                Index = $headingMatch.Index
                Kind = "terminal"
                Label = $plainHeading
                Title = $plainHeading
            })
            $terminalHeadings[$plainHeading] = $true
        }
    }

    $orderedBoundaries = @($boundaries | Sort-Object Index)
    $segments = [Collections.Generic.List[object]]::new()
    for ($i = 0; $i -lt $orderedBoundaries.Count; $i++) {
        $boundary = $orderedBoundaries[$i]
        $endIndex = if ($i + 1 -lt $orderedBoundaries.Count) {
            $orderedBoundaries[$i + 1].Index
        } else {
            $text.Length
        }
        $content = $text.Substring($boundary.Index, $endIndex - $boundary.Index).TrimEnd() + "`r`n"

        # Section files live one directory below the chapter, so keep image links valid.
        $content = [regex]::Replace(
            $content,
            '(!\[[^]]*\]\()images/',
            { param($match) $match.Groups[1].Value + '../images/' }
        )
        $content = [regex]::Replace(
            $content,
            '(?i)(\bsrc\s*=\s*["''])images/',
            { param($match) $match.Groups[1].Value + '../images/' }
        )

        $safeTitle = Get-SafeName $boundary.Title
        $fileName = if ($boundary.Kind -eq "intro") {
            "00_$safeTitle.md"
        } elseif ($boundary.Kind -eq "numbered") {
            "{0:D2}_{1}_{2}.md" -f $i, $boundary.Label, $safeTitle
        } else {
            "{0:D2}_{1}.md" -f $i, (Get-SafeName $boundary.Label)
        }

        $segments.Add([pscustomobject]@{
            Order = $i
            Kind = $boundary.Kind
            Label = $boundary.Label
            Title = $boundary.Title
            FileName = $fileName
            Content = $content
            ImageReferences = @(Get-LocalImageReferences $content)
        })
    }

    # Preflight every image used by the source, including HTML <img> references.
    foreach ($reference in @(Get-LocalImageReferences $text)) {
        $relativePath = ([Uri]::UnescapeDataString($reference) -replace '/', '\')
        $chapterImage = [IO.Path]::GetFullPath((Join-Path $chapterDirectory.FullName $relativePath))
        if (-not (Test-Path -LiteralPath $chapterImage -PathType Leaf)) {
            if ($fallbackImages) {
                $fallbackImage = Join-Path $fallbackImages ([IO.Path]::GetFileName($relativePath))
            } else {
                $fallbackImage = $null
            }
            if (-not $fallbackImage -or -not (Test-Path -LiteralPath $fallbackImage -PathType Leaf)) {
                throw "Missing image for $($sourceMarkdown.Name): $reference"
            }
            $imagesToRestore.Add([pscustomobject]@{
                Source = $fallbackImage
                Destination = $chapterImage
            })
        }
    }

    $plans.Add([pscustomobject]@{
        Chapter = $chapterDirectory.Name
        ChapterNumber = $chapterNumber
        SourceMarkdown = $sourceMarkdown.FullName
        SectionsDirectory = $sectionsDirectory
        Segments = $segments
        NumberedSectionCount = @($segments | Where-Object Kind -eq 'numbered').Count
    })
}

# All parsing and path checks succeeded; materialize the result.
foreach ($image in $imagesToRestore) {
    $destinationParent = Split-Path -Parent $image.Destination
    if (-not (Test-Path -LiteralPath $destinationParent)) {
        New-Item -ItemType Directory -Path $destinationParent -Force | Out-Null
    }
    Move-Item -LiteralPath $image.Source -Destination $image.Destination
}

foreach ($plan in $plans) {
    New-Item -ItemType Directory -Path $plan.SectionsDirectory | Out-Null
    $manifest = [Collections.Generic.List[object]]::new()
    foreach ($segment in $plan.Segments) {
        $outputPath = Join-Path $plan.SectionsDirectory $segment.FileName
        [IO.File]::WriteAllText($outputPath, $segment.Content, [Text.UTF8Encoding]::new($false))
        $manifest.Add([pscustomobject]@{
            Order = $segment.Order
            Kind = $segment.Kind
            Label = $segment.Label
            Title = $segment.Title
            File = $segment.FileName
            ImageCount = $segment.ImageReferences.Count
        })
    }
    $manifestPath = Join-Path $plan.SectionsDirectory "sections_manifest.json"
    $manifestJson = $manifest | ConvertTo-Json -Depth 4
    [IO.File]::WriteAllText($manifestPath, $manifestJson, [Text.UTF8Encoding]::new($false))
}

foreach ($plan in ($plans | Sort-Object ChapterNumber)) {
    [pscustomobject]@{
        Chapter = $plan.Chapter
        NumberedSections = $plan.NumberedSectionCount
        MarkdownParts = $plan.Segments.Count
        Output = $plan.SectionsDirectory
    }
}
