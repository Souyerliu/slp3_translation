# 成分语法

[原始 PDF](../../MinerU-Skill/ed3book_aug26_3a047d/split_pdf/F.pdf)

*Because the Night*，Bruce Springsteen 与 Patti Smith

*The Fire Next Time*，James Baldwin

*If on a winter’s night a traveler*，Italo Calvino

*Love Actually*，Richard Curtis

*Suddenly Last Summer*，Tennessee Williams

*A Scanner Darkly*，Philip K. Dick

以上六个书名或作品名都不是句法成分；例子引自 Geoffrey K. Pullum 在 Language Log 上的文章（他指出这种现象罕见得惊人）。

语法研究有着悠久的历史。公元前 7 世纪至前 4 世纪之间的某个时期，印度语法学家波你尼（Pāṇini）在其名著《八篇书》（*Aṣṭādhyāyī*，“八卷”）中描述了梵语语法。英语 *syntax* 一词来自希腊语 *syntaxis*，意为“共同排列或安排”，指词语组合排列的方式。我们在前面的章节中已经接触过若干句法概念：词序列的次序（第 2 章）、这些词序列的概率（第 3 章），以及把词性范畴作为词的语法等价类（第 18 章）。本附录及其后的三个附录将介绍一系列远超这些简单方法的句法现象，以及能够以计算上实用的方式刻画它们的形式模型。

本附录大部分篇幅讨论**上下文无关语法**（context-free grammar）。上下文无关语法是自然语言（同样也是计算机语言）许多形式句法模型的骨干。因此，它在语法检查、语义解释、对话理解和机器翻译等众多计算应用中都有作用。它足以表达句中词语之间复杂的关系，同时又具有足够好的计算可处理性，存在高效算法可以用它分析句子（见第 19 章）。这里我们还将介绍**词汇化语法**的概念，并重点讨论其中一个例子：组合范畴语法（combinatory categorial grammar，CCG）。

第 20 章将介绍另一种有别于成分语法的形式语法模型——句法依存关系，并给出依存句法分析算法。成分形式体系和依存形式体系对语言处理都很重要。

最后，我们将简要概述英语语法，例子来自一个句子相对简单的领域——ATIS（航空旅行信息系统；Hemphill et al., 1990）。ATIS 是早期的口语系统，用户可以用 *I’d like to fly to Atlanta*（我想飞往亚特兰大）这样的句子来预订航班。

<table><tr><td>three parties from Brooklyn <strong>arrive</strong>...<br/>来自布鲁克林的三伙人到了……</td><td>a high-class spot such as Mindy&#x27;s <strong>attracts</strong>...<br/>像 Mindy&#x27;s 这样的高档场所吸引着……</td></tr><tr><td>the Broadway coppers <strong>love</strong>...<br/>百老汇的警察喜欢……</td><td>they <strong>sit</strong><br/>他们坐着</td></tr></table>
