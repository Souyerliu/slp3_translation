param(
    [Parameter(Mandatory = $false)]
    [string]$SourcePdf = ".\ed3book_aug26.pdf"
)

$ErrorActionPreference = "Stop"

$sourceItem = Get-Item -LiteralPath $SourcePdf
$sourcePath = $sourceItem.FullName
$sourceName = [IO.Path]::GetFileNameWithoutExtension($sourceItem.Name)
$safeName = ($sourceName -replace '[^\p{L}\p{Nd}._-]+', '_') -replace '_+', '_'
$sourceBytes = [Text.Encoding]::UTF8.GetBytes($sourcePath)
$md5 = [Security.Cryptography.MD5]::Create()
try {
    $hashBytes = $md5.ComputeHash($sourceBytes)
} finally {
    $md5.Dispose()
}
$hash = ([BitConverter]::ToString($hashBytes) -replace '-', '').ToLower().Substring(0, 6)

$outputRoot = Join-Path (Get-Location) "MinerU-Skill\${safeName}_${hash}"
$splitDir = Join-Path $outputRoot "split_pdf"
$markdownDir = Join-Path $outputRoot "markdown"
New-Item -ItemType Directory -Path $splitDir, $markdownDir -Force | Out-Null

$savedPreference = $ErrorActionPreference
$ErrorActionPreference = "SilentlyContinue"
$jsonLines = & qpdf --json --json-key=outlines -- $sourcePath 2>$null
$qpdfExitCode = $LASTEXITCODE
$ErrorActionPreference = $savedPreference
if ($qpdfExitCode -notin 0, 3) {
    throw "qpdf could not read the PDF outlines (exit code $qpdfExitCode)."
}
$outlineJson = ($jsonLines -join "`n") | ConvertFrom-Json

$entries = [Collections.Generic.List[object]]::new()
foreach ($part in $outlineJson.outlines) {
    foreach ($item in $part.kids) {
        $entries.Add([pscustomobject]@{
            Part = [string]$part.title
            Title = [string]$item.title
            StartPage = [int]$item.destpageposfrom1
        })
    }
}

if ($entries.Count -ne 28) {
    throw "Expected 28 level-2 bookmarks (26 chapters + bibliography + index), found $($entries.Count)."
}
if ($entries[26].Title -ne "Bibliography" -or $entries[27].Title -ne "Subject Index") {
    throw "The final level-2 bookmarks are not Bibliography and Subject Index."
}

$ErrorActionPreference = "SilentlyContinue"
$pageCountText = & qpdf --show-npages -- $sourcePath 2>$null
$qpdfExitCode = $LASTEXITCODE
$ErrorActionPreference = $savedPreference
if ($qpdfExitCode -notin 0, 3) {
    throw "qpdf could not determine the page count (exit code $qpdfExitCode)."
}
$pageCount = [int]($pageCountText | Select-Object -Last 1)

$manifest = [Collections.Generic.List[object]]::new()
$minerUInputs = [Collections.Generic.List[string]]::new()

for ($i = 0; $i -lt $entries.Count; $i++) {
    $entry = $entries[$i]
    $endPage = if ($i + 1 -lt $entries.Count) {
        $entries[$i + 1].StartPage - 1
    } else {
        $pageCount
    }
    $number = $i + 1
    $safeTitle = (($entry.Title -replace '[^\p{L}\p{Nd}._-]+', '_') -replace '_+', '_').Trim('_')
    $fileName = "{0:D2}_{1}.pdf" -f $number, $safeTitle
    $outputPdf = Join-Path $splitDir $fileName

    if (Test-Path -LiteralPath $outputPdf) {
        $ErrorActionPreference = "SilentlyContinue"
        $existingPageCountText = & qpdf --show-npages -- $outputPdf 2>$null
        $qpdfExitCode = $LASTEXITCODE
        $ErrorActionPreference = $savedPreference
        $existingPageCount = [int]($existingPageCountText | Select-Object -Last 1)
        if ($qpdfExitCode -notin 0, 3 -or $existingPageCount -ne ($endPage - $entry.StartPage + 1)) {
            throw "Existing output is incomplete or invalid; refusing to overwrite: $outputPdf"
        }
    } else {
        $ErrorActionPreference = "SilentlyContinue"
        & qpdf --empty --pages $sourcePath "$($entry.StartPage)-$endPage" -- $outputPdf 2>$null
        $qpdfExitCode = $LASTEXITCODE
        $ErrorActionPreference = $savedPreference
        if ($qpdfExitCode -notin 0, 3 -or -not (Test-Path -LiteralPath $outputPdf)) {
            throw "Failed to create $fileName (qpdf exit code $qpdfExitCode)."
        }
    }

    $kind = if ($number -le 26) { "chapter" } elseif ($number -eq 27) { "bibliography" } else { "index" }
    $manifest.Add([pscustomobject]@{
        Number = $number
        Kind = $kind
        Part = $entry.Part
        Title = $entry.Title
        StartPage = $entry.StartPage
        EndPage = $endPage
        PageCount = $endPage - $entry.StartPage + 1
        Pdf = "split_pdf/$fileName"
    })

    if ($number -le 26) {
        $minerUInputs.Add($outputPdf)
    }
}

$manifestPath = Join-Path $outputRoot "manifest.json"
if (Test-Path -LiteralPath $manifestPath) {
    throw "Manifest already exists; refusing to overwrite: $manifestPath"
}
$manifestJson = $manifest | ConvertTo-Json -Depth 4
[IO.File]::WriteAllText($manifestPath, $manifestJson, [Text.UTF8Encoding]::new($false))

$inputListPath = Join-Path $outputRoot "mineru_input.txt"
if (Test-Path -LiteralPath $inputListPath) {
    throw "MinerU input list already exists; refusing to overwrite: $inputListPath"
}
[IO.File]::WriteAllLines($inputListPath, $minerUInputs, [Text.UTF8Encoding]::new($false))

[pscustomobject]@{
    OutputRoot = $outputRoot
    SplitCount = $manifest.Count
    ChapterCount = $minerUInputs.Count
    Manifest = $manifestPath
    MinerUInputList = $inputListPath
    MarkdownOutput = $markdownDir
}
