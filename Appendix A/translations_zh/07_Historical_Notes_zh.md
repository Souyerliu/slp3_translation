# 历史说明

如第 18 章所述，Markov（1913；英译本见 Markov, 2006）最早使用马尔可夫链来预测 Pushkin 的《叶甫盖尼·奥涅金》中下一个字母是元音还是辅音。隐马尔可夫模型由 Princeton 的 Institute for Defense Analyses 中 Baum 及其同事开发（Baum and Petrie, 1966；Baum and Eagon, 1967）。

Viterbi 算法最早由 Vintsyuk（1968）在语音识别背景下用于语音和语言处理，但它经历了 Kruskal（1983）所称的“多次独立发现和发表的非凡历史”。Kruskal 等人列出了至少以下几种独立发现、发表于四个不同领域的算法变体：

<table><tr><th>文献</th><th>领域</th></tr><tr><td>Viterbi（1967）</td><td>信息论</td></tr><tr><td>Vintsyuk（1968）</td><td>语音处理</td></tr><tr><td>Needleman and Wunsch（1970）</td><td>分子生物学</td></tr><tr><td>Sakoe and Chiba（1971）</td><td>语音处理</td></tr><tr><td>Sankoff（1972）</td><td>分子生物学</td></tr><tr><td>Reichert et al.（1973）</td><td>分子生物学</td></tr><tr><td>Wagner and Fischer（1974）</td><td>计算机科学</td></tr></table>

如今，在语音和语言处理中，只要把动态规划用于某种概率最大化问题，通常都称为 Viterbi 算法。对于最小编辑距离等非概率问题，则经常只使用“动态规划”这一名称。Forney, Jr.（1973）的一篇早期综述论文探讨了 Viterbi 算法在信息与通信理论背景下的起源。

本附录用三个基本问题刻画隐马尔可夫模型，这种表述仿照 Rabiner（1989）颇具影响力的教程；该教程本身又以 IDA 的 Jack Ferguson 在 20 世纪 60 年代所作的教程为基础。Jelinek（1997）与 Rabiner and Juang（1993）完整描述了前向—后向算法在语音识别问题中的应用；Jelinek（1997）还说明了前向—后向算法与 EM 的关系。

完整参考文献列表见本附录的[原始 PDF](../../MinerU-Skill/ed3book_aug26_3a047d/split_pdf/A.pdf)。

