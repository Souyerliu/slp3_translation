# 历史说明

Maron（1961）在 RAND Corporation 提出了多项式朴素贝叶斯文本分类，用于给期刊摘要分配主题类别。他的模型已经包含了这里介绍的现代形式的大多数特征：用多选一分类近似分类任务，并实现加 $\alpha$ 平滑和基于信息的特征选择。

朴素贝叶斯的条件独立假设以及文本贝叶斯分析的思想似乎曾多次独立出现。与 Maron 论文同年，Minsky（1961）为视觉及其他人工智能问题提出了朴素贝叶斯分类器；Mosteller and Wallace（1963）也把贝叶斯技术用于作者归属判定。长期以来，人们已知 Alexander Hamilton、John Jay 和 James Madison 在 1787—1788 年匿名撰写《联邦党人文集》，以说服纽约州批准美国宪法。但在 85 篇文章中，虽然有些显然可归于某位作者，仍有 12 篇的作者究竟是 Hamilton 还是 Madison 存有争议。Mosteller and Wallace（1963）分别用 Hamilton 和 Madison 的作品训练贝叶斯概率模型，再计算每篇争议文章的最大似然作者。Heckerman et al.（1998）最早把朴素贝叶斯用于垃圾邮件检测。

Metsis et al.（2006）、Pang et al.（2002）以及 Wang and Manning（2012）表明，对多项式朴素贝叶斯使用布尔属性比使用完整计数效果更好。二值多项式朴素贝叶斯有时会与另一种同样用二值表示记录词项是否出现在文档中的变体混淆，即**多变量 Bernoulli 朴素贝叶斯**。Bernoulli 变体把 $P(w\mid c)$ 估计为包含某词项的文档比例，并且还计入某词项不在文档中的概率。McCallum and Nigam（1998）与 Wang and Manning（2012）表明，在情感分析及其他文本任务中，朴素贝叶斯的多变量 Bernoulli 变体不如多项式算法。

许多资料讨论了各种文本分类任务。情感分析参见 Pang and Lee（2008）以及 Liu and Zhang（2012）；Stamatatos（2009）综述作者归属判定算法；语言识别参见 Jauhiainen et al.（2019），Jaech et al.（2016）是重要的早期神经系统。基于 Reuters-21578 新闻通讯文章集合的新闻索引任务，过去常被用作文本分类算法的测试案例。

文本分类参见 Manning et al.（2008）以及 Aggarwal and Zhai（2012）；一般分类问题在机器学习教材中有介绍（Hastie et al., 2001；Witten and Frank, 2005；Bishop, 2006；Murphy, 2012）。

NLP 中最早在 MUC 竞赛（Chinchor et al., 1993）中使用非参数方法计算统计显著性；语音识别领域的使用更早（Gillick and Cox, 1989；Bisani and Ney, 2004）。本附录的自助法说明借鉴了 Berg-Kirkpatrick et al.（2012）。近期工作集中在多个测试集和多个指标等问题上（Søgaard et al., 2014；Dror et al., 2017）。

**特征选择**用于删除不大可能很好泛化的特征。特征通常按其对分类决策的信息量排序。一个非常常见的指标是**信息增益**，它告诉我们某个词的出现能为猜测类别提供多少比特的信息。其他特征选择指标包括 $\chi^2$、逐点互信息和 GINI 指数；相关比较见 Yang and Pedersen（1997），特征选择导论见 Guyon and Elisseeff（2003）。
