[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$publishedChapters = @('Chapter 01', 'Chapter 07', 'Chapter 08', 'Chapter 09', 'Chapter 10')
$errors = [System.Collections.Generic.List[string]]::new()
$warnings = [System.Collections.Generic.List[string]]::new()
$files = [System.Collections.Generic.List[System.IO.FileInfo]]::new()

foreach ($chapter in $publishedChapters) {
    $translationDir = Join-Path $repoRoot "$chapter\translations_zh"
    foreach ($file in Get-ChildItem -LiteralPath $translationDir -Filter '*.md') {
        $files.Add($file)
    }
}

if ($files.Count -ne 47) {
    $errors.Add("Expected 47 published Markdown pages, found $($files.Count).")
}

foreach ($file in $files) {
    $relativeFile = $file.FullName.Substring($repoRoot.Length) -replace '^[\\/]+', ''
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $lines = [System.IO.File]::ReadAllLines($file.FullName, [System.Text.Encoding]::UTF8)
    $headings = @($lines | Where-Object { $_ -match '^#{1,6} ' })
    $h1Count = @($lines | Where-Object { $_ -match '^# ' }).Count

    if ($headings.Count -eq 0 -or $headings[0] -notmatch '^# ') {
        $errors.Add("First heading is not H1: $relativeFile")
    }
    if ($h1Count -ne 1) {
        $errors.Add("Expected exactly one H1, found ${h1Count}: $relativeFile")
    }

    foreach ($pattern in @(
        '^## Anyhow,',
        '^## Q:',
        '^## \([0-9]+\.[0-9]+\)'
    )) {
        if ($content -match "(?m)$pattern") {
            $errors.Add("Suspicious example formatted as heading: $relativeFile")
        }
    }

    foreach ($match in [regex]::Matches($content, '!\[[^\]]*\]\((?<path>[^)]+)\)')) {
        $rawPath = $match.Groups['path'].Value.Split(' ')[0].Trim('<', '>')
        if ($rawPath -notmatch '^(https?:|data:)') {
            $target = [System.IO.Path]::GetFullPath((Join-Path $file.DirectoryName $rawPath))
            if (-not (Test-Path -LiteralPath $target)) {
                $errors.Add("Missing image '$rawPath' in $relativeFile")
            }
        }
    }

    $standaloneImagePattern = '^\s*!\[[^\]]*\]\([^\)]+\)\s*$'
    for ($index = 0; $index -lt $lines.Count; $index++) {
        if ($lines[$index] -match $standaloneImagePattern) {
            $lineNumber = $index + 1
            if ($index -gt 0 -and $lines[$index - 1].Length -gt 0) {
                $errors.Add("Missing blank line before image at ${relativeFile}:${lineNumber}")
            }
            if ($index + 1 -lt $lines.Count -and $lines[$index + 1].Length -gt 0) {
                $errors.Add("Missing blank line after image at ${relativeFile}:${lineNumber}")
            }
        }
    }

    if ($file.Name -like '00_*_zh.md') {
        $pdfMatch = [regex]::Match($content, '\[原始 PDF\]\((?<path>[^)]+\.pdf)\)')
        if (-not $pdfMatch.Success) {
            $errors.Add("Missing original PDF link: $relativeFile")
        }
        else {
            $pdfTarget = [System.IO.Path]::GetFullPath((Join-Path $file.DirectoryName $pdfMatch.Groups['path'].Value))
            if (-not (Test-Path -LiteralPath $pdfTarget)) {
                $errors.Add("Missing original PDF target: $relativeFile")
            }
        }
    }

    if ($content -match '译文待补充|待补充') {
        $warnings.Add("Incomplete translation marker: $relativeFile")
    }
}

foreach ($requiredFile in @('myst.yml', 'toc.yml', 'book/index.md', 'book/progress.md', 'book/about.md', 'book/static/book.css', 'LXGWWenKai-Regular.ttf')) {
    if (-not (Test-Path -LiteralPath (Join-Path $repoRoot $requiredFile))) {
        $errors.Add("Missing required book file: $requiredFile")
    }
}

Write-Host "Checked $($files.Count) published Markdown pages."
foreach ($warning in $warnings) {
    Write-Warning $warning
}

if ($errors.Count -gt 0) {
    foreach ($message in $errors) {
        Write-Error $message
    }
    exit 1
}

Write-Host "Book source checks passed with $($warnings.Count) known content warning(s)."


