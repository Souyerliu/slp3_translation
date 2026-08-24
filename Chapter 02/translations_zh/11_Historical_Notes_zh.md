## 历史说明

关于 Herdan 定律和 Heaps 定律的更多内容，参见 Herdan（1960，第 28 页）、Heaps（1978）、Egghe（2007）和 Baayen（2001）。

Unicode 借鉴了 ASCII 和 ISO 字符编码标准。早期草案是在 Xerox 与 Apple 工程师的讨论中制定的，初版标准草案于 1988 年发布，Unicode 标准则在 1991 年正式发布。后来成为 UTF-8 的方案始于 1989 年的 ISO 草案，并经历了多次扩展。1992 年，Ken Thompson 与 Rob Pike 在新泽西一家小餐馆的餐垫上勾勒出著名的自同步设计。

词语词元化及其他文本规范化算法自本领域诞生之初就已得到应用。其中包括 Lovins（1968）广泛使用的词干提取器等**词干提取**（stemming）方法，以及 Packard（1973）等人的数字人文应用；Packard 为古希腊语构建了一个剥离词缀的形态分析器。BPE 最初是 Gage（1994）提出的一种文本压缩方法，Sennrich et al.（2016）在早期神经机器翻译中将其用于子词词元化。之后，OpenAI 的 GPT-2（Radford et al., 2019）把它用作默认词元化方法，开源 SentencePiece 库也收录了这一算法（Kudo and Richardson, 2018）。Andrej Karpathy 提供了一个很好的公开实现 minbpe（https://github.com/karpathy/minbpe），他还制作了一场广受欢迎的 BPE 入门讲座（https://www.youtube.com/watch?v=zduSFxRajkE）。

Kleene（1951; 1956）最早在 McCulloch–Pitts 神经元的基础上定义了正则表达式和有限自动机。Ken Thompson 是最早把正则表达式编译器内置到编辑器、用于文本搜索的人之一（Thompson, 1968）。他的编辑器 ed 包含一条命令 `g/regular expression/p`，即 Global Regular Expression Print；它后来演变为 Unix 的 `grep` 工具。

NLTK 是一项重要工具，既提供实用的 Python 库（https://www.nltk.org），也以教材形式介绍许多算法，包括文本规范化和语料库接口（Bird et al., 2009）。

关于编辑距离的更多内容，参见 Gusfield（1997）。本章计算 intention 到 execution 之编辑距离的例子改编自 Kruskal（1983）。有多种公开软件包可以计算编辑距离，包括 Unix `diff` 和 NIST 的 `sclite` 程序（NIST, 2005）。

Bellman（1984）在自传中解释了自己最初如何想出“动态规划”这个名称：

> ……20 世纪 50 年代并不是数学研究的好年月。[当时的]国防部长……对“研究”这个词有一种病态的恐惧和憎恨……因此，我决定使用“规划”这个词。我想表达的是，这是动态的，是多阶段的……我想，不妨……选一个含义绝对明确的词，也就是“动态”……不可能以贬义使用“动态”这个词。试着想一想，怎样组合才能让它带上贬义？这是不可能的。因此，我觉得“动态规划”是个好名字，就连国会议员也无法反对它。
