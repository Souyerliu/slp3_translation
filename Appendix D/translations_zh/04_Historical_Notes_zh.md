# 历史说明

拼写错误检测与纠正算法至少可以追溯到 Blair（1960）。多数早期算法以 Soundex（Odell and Russell, 1918/1922；Knuth, 1973）等相似性键为基础。Damerau（1964）提出基于词典的错误检测算法，此后大多数错误检测算法也以词典为基础。早期研究曾认为拼写词典应保持较小规模，因为大词典包含 *wont*、*veery* 等极罕见词，而它们很像其他词的错误拼写（Peterson, 1986）；Damerau and Mays（1989）却发现，实践中更大的词典更有帮助。Damerau（1964）还提出用于单个错误的纠正算法。

Claude Shannon（1948）很早就发展了把语言传输建模为“马尔可夫源通过噪声信道”的思想。Raviv（1967）在 IBM Research 针对相近的光学字符识别任务，发展了把先验和似然结合起来处理噪声信道的方法。Kashyap and Oommen（1983）等更早的拼写检查器使用了基于似然的编辑距离模型；直到 AT&T Bell Laboratories（Kernighan et al., 1990；Church and Gale, 1991）与 IBM Watson Research（Mays et al., 1991）大约同时提出噪声信道拼写纠错，先验与似然的结合才用于该任务。Wilcox-O’Hearn 等人（2008）后来在标准数据集上重新实现并测试了 Mays 等人（1991）的算法，证明其性能很高。

自 Wagner and Fischer（1974）以来，多数算法都依赖动态规划。近期研究重点是利用网络构建语言模型和训练错误模型，同时加入发音模型、句法分析或语义相关度等信息。人类拼写错误综述见 Mitton（1987），拼写错误检测与纠正的早期综述见 Kukich（1992）。Norvig（2007）给出了噪声信道模型的清晰解释和 Python 实现，Norvig（2009）则提供更多细节和高效算法。完整参考文献列表见[原始 PDF](../../MinerU-Skill/ed3book_aug26_3a047d/split_pdf/D.pdf)。

