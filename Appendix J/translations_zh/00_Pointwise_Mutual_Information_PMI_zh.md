# 逐点互信息（PMI）

[原始 PDF](../../MinerU-Skill/ed3book_aug26_3a047d/split_pdf/J.pdf)

当向量维度对应的是词而非文档时，词项—词项矩阵可以使用 tf-idf 的一种替代加权函数：**正逐点互信息**（positive pointwise mutual information，PPMI）。PPMI 背后的直觉是，衡量两个词之间关联程度的最佳方式，是考察它们在语料库中的实际共现次数，比我们事先假定二者随机出现时的期望共现次数多多少。

**逐点互信息**（pointwise mutual information，PMI；Fano, 1961）是 NLP 中最重要的概念之一。它衡量事件 $x$ 和 $y$ 实际共同出现的频率，相对于二者相互独立时的期望频率有多高：

$$
I(x,y)=\log_2\frac{P(x,y)}{P(x)P(y)}\tag{J.2}
$$

目标词 $w$ 与上下文词 $c$ 之间的逐点互信息（Church and Hanks, 1989, 1990）定义为：

$$
\operatorname{PMI}(w,c)=\log_2\frac{P(w,c)}{P(w)P(c)}\tag{J.3}
$$

若用最大似然估计计算概率，分子表示两个词共同出现的频率；分母则表示假定两个词各自独立出现时的期望共现频率。回想一下，两个独立事件同时发生的概率，就是各自概率的乘积。因此，该比值估计了两个词的实际共现程度比随机情况下的期望值高多少。凡是需要寻找强关联词语的任务，PMI 都是一种很有用的工具。

PMI 的取值范围从负无穷到正无穷。不过，除非语料库极其庞大，否则负 PMI 值——即实际共现少于随机期望——往往并不可靠。假设两个词各自的概率都是 $10^{-6}$；若要断定它们共同出现的频率低于随机水平，就必须确信二者共同出现的概率显著小于 $10^{-12}$，而达到这种统计粒度需要极大的语料库。此外，这种“无关联程度”分数是否能用人类判断来评估，也并不明确。因此，更常见的做法是使用**正 PMI**（即 PPMI），把所有负 PMI 值替换为零（Church and Hanks, 1989；Dagan et al., 1993；Niwa and Nitta, 1994）：

$$
\operatorname{PPMI}(w,c)=\max\left(\log_2\frac{P(w,c)}{P(w)P(c)},0\right)\tag{J.4}
$$

更形式化地说，假设我们有一个共现矩阵 $F$，它包含 $W$ 行（词）和 $C$ 列（上下文），其中 $f_{ij}$ 表示词 $w_i$ 与上下文 $c_j$ 共同出现的次数。可以把它转化为 PPMI 矩阵，其中 $\operatorname{PPMI}_{ij}$ 表示词 $w_i$ 与上下文 $c_j$ 的 PPMI 值；该值也可写作 $\operatorname{PPMI}(\boldsymbol{w}_i,\boldsymbol{c}_j)$ 或 $\operatorname{PPMI}(w=i,c=j)$。具体计算如下：

$$
\begin{aligned}
p_{ij} &= \frac{f_{ij}}{\sum_{i'=1}^{W}\sum_{j'=1}^{C}f_{i'j'}},\\
p_{i*} &= \frac{\sum_{j=1}^{C}f_{ij}}{\sum_{i'=1}^{W}\sum_{j'=1}^{C}f_{i'j'}},\\
p_{*j} &= \frac{\sum_{i=1}^{W}f_{ij}}{\sum_{i'=1}^{W}\sum_{j'=1}^{C}f_{i'j'}}.
\end{aligned}\tag{J.5}
$$

$$
\operatorname{PPMI}_{ij}=\max\left(\log_2\frac{p_{ij}}{p_{i*}p_{*j}},0\right)\tag{J.6}
$$

下面来看几个 PPMI 计算示例。为便于计算，我们使用图 J.2；它在图 J.1 的基础上增加了所有边际计数，并暂时假设图中所列的词和上下文就是需要考虑的全部内容。

原始矩阵如下：

<table><tr><th></th><th>aardvark</th><th>computer</th><th>data</th><th>result</th><th>pie</th><th>sugar</th><th>…</th></tr><tr><td>cherry</td><td>0</td><td>2</td><td>8</td><td>9</td><td>442</td><td>25</td><td>…</td></tr><tr><td>strawberry</td><td>0</td><td>0</td><td>0</td><td>1</td><td>60</td><td>19</td><td>…</td></tr><tr><td>digital</td><td>0</td><td>1670</td><td>1683</td><td>85</td><td>5</td><td>4</td><td>…</td></tr><tr><td>information</td><td>0</td><td>3325</td><td>3982</td><td>378</td><td>5</td><td>13</td><td>…</td></tr></table>

**图 J.1　维基百科语料库中四个词的共现向量，这里展示其中六个维度（为教学目的而手工选取）。图中以红色框出 *digital* 的向量。真实向量会有多得多的维度，因而也稀疏得多，即绝大多数维度上的值都为零。**

<table><tr><th></th><th>computer</th><th>data</th><th>result</th><th>pie</th><th>sugar</th><th>count(w)</th></tr><tr><td>cherry</td><td>2</td><td>8</td><td>9</td><td>442</td><td>25</td><td>486</td></tr><tr><td>strawberry</td><td>0</td><td>0</td><td>1</td><td>60</td><td>19</td><td>80</td></tr><tr><td>digital</td><td>1670</td><td>1683</td><td>85</td><td>5</td><td>4</td><td>3447</td></tr><tr><td>information</td><td>3325</td><td>3982</td><td>378</td><td>5</td><td>13</td><td>7703</td></tr><tr><td>count(context)</td><td>4997</td><td>5673</td><td>473</td><td>512</td><td>61</td><td>11716</td></tr></table>

**图 J.2　维基百科语料库中四个词在五种上下文中的共现计数及其边际计数。为便于本例计算，暂且假定不存在其他需要考虑的词或上下文。**

例如，若假定图 J.1 已经涵盖所有相关的词、上下文和维度，就可以按下式计算 $\operatorname{PPMI}(\text{information},\text{data})$：

$$
\begin{aligned}
P(w=\text{information},c=\text{data}) &= \frac{3982}{11716}=0.3399,\\
P(w=\text{information}) &= \frac{7703}{11716}=0.6575,\\
P(c=\text{data}) &= \frac{5673}{11716}=0.4842,\\
\operatorname{PPMI}(\text{information},\text{data}) &= \log_2\left(\frac{0.3399}{0.6575\times0.4842}\right)=0.0944.
\end{aligned}
$$

图 J.3 展示了根据图 J.2 中的计数得到的联合概率，图 J.4 则展示相应的 PPMI 值。不出所料，*cherry* 和 *strawberry* 都与 *pie* 和 *sugar* 高度相关，而 *data* 与 *information* 之间存在较弱的关联。

<table><tr><th colspan="6">p(w, context)</th><th>p(w)</th></tr><tr><th></th><th>computer</th><th>data</th><th>result</th><th>pie</th><th>sugar</th><th>p(w)</th></tr><tr><td>cherry</td><td>0.0002</td><td>0.0007</td><td>0.0008</td><td>0.0377</td><td>0.0021</td><td>0.0415</td></tr><tr><td>strawberry</td><td>0.0000</td><td>0.0000</td><td>0.0001</td><td>0.0051</td><td>0.0016</td><td>0.0068</td></tr><tr><td>digital</td><td>0.1425</td><td>0.1436</td><td>0.0073</td><td>0.0004</td><td>0.0003</td><td>0.2942</td></tr><tr><td>information</td><td>0.2838</td><td>0.3399</td><td>0.0323</td><td>0.0004</td><td>0.0011</td><td>0.6575</td></tr><tr><td>p(context)</td><td>0.4265</td><td>0.4842</td><td>0.0404</td><td>0.0437</td><td>0.0052</td><td></td></tr></table>

**图 J.3　以联合概率替换图 J.1 中的计数；右侧一列和底部一行给出边际概率。**

<table><tr><th></th><th>computer</th><th>data</th><th>result</th><th>pie</th><th>sugar</th></tr><tr><td>cherry</td><td>0</td><td>0</td><td>0</td><td>4.38</td><td>3.30</td></tr><tr><td>strawberry</td><td>0</td><td>0</td><td>0</td><td>4.10</td><td>5.51</td></tr><tr><td>digital</td><td>0.18</td><td>0.01</td><td>0</td><td>0</td><td>0</td></tr><tr><td>information</td><td>0.02</td><td>0.09</td><td>0.28</td><td>0</td><td>0</td></tr></table>

**图 J.4　根据图 J.3 中的计数计算得到的 PPMI 矩阵，展示词与上下文词之间的关联。注意，大多数为零的 PPMI 值原本对应负 PMI。例如，$\operatorname{PMI}(\text{cherry},\text{computer})=-6.7$，表示 *cherry* 和 *computer* 在维基百科中的共现频率低于随机期望；PPMI 会把这一负值替换为零。**

PMI 存在偏向低频事件的问题：非常罕见的词往往具有很高的 PMI 值。减弱这种偏差的一种方法，是稍微改变 $P(c)$ 的计算，改用另一个函数 $P_\alpha(c)$，把上下文词的概率提高到 $\alpha$ 次幂：

$$
\operatorname{PPMI}_\alpha(w,c)=\max\left(\log_2\frac{P(w,c)}{P(w)P_\alpha(c)},0\right)\tag{J.7}
$$

$$
P_\alpha(c)=\frac{\operatorname{count}(c)^\alpha}{\sum_c\operatorname{count}(c)^\alpha}\tag{J.8}
$$

Levy 等人（2015）发现，设置 $\alpha=0.75$ 能改善嵌入在多种任务上的表现；这种做法借鉴了第 5 章介绍的 skip-gram 模型中的相似加权方式。其原因是，把计数提高到 $0.75$ 次幂会增加分配给低频上下文的概率，进而降低它们的 PMI。当 $c$ 很罕见时，$P_\alpha(c)>P(c)$。

另一种可能的解决方案是拉普拉斯平滑：计算 PMI 之前，先给每个计数加上一个较小的常数 $k$，常用值为 0.1 到 3，从而收缩（折扣）所有非零值。$k$ 越大，对非零计数的折扣就越强。

Church, K. W. and P. Hanks. 1989. Word association norms, mutual information, and lexicography. ACL.

Church, K. W. and P. Hanks. 1990. Word association norms, mutual information, and lexicography. *Computational Linguistics*, 16(1):22–29.

Dagan, I., S. Marcus, and S. Markovitch. 1993. Contextual word similarity and estimation from sparse data. ACL.

Fano, R. M. 1961. *Transmission of Information: A Statistical Theory of Communications*. MIT Press.

Levy, O., Y. Goldberg, and I. Dagan. 2015. Improving distributional similarity with lessons learned from word embeddings. *TACL*, 3:211–225.

Niwa, Y. and Y. Nitta. 1994. Co-occurrence vectors from corpora vs. distance vectors from dictionaries. COLING.

