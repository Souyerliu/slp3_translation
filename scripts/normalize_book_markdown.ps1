[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repoRoot = Split-Path -Parent $PSScriptRoot
$publishedChapters = @('Chapter 01', 'Chapter 07', 'Chapter 08', 'Chapter 09', 'Chapter 10')

$pdfByChapter = @{
    'Chapter 01' = '01_Introduction.pdf'
    'Chapter 07' = '07_Transformers_and_Pretraining.pdf'
    'Chapter 08' = '08_Post-training.pdf'
    'Chapter 09' = '09_Masked_Language_Models.pdf'
    'Chapter 10' = '10_Interpretability.pdf'
}

$exactLineReplacements = @{
    "## Anyhow,·she's·seen·Jane's·224123·flowers·anyhow!" = "> Anyhow,·she's·seen·Jane's·224123·flowers·anyhow!"
    "## Q: Who wrote ‘‘The Origin of Species`"? A:" = "> Q: Who wrote ‘‘The Origin of Species`"? A:"
    "## Q: Who wrote ‘‘The Origin of Species`"? A: Charles" = "> Q: Who wrote ‘‘The Origin of Species`"? A: Charles"
    '## (1.9) A: Can you hand me the box? [in a context with two boxes] B: Which one?' = '> (1.9) A: Can you hand me the box? [in a context with two boxes] B: Which one?'
    "## (7.3) The chicken didn’t cross the road because it" = "> (7.3) The chicken didn’t cross the road because it"
}

$utf8NoBom = [System.Text.UTF8Encoding]::new($false)

foreach ($chapter in $publishedChapters) {
    $translationDir = Join-Path $repoRoot "$chapter\translations_zh"
    $files = Get-ChildItem -LiteralPath $translationDir -Filter '*.md' | Sort-Object Name

    foreach ($file in $files) {
        $lines = [System.Collections.Generic.List[string]]::new()
        foreach ($line in [System.IO.File]::ReadAllLines($file.FullName, [System.Text.Encoding]::UTF8)) {
            $lines.Add($line)
        }

        $firstHeadingIndex = -1
        for ($index = 0; $index -lt $lines.Count; $index++) {
            if ($lines[$index] -match '^#{1,6} ') {
                $firstHeadingIndex = $index
                break
            }
        }

        if ($firstHeadingIndex -lt 0) {
            throw "Missing heading: $($file.FullName)"
        }

        if ($lines[$firstHeadingIndex] -match '^## ') {
            $lines[$firstHeadingIndex] = $lines[$firstHeadingIndex] -replace '^## ', '# '
        }

        for ($index = 0; $index -lt $lines.Count; $index++) {
            if ($exactLineReplacements.ContainsKey($lines[$index])) {
                $lines[$index] = $exactLineReplacements[$lines[$index]]
            }
        }

        if ($file.Name -eq '06_Historical_Notes_zh.md' -and $chapter -eq 'Chapter 08') {
            for ($index = 0; $index -lt $lines.Count; $index++) {
                if ($lines[$index] -eq '# 第二卷') {
                    $lines[$index] = '## 第二卷'
                }
                elseif ($lines[$index] -eq '# 高级 LLM 主题与工具') {
                    $lines[$index] = '### 高级 LLM 主题与工具'
                }
            }
        }

        if ($file.Name -eq '04_8.4_LLM_Alignment_via_Preference-Based_Learning_zh.md') {
            for ($index = 0; $index -lt $lines.Count; $index++) {
                if ($lines[$index] -eq '## 8.4.1 使用偏好反馈的强化学习（PPO）待补充') {
                    $lines[$index] = '## 8.4.1 使用偏好反馈的强化学习（PPO）'
                    $lines.Insert($index + 1, '')
                    $lines.Insert($index + 2, ':::{warning} 译文待补充')
                    $lines.Insert($index + 3, '本小节的中文译文尚未补充完整。')
                    $lines.Insert($index + 4, ':::')
                    break
                }
            }
        }

        if ($file.Name -eq '07_Historical_Notes_zh.md' -and $chapter -eq 'Chapter 09') {
            for ($index = 0; $index -lt $lines.Count; $index++) {
                if ($lines[$index] -eq '历史内容待补充。') {
                    $lines[$index] = ':::{warning} 译文待补充'
                    $lines.Insert($index + 1, '本节的中文历史说明尚未补充完整。')
                    $lines.Insert($index + 2, ':::')
                    break
                }
            }
        }

        if ($file.Name -like '00_*_zh.md') {
            $pdfFile = $pdfByChapter[$chapter]
            $pdfRelativePath = "../../MinerU-Skill/ed3book_aug26_3a047d/split_pdf/$pdfFile"
            $pdfLink = "[原始 PDF]($pdfRelativePath)"
            if (-not ($lines -contains $pdfLink)) {
                $headingIndex = -1
                for ($index = 0; $index -lt $lines.Count; $index++) {
                    if ($lines[$index] -match '^# ') {
                        $headingIndex = $index
                        break
                    }
                }
                $lines.Insert($headingIndex + 1, '')
                $lines.Insert($headingIndex + 2, $pdfLink)
            }
        }

        # Keep standalone images in their own Markdown paragraphs. Without the
        # surrounding blank lines, MyST may merge the image with adjacent text
        # or its caption and render it as an inline, undersized image.
        $imagePattern = '^\s*!\[[^\]]*\]\([^\)]+\)\s*$'
        $spacedLines = [System.Collections.Generic.List[string]]::new()
        for ($index = 0; $index -lt $lines.Count; $index++) {
            $line = $lines[$index]
            if ($line -match $imagePattern) {
                if ($spacedLines.Count -gt 0 -and $spacedLines[$spacedLines.Count - 1].Length -gt 0) {
                    $spacedLines.Add('')
                }

                $spacedLines.Add($line.TrimEnd())

                if ($index + 1 -lt $lines.Count -and $lines[$index + 1].Length -gt 0) {
                    $spacedLines.Add('')
                }
            }
            else {
                $spacedLines.Add($line)
            }
        }
        $lines = $spacedLines

        $normalized = ([string]::Join("`n", $lines)).TrimEnd() + "`n"
        [System.IO.File]::WriteAllText($file.FullName, $normalized, $utf8NoBom)
    }
}

Write-Host 'Normalized published Markdown pages.'



