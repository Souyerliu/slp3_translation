param(
    [Parameter(Mandatory = $false)]
    [string]$TranslationDirectory = ".\Chapter 01\translations_zh"
)

$ErrorActionPreference = "Stop"
$translationRoot = (Resolve-Path -LiteralPath $TranslationDirectory).Path
$files = Get-ChildItem -LiteralPath $translationRoot -Filter '*_zh.md' -File

$phrases = @(
    '大语言模型（large language model，LLM）',
    '自然语言处理（natural language processing，NLP）',
    '计算语言学（computational linguistics）',
    '口语语言处理（spoken language processing）',
    '语音识别（speech recognition）',
    '语言建模（language modeling）',
    '人工智能（artificial intelligence，AI）',
    'LLM 智能体（agent）',
    '自动语音识别（automatic speech recognition，ASR）',
    '安全（safety）',
    '对齐（alignment）',
    '词元化（tokenization）',
    '嵌入（embedding）',
    '后训练（post-training）',
    '语言模型（language model）',
    '采样（sampling）',
    '因果语言模型（causal language model）',
    '自回归语言模型（autoregressive language model）',
    '词元（token）',
    'n 元语言模型（n-gram language model）',
    '困惑度（perplexity）',
    '参数（parameter）',
    '权重（weight）',
    '偏置（bias）',
    '缩放定律（scaling laws）',
    '分布假说（distributional hypothesis，第 5 章）',
    '落地信息（grounding）',
    '预训练（pretraining）',
    '提示（prompt）',
    '条件生成（conditional generation）',
    '指令微调（instruction tuning）',
    '香农游戏（Shannon game）',
    '神经网络（neural network）',
    '梯度下降（gradient descent，第 4 章）',
    '开放权重模型（open-weight model）',
    '闭合权重模型（closed-weight model）',
    '专有模型（proprietary model）',
    '经验主义的长期复兴（long revival of empiricism）',
    '联结主义（connectionism）',
    '并行分布式处理（parallel distributed processing）',
    '提示方法（prompting）',
    '生成式人工智能（generative AI）',
    '句法结构（syntactic structure，第 20 章）',
    '句法分析（parsing）',
    '共指（coreference，第 24 章）',
    '可解释性（interpretability）',
    '注意力头（attention head，第 7 章）',
    '先行词（antecedent）',
    '共同基础（common ground）',
    '落地确认（grounding）',
    '谄媚迎合（sycophancy）',
    '过度自信（overconfidence）',
    '推理（inference）',
    '基础模型（base model）',
    '监督式微调（supervised fine-tuning，SFT）',
    '偏好对齐（preference alignment）',
    '强化学习（reinforcement learning，RL）',
    '交叉熵损失（cross-entropy loss）',
    '以数据为中心的 AI（data-centric AI）',
    '指令式微调（instruction fine-tuning）',
    '“指令式微调”（instruction fine-tuning）',
    '元学习（meta-learning）',
    '偏好判断（preference judgment）',
    '奖励函数（reward function）',
    '可验证领域（verifiable domain）',
    '思维链（chain-of-thought）',
    '指令遵循（instruction-following）',
    '“指令遵循”（instruction-following）',
    '强化学习（RL）',
    '采用可验证奖励的强化学习（Reinforcement Learning with Verifiable Rewards，RLVR）',
    '提示工程（prompt engineering）',
    '演示（demonstration）',
    '少样本提示（few-shot prompting）',
    '零样本提示（zero-shot prompting）',
    '单样本提示（1-shot prompt，即含 1 个演示）',
    '系统提示（system prompt）',
    '测试时计算（test-time compute）',
    '思维链提示（chain-of-thought prompting）',
    '温度（temperature）',
    '上下文学习（in-context learning）',
    '智能体（agent）',
    '推理（Reason）',
    '行动（Action）',
    '观察（Observation）',
    '准确度（accuracy）',
    '测试集（test set）',
    '未见的（unseen）',
    '基准（benchmark）',
    'MMLU（Massive Multitask Language Understanding，大规模多任务语言理解）',
    '数据污染（data contamination）',
    'LLM 评判（LLM-as-a-judge）',
    '替代指标（proxy metric）',
    "古德哈特定律（Goodhart’s Law）",
    '词错误率（word error rate，第 16 章）',
    'AI 安全（AI safety）',
    '价值对齐（value alignment）',
    '用户层面的危害（user-level harm）',
    '技能退化（de-skilling）',
    '谄媚迎合（sycophantic）',
    '表征性危害（representational harm）',
    '生存风险（existential risk）',
    '提示注入（prompt injection）',
    '社会技术问题（sociotechnical problem）',
    '价值敏感设计（value sensitive design）',
    '机构审查委员会（Institutional Review Board，IRB）',
    '宪法式 AI（constitutional AI）',
    '红队测试（red teaming）',
    '幻觉（hallucination）',
    '校准（calibration）',
    '拟人化（anthropomorphism）',
    '意向立场（intentional stance）',
    '能动性（agency）',
    '意向性（intentionality）'
)
$phrases = @($phrases | Sort-Object -Unique | Sort-Object { $_.Length } -Descending)

$keywordCount = 0
$captionCount = 0

foreach ($file in $files) {
    $content = [IO.File]::ReadAllText($file.FullName)

    # This formatter owns all bold markup in these new translation files. Reset the
    # prior formatting pass so a rerun is deterministic and cannot nest markers.
    $content = $content.Replace('**', '')

    $protectedTerms = @{}
    $placeholderIndex = 0

    foreach ($phrase in $phrases) {
        $matches = [regex]::Matches($content, [regex]::Escape($phrase)).Count
        if ($matches -gt 0) {
            $parenthesisIndex = $phrase.IndexOf('（')
            $term = $phrase.Substring(0, $parenthesisIndex)
            $explanation = $phrase.Substring($parenthesisIndex)
            $hanCharacters = [regex]::Matches($term, '\p{IsCJKUnifiedIdeographs}')
            if ($hanCharacters.Count -eq 0) {
                continue
            }
            $firstHan = $hanCharacters[0].Index
            $lastHan = $hanCharacters[$hanCharacters.Count - 1].Index
            $termPrefix = $term.Substring(0, $firstHan)
            $chineseKeyword = $term.Substring($firstHan, $lastHan - $firstHan + 1)
            $termSuffix = $term.Substring($lastHan + 1)
            $formattedPhrase = "$termPrefix**$chineseKeyword**$termSuffix$explanation"

            $placeholder = "[[[BOLD_TERM_$placeholderIndex]]]"
            $content = $content.Replace($phrase, $placeholder)
            $protectedTerms[$placeholder] = $formattedPhrase
            $placeholderIndex++
            $keywordCount += $matches
        }
    }

    foreach ($placeholder in $protectedTerms.Keys) {
        $content = $content.Replace($placeholder, $protectedTerms[$placeholder])
    }

    # Numbered captions, excluding narrative paragraphs that merely begin with a figure reference.
    $captionPattern = '(?m)^(图 1\.\d+ (?!展示|更清楚|的第一个)[^\r\n]+)$'
    $captionMatches = [regex]::Matches($content, $captionPattern).Count
    $content = [regex]::Replace($content, $captionPattern, '**$1**')
    $captionCount += $captionMatches

    $portraitCaption = 'Richard Rothwell 绘制的 Mary Shelley 肖像，National Portrait Gallery，CC BY-NC-ND 3.0。'
    if ($content.Contains($portraitCaption)) {
        $content = $content.Replace($portraitCaption, "**$portraitCaption**")
        $captionCount++
    }

    [IO.File]::WriteAllText($file.FullName, $content, [Text.UTF8Encoding]::new($false))
}

[pscustomobject]@{
    Files = $files.Count
    KeywordOccurrencesBolded = $keywordCount
    CaptionsBolded = $captionCount
}
