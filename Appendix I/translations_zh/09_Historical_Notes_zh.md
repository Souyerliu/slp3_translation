# 历史说明

词义消歧的源头可以追溯到数字计算机最早期的一些应用。现代词义消歧算法所依据的洞见，最早由 Weaver（1949/1955）在机器翻译背景下明确提出：

> 如果逐个查看一本书中的词，就像透过一张不透明的面具、从一个只有一词宽的小孔中观察，那么显然不可能逐一确定这些词的意义。……但是，如果把不透明面具上的缝隙延长，直到不仅能看到中间那个词，还能看到它两侧各 $N$ 个词，那么只要 $N$ 足够大，就可以毫无歧义地判定中间词的意义。……实际问题是：“$N$ 至少要取多大，才能至少在相当一部分情形下，为中间词选出正确意义？”

这一早期阶段还首次提出了其他一些思想，包括使用叙词表进行消歧（Masterman, 1957）、以有监督方式训练用于消歧的贝叶斯模型（Madhu and Lytel, 1965），以及在词义分析中使用聚类（Sparck Jones, 1986）。

早期很多消歧研究是在面向人工智能的自然语言处理系统中开展的。Quillian（1968, 1969）提出一种基于图的语言处理方法：词的定义表示为由句法和语义关系连接的词节点网络，而义项消歧通过寻找图中各义项之间的最短路径实现。Simmons（1973）提出了另一种有影响力的早期语义网络方法。Wilks 以其偏好语义学（Preference Semantics；Wilks, 1975c, 1975b, 1975a）提出了最早的非离散模型之一；Small and Rieger（1982）以及 Riesbeck（1975）则提出了基于为每个词建模丰富程序性信息的理解系统。Hirst 的 ABSITY 系统（Hirst and Charniak, 1982；Hirst, 1987, 1988）使用一种基于语义网络、称为标记传递（marker passing）的技术，代表了这类系统中最先进的成果。与这些主要采用符号方法的研究相似，早期神经网络——当时称为“联结主义”——词义消歧方法也依赖小型词典及手工编码的表示（Cottrell, 1985；Kawamoto, 1988）。

最早实现稳健经验式义项消歧方法的是 Kelly and Stone（1975）；他们带领一个团队，为 1,790 个英语歧义词手工编写了一套消歧规则。Lesk（1986）最早使用机器可读词典进行词义消歧。Fellbaum（1998）汇集了 WordNet 的早期工作。把词典用作词汇资源的早期研究，还包括 Amsler 于 1981 年对 *Merriam-Webster Dictionary* 的使用，以及 *Longman Dictionary of Contemporary English*（Boguraev and Briscoe, 1989）。

有监督消歧方法始于 Black（1988）对决策树的使用。除了 IMS 以及基于上下文嵌入的有监督 WSD 方法外，近年的有监督算法还包括编码器—解码器模型（Raganato et al., 2017a）。

有监督方法需要大量标注文本，这很早就促使研究者探索自举法（Hearst, 1991；Yarowsky, 1995）。例如，Diab and Resnik（2002）的半监督算法基于两种语言的对齐平行语料。法语词 *catastrophe* 在一个实例中可能译成英语 *disaster*，在另一个实例中则可能译成 *tragedy*；这一事实可以用来消解两个英语词的义项，即选择彼此相似的 *disaster* 与 *tragedy* 义项。

Sparck Jones（1986）最早在词义研究中使用聚类；Pedersen and Bruce（1997）、Schütze（1997, 1998）则应用了分布式方法。把词义聚合成粗粒度义项，也被用于解决词典义项过细的问题（I.5.3 节）（Dolan, 1994；Chen and Chang, 1998；Mihalcea and Moldovan, 2001；Agirre and de Lacalle, 2003；Palmer et al., 2004；Navigli, 2006；Snow et al., 2007；Pilehvar et al., 2013）。用于训练有监督聚类算法的义项聚类语料库包括 Palmer et al.（2006）以及 OntoNotes（Hovy et al., 2006）。

关于多义性表示的计算方法，参见 Pustejovsky（1995）、Pustejovsky and Boguraev（1996）、Martin（1986）和 Copestake and Briscoe（1995）等。Pustejovsky 的生成词库理论，尤其是他的词语物性结构（qualia structure）理论，是解释词在语境中动态、系统性多义现象的一种方式。

WSD 的历史综述可参见 Agirre and Edmonds（2006）和 Navigli（2009）。
