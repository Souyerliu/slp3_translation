param(
    [Parameter(Mandatory = $false)]
    [string]$MarkdownDirectory = ".\MinerU-Skill\ed3book_aug26_3a047d\markdown"
)

$ErrorActionPreference = "Stop"

$markdownRoot = (Resolve-Path -LiteralPath $MarkdownDirectory).Path
$rootPrefix = $markdownRoot.TrimEnd('\') + '\'
$markdownFiles = Get-ChildItem -LiteralPath $markdownRoot -Filter '*.md' -File | Sort-Object Name

if ($markdownFiles.Count -ne 26) {
    throw "Expected exactly 26 Markdown files in $markdownRoot, found $($markdownFiles.Count)."
}

$operations = [Collections.Generic.List[object]]::new()
$seenImages = @{}
$seenNumbers = @{}

foreach ($markdown in $markdownFiles) {
    if ($markdown.Name -notmatch '^(\d{2})_') {
        throw "Markdown filename does not begin with a two-digit chapter number: $($markdown.Name)"
    }

    $chapterNumber = [int]$matches[1]
    if ($chapterNumber -lt 1 -or $chapterNumber -gt 26 -or $seenNumbers.ContainsKey($chapterNumber)) {
        throw "Invalid or duplicate chapter number in $($markdown.Name)."
    }
    $seenNumbers[$chapterNumber] = $true

    $chapterDirectory = Join-Path $markdownRoot ("Chapter {0:D2}" -f $chapterNumber)
    if (Test-Path -LiteralPath $chapterDirectory) {
        throw "Destination already exists; refusing to overwrite: $chapterDirectory"
    }

    $text = [IO.File]::ReadAllText($markdown.FullName)
    $imageMatches = [regex]::Matches($text, '!\[[^]]*\]\(([^)]+)\)')
    $chapterImages = [Collections.Generic.List[object]]::new()

    foreach ($match in $imageMatches) {
        $reference = $match.Groups[1].Value
        if ($reference -match '^(https?:|data:)') {
            continue
        }

        $relativePath = ([Uri]::UnescapeDataString($reference) -replace '/', '\')
        $sourceImage = [IO.Path]::GetFullPath((Join-Path $markdownRoot $relativePath))
        if (-not $sourceImage.StartsWith($rootPrefix, [StringComparison]::OrdinalIgnoreCase)) {
            throw "Image reference escapes the Markdown directory: $reference"
        }
        if (-not (Test-Path -LiteralPath $sourceImage -PathType Leaf)) {
            throw "Referenced image is missing: $sourceImage"
        }
        if ($seenImages.ContainsKey($sourceImage)) {
            throw "Image is referenced by more than one chapter: $sourceImage"
        }
        $seenImages[$sourceImage] = $markdown.Name

        $destinationImage = [IO.Path]::GetFullPath((Join-Path $chapterDirectory $relativePath))
        $chapterPrefix = $chapterDirectory.TrimEnd('\') + '\'
        if (-not $destinationImage.StartsWith($chapterPrefix, [StringComparison]::OrdinalIgnoreCase)) {
            throw "Destination image path escapes the chapter directory: $reference"
        }

        $chapterImages.Add([pscustomobject]@{
            Source = $sourceImage
            Destination = $destinationImage
        })
    }

    $operations.Add([pscustomobject]@{
        Number = $chapterNumber
        Directory = $chapterDirectory
        MarkdownSource = $markdown.FullName
        MarkdownDestination = Join-Path $chapterDirectory $markdown.Name
        Images = $chapterImages
    })
}

$missingNumbers = 1..26 | Where-Object { -not $seenNumbers.ContainsKey($_) }
if ($missingNumbers) {
    throw "Missing chapter numbers: $($missingNumbers -join ', ')"
}

foreach ($operation in ($operations | Sort-Object Number)) {
    New-Item -ItemType Directory -Path $operation.Directory | Out-Null
    foreach ($image in $operation.Images) {
        $destinationParent = Split-Path -Parent $image.Destination
        if (-not (Test-Path -LiteralPath $destinationParent)) {
            New-Item -ItemType Directory -Path $destinationParent -Force | Out-Null
        }
        Move-Item -LiteralPath $image.Source -Destination $image.Destination
    }
    Move-Item -LiteralPath $operation.MarkdownSource -Destination $operation.MarkdownDestination
}

$result = foreach ($operation in ($operations | Sort-Object Number)) {
    [pscustomobject]@{
        Chapter = "Chapter {0:D2}" -f $operation.Number
        Markdown = [IO.Path]::GetFileName($operation.MarkdownDestination)
        Images = $operation.Images.Count
    }
}

$result
