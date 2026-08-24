## 历史注记

逻辑回归源于统计学，20 世纪 60 年代已用于分析二元数据，在医学领域尤其常见（Cox, 1969）。自 20 世纪 70 年代末起，它作为语言变异研究的形式基础之一，在语言学中得到广泛应用（Sankoff and Labov, 1979）。

然而，直到 20 世纪 90 年代，逻辑回归才在自然语言处理中普及，而且似乎同时来自两个方向。其一是相邻的信息检索和语音处理领域；二者都曾使用回归，也为 NLP 引入了许多其他统计技术。一个很早的文档路由逻辑回归系统，还是最早使用 LSI 嵌入作为词表示的 NLP 应用之一（Schütze et al., 1995）。

与此同时，20 世纪 90 年代初，IBM Research 似乎独立于统计学文献，以**最大熵建模**（maximum entropy modeling）或 **maxent** 之名开发逻辑回归并将其用于 NLP（Berger et al., 1996）。该模型随后被用于语言建模（Rosenfeld, 1996）、词性标注（Ratnaparkhi, 1996）、句法分析（Ratnaparkhi, 1997）、共指消解（Kehler, 1997b）和文本分类（Nigam et al., 1999）。

关于各种文本分类任务已有许多资料：情感分析可参见 Pang and Lee（2008）、Liu and Zhang（2012）；Stamatatos（2009）综述了作者归属算法；语言识别可参见 Jauhiainen et al.（2019），Jaech et al.（2016）则是重要的早期神经系统。基于 Reuters-21578 新闻电讯集合的新闻索引任务，也经常用作文本分类算法的测试案例。

文本分类可参见 Manning et al.（2008）和 Aggarwal and Zhai（2012）；一般分类问题可参见机器学习教材 Hastie et al.（2001）、Witten and Frank（2005）、Bishop（2006）和 Murphy（2012）。

计算统计显著性的非参数方法，早期曾用于 NLP 的 MUC 竞赛（Chinchor et al., 1993），在语音识别中应用得更早（Gillick and Cox, 1989；Bisani and Ney, 2004）。本章对自助法的描述参考 Berg-Kirkpatrick et al.（2012）。近期工作关注多个测试集和多个指标等问题（Søgaard et al., 2014；Dror et al., 2017）。

**特征选择**（feature selection）用于删除不太可能良好泛化的特征。通常按特征对分类决策的信息量进行排序。一个常见指标是**信息增益**（information gain），它表示某个词的出现能为类别猜测提供多少比特信息。其他特征选择指标包括 $\chi^2$、逐点互信息和 GINI 指数；比较可参见 Yang and Pedersen（1997），特征选择导论可参见 Guyon and Elisseeff（2003）。
