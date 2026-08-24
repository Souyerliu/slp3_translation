## 历史注记

向量语义学的思想源自 20 世纪 50 年代三个不同领域的研究：语言学、心理学和计算机科学，三者分别贡献了模型的一个基本方面。

20 世纪 50 年代的语言学理论普遍认为，意义与词在语境中的分布有关。持这一观点的既有 Zellig Harris、Martin Joos、J. R. Firth 等分布主义者，也有 Thomas Sebeok 等符号学家。Joos（1950）写道：

> 语言学家所说的一个语素的“意义”……按定义，就是它与所有其他语素共同出现在语境中的条件概率集合。

“词义可以建模为多维语义空间中的点”这一思想来自 Charles E. Osgood 等心理学家。他们研究人们如何沿快乐/悲伤、坚硬/柔软等量表对词义作出反应。Osgood et al.（1957）提出，词的一般意义可以建模为多维欧氏空间中的点，而两个词的意义相似度可以建模为空间中两点的距离。

20 世纪 50 年代至 60 年代初的第三个思想来源，是当时所谓的机械索引、如今称为**信息检索**（information retrieval）的领域。在后来称为信息检索**向量空间模型**（vector space model；Salton, 1971；Sparck Jones, 1986）的框架中，研究者展示了用向量定义词义的新方法（Switzer, 1965），并利用互信息（Giuliano, 1965）、idf（Sparck Jones, 1972）等词间统计关联度量改进词相似度，还证明文档意义可以用与词相同的向量空间表示。大致同期，Cordier（1965）证明，词联想概率的因子分析可形成词的稠密向量表示。

分布式思维的部分哲学基础来自后期维特根斯坦。他怀疑能否为每个词建立完全形式化的意义定义理论，转而提出“一个词的意义就是它在语言中的使用”（Wittgenstein, 1953, PI 43）。也就是说，与其用逻辑语言、指称或真值定义每个词，不如用人们在日常互动中说话和理解时如何使用该词来定义它。这预示了语言学和 NLP 向具身及经验模型的发展（Glenberg and Robertson, 2000；Lake and Murphy, 2021；Bisk et al., 2020；Bender and Koller, 2020）。

另一个关系较远的思想，是用离散特征向量定义词，其根源至少可追溯至笛卡尔和莱布尼茨（Wierzbicka, 1992, 1996）。20 世纪中叶，从 Hjelmslev（1969，原作 1943）开始，并在早期生成语法模型（Katz and Fodor, 1963）中得到发展，研究者提出用表示某种原始意义的符号——**语义特征**（semantic features）——表示意义。例如 hen、rooster、chick 都指鸡，却在年龄和性别上不同：

> hen　+female, +chicken, +adult  
> rooster　−female, +chicken, +adult  
> chick　+chicken, −adult

现代意义向量模型的维度，只在抽象层面与这种少量固定人工维度的思想相关。不过，也有研究尝试证明嵌入模型中的某些维度确实贡献了类似早期语义特征的特定组合意义侧面。

使用稠密向量建模词义以及 embedding 一词，都源于**潜在语义索引**（latent semantic indexing, LSI；Deerwester et al., 1988），其后被重新表述为**潜在语义分析**（latent semantic analysis, LSA；Deerwester et al., 1990）。LSA 对词项—文档矩阵（单元格以对数频率加权并按熵归一化）应用**奇异值分解**（singular value decomposition, SVD），再取前 300 个维度作为 LSA 嵌入。SVD 用于寻找数据集中最重要、即数据变化最大的维度。

LSA 很快被广泛用于认知建模（Landauer and Dumais, 1997）、拼写检查（Jones and Martin, 1997）、语言建模（Bellegarda, 1997, 2000；Coccaro and Jurafsky, 1998）、形态归纳（Schone and Jurafsky, 2000, 2001b）、多词表达（Schone and Jurafsky, 2001a）和作文评分（Rehder et al., 1998）。Schütze（1992b）同期开发了相关模型并用于词义消歧。LSA 还促成嵌入最早用于概率分类器：Schütze et al.（1995）的逻辑回归文档路由器。

Schütze（1992b）在 LSA 后不久提出对词项—词项矩阵而非词项—文档矩阵进行 SVD，并把所得低秩（97 维）嵌入用于词义消歧，同时分析语义空间、提出删除高阶维度等技术；另见 Schütze（1997）。早期 SVD 工作之后出现了许多矩阵模型，包括**概率潜在语义索引**（PLSI；Hofmann, 1999）、**潜在狄利克雷分配**（LDA；Blei et al., 2003）和**非负矩阵分解**（NMF；Lee and Seung, 1999）。

LSA 社群似乎最早在 Landauer et al.（1997）中使用 embedding 一词，沿用其“从一个空间或数学结构映射到另一个”的数学含义。在 LSA 中，它指从稀疏计数向量空间到 SVD 稠密向量潜在空间的映射。后来该词经转喻发生变化，转而表示潜在空间中所得的稠密向量，这也是今天的用法。

进入下一个十年后，Bengio et al.（2003, 2006）证明神经语言模型也能在词预测任务中学习嵌入。Collobert and Weston（2007, 2008）及 Collobert et al.（2011）证明嵌入可为多种 NLP 任务表示词义。Turian et al.（2010）比较了不同嵌入在不同任务中的价值。Mikolov et al.（2011）证明循环神经网络可用作语言模型；Mikolov et al.（2013a）通过简化神经语言模型的隐藏层提出 skip-gram 和 CBOW，Mikolov et al.（2013b）提出负采样训练算法。静态嵌入及其参数设置已有许多综述（Bullinaria and Levy, 2007, 2012；Lapesa and Evert, 2014；Kiela and Clark, 2014；Levy et al., 2015）。

若要深入了解向量在信息检索中的作用，包括查询与文档比较、tf-idf 细节和超大数据集扩展问题，可参见 Manning et al.（2008）及第 11 章。清晰全面的 word2vec 教程见 Kim（2019）；词汇语义学入门可参见 Cruse（2004）。
