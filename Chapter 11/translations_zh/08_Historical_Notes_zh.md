# 历史说明

问答是最早的 NLP 任务之一。到 1961 年，BASEBALL 系统（Green et al., 1961）已经能够查询由比赛信息构成的结构化数据库，回答“红袜队 7 月 7 日在哪里比赛？”之类的问题。数据库以一种属性—值矩阵的形式存储，每场比赛的属性都有相应取值：

```txt
Place = ?
```

Team = Red Sox  
Month = July  
Day = 7

```txt
Month = July
    Place = Boston
    Day = 7
    Game Serial No. = 96
    (Team = Red Sox, Score = 5)
    (Team = Yankees, Score = 3)
```

系统先使用宾夕法尼亚大学 Zellig Harris 的 TDAP 项目算法，对每个问题进行成分句法分析；本质上，这是一串有限状态转换器（历史讨论见 Joshi and Hopely 1999 与 Karttunen 1999）。随后，在内容分析阶段，每个词或短语都与一段计算其部分意义的程序相关联。因此，短语 Where 带有将语义赋为 `Place = ?` 的代码，使问题“Where did the Red Sox play on July 7”获得上述意义。

系统再把问题与数据库匹配，返回答案。

Simmons et al.（1964）的 Protosynthex 系统会根据问题中的实词构造查询，再从文档中检索候选答案句子，并按它们与问题之间经频率加权的词项重叠程度排序。随后，系统使用依存句法分析器分析查询和每个检索句子，选出结构与问题最匹配的句子。因此，问题 *What do worms eat?* 会与 *worms eat grass* 匹配：在当时使用的依存语法版本中，二者都以 worms 为 eat 的主语依存项，而 *birds eat worms* 的主语则是 birds：

![](../images/a88e487b052c8632103c1426b1ba6e771fb4784fa6d1f96e5c22f8632defb767.jpg)

Simmons（1965）总结了其他早期问答系统。

到 20 世纪 70 年代，系统开始使用谓词演算作为意义表示语言。LUNAR 系统（Woods et al. 1972; Woods 1978）旨在为月球地质化学事实数据库提供自然语言接口。它可以把“是否有任何样本的铝含量超过 13%？”之类的问题分析成如下逻辑形式并作答：

```txt
(TEST (FOR SOME X16 / (SEQ SAMPLES) : T ; (CONTAIN’ X16 (NPR* X17 / (QUOTE AL203)) (GREATERTHAN 13 PCT))))
```

到 20 世纪 90 年代，问答开始转向机器学习。Zelle and Mooney（1996）提出把问答视为语义分析任务，并创建了基于 Prolog、包含美国地理问题的 GEOQUERY 数据集。Zettlemoyer and Collins（2005, 2007）扩展了该模型。十年后，神经模型被用于语义分析（Dong and Lapata 2016; Jia and Liang 2016），又通过把文本映射到 SQL 用于基于知识的问答（Iyer et al., 2017）。

[待补：信息检索史。]

与此同时，20 世纪 90 年代互联网的兴起影响了另一种更多借助信息检索的问答范式。美国政府资助的 TREC（Text REtrieval Conference，文本检索会议）评测自 1992 年起每年举行，为评估信息检索任务与技术提供了测试平台（Voorhees and Harman, 2005）。TREC 于 1999 年增设了影响深远的问答赛道，促使各种事实型和非事实型问答系统参加每年的评测。

同一时期，Hirschman et al.（1999）提出使用儿童阅读理解测试来评估机器文本理解算法。他们收集了 120 个篇章，每个篇章附有 5 个为三至六年级儿童设计的问题；随后构建答案抽取系统，并测量其答案与测试出版方答案之间的吻合程度。该算法以词语重叠为主要特征；后来的算法又加入命名实体特征，以及问题与答案跨度之间更复杂的相似度（Riloff and Thelen 2000; Ng et al. 2000）。

Watson *Jeopardy!* 系统的 DeepQA 组件，是神经系统普及前夕开发的一套规模庞大而复杂、基于特征的系统。*IBM Journal of Research and Development* 第 56 卷的一系列论文对其有所介绍，例如 Ferrucci（2012）。

早期神经阅读理解系统继承了早期系统的一个共同认识：寻找答案应聚焦于问题—篇章相似度。Hermann et al.（2015）、Chen et al.（2017a）和 Seo et al.（2017）奠定了这类神经系统的许多架构轮廓。这些系统聚焦于 Rajpurkar et al.（2016, 2018）及其后续数据集，通常以独立 IR 算法作为神经阅读理解系统的输入。Lee et al.（2019）或 Karpukhin et al.（2020）等系统，是使用稠密检索与基于跨度的阅读器（通常采用单一端到端架构）这一范式的代表。开放域问答中的稠密检索有一项重要研究主题是训练数据：使用自监督方法，免去标注正例和负例篇章的需要（Sachan et al., 2023）。

关于大语言模型的早期工作表明，模型在预训练过程中存储了足以回答问题的知识（Petroni et al., 2019; Raffel et al., 2020; Radford et al., 2019; Roberts et al., 2020）。起初，它们的表现不及专用问答系统，但很快便超越了后者。检索增强生成算法最初用于改进语言建模中的词语预测（Khandelwal et al., 2019），但很快被应用于问答（Izacard et al., 2022; Ram et al., 2023; Shi et al., 2023）。
