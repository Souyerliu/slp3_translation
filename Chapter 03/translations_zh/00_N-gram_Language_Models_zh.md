# n 元语言模型

[原始 PDF](../../MinerU-Skill/ed3book_aug26_3a047d/split_pdf/03_N-gram_Language_Models.pdf)

“你始终那么迷人！”他微笑着喊道，一边联想，时不时我鞠躬，他们看到一辆四轮马车，希望去往。——由 Jane Austen 三元语言模型随机生成的句子

老话说，预测很难，尤其是预测未来。不过，如果要预测一件看似容易得多的事情，例如某个人接下来会说哪个词，情况又如何？比如，下面这段话之后最可能出现什么词？

The water of Walden Pond is so beautifully ...

你可能认为 blue、green 或 clear 很有可能，却大概不会选择 refrigerator 或 this。本章将引入 **n 元语言模型**（n-gram language model，LM），把这种直觉形式化。语言模型是一种预测后续词语的机器学习模型。更严格地说，语言模型为每个可能的下一词分配一个概率，或者等价地说，它给出可能下一词上的概率分布。语言模型也可以为整个句子分配概率。因此，语言模型会告诉我们，下面这个序列出现在文本中的概率：

all of a sudden I notice three guys standing on the sidewalk

远高于同一组词采用另一种顺序时的概率：

on guys all I of notice sidewalk three a sudden standing the

为什么要预测后续词语？最主要的原因是，大语言模型正是通过训练词语预测构建出来的！第 5～9 章将会看到，仅仅接受依据相邻词语预测后续词语的训练，大语言模型就能学到海量语言知识。

这种概率知识还有其他非常实用的用途。考虑纠正语法或拼写错误，例如 Their are two midterms，其中 There 被误写成 Their；又如 Everything has improve，其中 improve 应当写成 improved。短语 There are 比 Their are 的概率更高，has improved 也比 has improve 的概率更高，因此语言模型可以帮助用户选择语法更正确的形式。

再比如，为了让语音系统识别出你说的是 I will be back soonish 而不是 I will be bassoon dish，系统需要知道 back soonish 是概率更高的序列。语言模型还可以帮助实现**辅助与替代沟通**（augmentative and alternative communication，AAC）（Trnka et al., 2007; Kane et al., 2017）。身体上无法说话或使用手语的人，可以通过眼动或其他动作从菜单中选择词语，借助 AAC 系统进行交流。词语预测可以为菜单推荐可能使用的词。

本章介绍最简单的一类语言模型：n 元语言模型。**n 元语法**（n-gram）是由 n 个词组成的序列：2 元语法（称为**二元语法**，bigram）是 The water 或 water of 等双词序列；3 元语法（称为**三元语法**，trigram）是 The water of 或 water of Walden 等三词序列。不过，我们也在一种略有歧义的术语用法中，用“n 元语法”表示一种概率模型：它能估计给定前 $n-1$ 个词时某个词的概率，并由此为整个序列分配概率。

后续章节会介绍功能强大得多、以第 7 章 Transformer 架构为基础的神经大语言模型。不过，n 元语法具有非常简单清晰的形式化表示，因此本章会借助它介绍大语言建模中的若干核心概念，包括训练集与测试集、困惑度、采样和插值。
