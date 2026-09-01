# 历史说明

概率上下文无关文法的许多形式性质最早由 Booth（1969）和 Salomaa（1969）给出。Baker（1979）提出用 inside–outside 算法无监督训练 PCFG 概率，并使用 CKY 风格的算法计算 inside 概率。Jelinek 和 Lafferty（1991）扩展 CKY 以计算前缀概率；Stolcke（1995）则把 Earley 算法改造为适用于 PCFG 的形式。

从 20 世纪 90 年代初开始，许多研究尝试向 PCFG 加入词汇依存关系，并让规则概率对周围句法结构更敏感。Schabes 等（1988）及 Schabes（1990）较早研究了中心语的使用。1990 年 6 月 DARPA Speech and Natural Language Workshop 上首次发表了许多有关词汇依存的论文。Hindle 和 Rooth（1990）把词汇依存用于介词短语附着；在之后一篇论文的提问环节中，Ken Church 建议把这种方法推广到完整句法分析（Marcus, 1990）。把概率依存信息加入概率 CFG 的早期工作包括 Magerman 和 Marcus（1991）、Black 等（1992）、Bod（1993）与 Jelinek 等（1994），以及正文讨论的 Collins（1996, 1999）和 Charniak（1997）。较新的 PCFG 模型还包括 Klein 和 Manning（2003a）以及 Petrov 等（2006）。

早期词汇概率研究首先促进了对具体句法问题的探索，例如利用基于转换的学习（Brill and Resnik, 1994）、最大熵（Ratnaparkhi et al., 1994）、基于记忆的学习（Zavrel and Daelemans, 1997）、对数线性模型（Franz, 1997）、使用中心语之间语义距离的决策树（Stetina and Nagao, 1997）以及 boosting（Abney et al., 1999）解决介词短语附着。另一条路线把概率词汇句法分析推广到 PCFG 之外的语法形式，包括概率 TAG（Resnik, 1992; Schabes, 1992）、概率 LR 句法分析（Briscoe and Carroll, 1993）和概率 link grammar（Lafferty et al., 1992）。正文所见的 CCG 超标注方法最初为 TAG 开发（Bangalore and Joshi, 1999; Joshi and Srinivas, 1994），建立在 Schabes 等（1988）的词汇化 TAG 上。
