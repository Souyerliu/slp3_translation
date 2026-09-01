# 练习

**B.1** 假设下表给出了每个词出现在正面或负面电影评论中的似然，而且两类的先验概率相等。

<table><tr><th></th><th>pos</th><th>neg</th></tr><tr><td>I</td><td>0.09</td><td>0.16</td></tr><tr><td>always</td><td>0.07</td><td>0.06</td></tr><tr><td>like</td><td>0.29</td><td>0.06</td></tr><tr><td>foreign</td><td>0.04</td><td>0.15</td></tr><tr><td>films</td><td>0.08</td><td>0.11</td></tr></table>

朴素贝叶斯会把句子“I always like foreign films.”分到哪个类别？

**B.2** 给定以下简短电影评论，每篇都标有喜剧（comedy）或动作（action）类别：

1. fun, couple, love, love — comedy
2. fast, furious, shoot — action
3. couple, fly, fast, fun, fun — comedy
4. furious, shoot, shoot, fun — action
5. fly, fast, shoot, love — action

以及新文档 $D$：

> fast, couple, shoot, fly

计算 $D$ 最可能的类别。假设使用朴素贝叶斯分类器，并对似然使用加一平滑。

**B.3** 针对下表给出的关键情感词文档计数及正负类别，分别训练多项式朴素贝叶斯和二值朴素贝叶斯模型；两个模型都使用加一平滑。

<table><tr><th>doc</th><th>“good”</th><th>“poor”</th><th>“great”</th><th>类别</th></tr><tr><td>d1</td><td>3</td><td>0</td><td>3</td><td>pos</td></tr><tr><td>d2</td><td>0</td><td>1</td><td>2</td><td>pos</td></tr><tr><td>d3</td><td>1</td><td>3</td><td>0</td><td>neg</td></tr><tr><td>d4</td><td>1</td><td>5</td><td>2</td><td>neg</td></tr><tr><td>d5</td><td>0</td><td>2</td><td>0</td><td>neg</td></tr></table>

用两个朴素贝叶斯模型为下面的句子分配类别（pos 或 neg）：

> A good, good plot and great characters, but poor acting.

回忆前文：在朴素贝叶斯文本分类中，任何从未在训练文档中出现的词都直接忽略（丢弃）。但不要丢弃只在某些类别出现、而未在其他类别出现的词；这正是加一平滑要解决的问题。两个模型的结论一致还是不同？

## 参考文献

Aggarwal, C. C. and C. Zhai. 2012. A survey of text classification algorithms. In C. C. Aggarwal and C. Zhai, eds, *Mining text data*, 163–222. Springer.

Bayes, T. 1763. An Essay Toward Solving a Problem in the Doctrine of Chances, volume 53. Reprinted in *Facsimiles of Two Papers by Bayes*, Hafner Publishing, 1963.

Berg-Kirkpatrick, T., D. Burkett, and D. Klein. 2012. An empirical investigation of statistical significance in NLP. EMNLP.

Bisani, M. and H. Ney. 2004. Bootstrap estimates for confidence intervals in ASR performance evaluation. ICASSP.

Bishop, C. M. 2006. *Pattern recognition and machine learning*. Springer.

Blodgett, S. L., S. Barocas, H. Daumé III, and H. Wallach. 2020. Language (technology) is power: A critical survey of “bias” in NLP. ACL.

Blodgett, S. L., L. Green, and B. O’Connor. 2016. Demographic dialectal variation in social media: A case study of African-American English. EMNLP.

Borges, J. L. 1964. The analytical language of John Wilkins. In *Other inquisitions 1937–1952*. University of Texas Press. Trans. Ruth L. C. Simms.

Caliskan, A., J. J. Bryson, and A. Narayanan. 2017. Semantics derived automatically from language corpora contain human-like biases. *Science*, 356(6334):183–186.

Chinchor, N., L. Hirschman, and D. L. Lewis. 1993. Evaluating Message Understanding systems: An analysis of the third Message Understanding Conference. *Computational Linguistics*, 19(3):409–449.

Crawford, K. 2017. The trouble with bias. Keynote at NeurIPS.

Davidson, T., D. Bhattacharya, and I. Weber. 2019. Racial bias in hate speech and abusive language detection datasets. Third Workshop on Abusive Language Online.

Dias Oliva, T., D. Antonialli, and A. Gomes. 2021. Fighting hate speech, silencing drag queens? artificial intelligence in content moderation and risks to LGBTQ voices online. *Sexuality & Culture*, 25:700–732.

Dixon, L., J. Li, J. Sorensen, N. Thain, and L. Vasserman. 2018. Measuring and mitigating unintended bias in text classification. 2018 AAAI/ACM Conference on AI, Ethics, and Society.

Dror, R., G. Baumer, M. Bogomolov, and R. Reichart. 2017. Replicability analysis for natural language processing: Testing significance with multiple datasets. TACL, 5:471–486.

Dror, R., L. Peled-Cohen, S. Shlomov, and R. Reichart. 2020. *Statistical Significance Testing for Natural Language Processing*, volume 45 of Synthesis Lectures on Human Language Technologies. Morgan & Claypool.

Efron, B. and R. J. Tibshirani. 1993. *An introduction to the bootstrap*. CRC Press.

Gillick, L. and S. J. Cox. 1989. Some statistical issues in the comparison of speech recognition algorithms. ICASSP.

Guyon, I. and A. Elisseeff. 2003. An introduction to variable and feature selection. JMLR, 3:1157–1182.

Hastie, T., R. J. Tibshirani, and J. H. Friedman. 2001. *The Elements of Statistical Learning*. Springer.

Heckerman, D., E. Horvitz, M. Sahami, and S. T. Dumais. 1998. A Bayesian approach to filtering junk e-mail. AAAI-98 Workshop on Learning for Text Categorization.

Hu, M. and B. Liu. 2004. Mining and summarizing customer reviews. KDD.

Hutchinson, B., V. Prabhakaran, E. Denton, K. Webster, Y. Zhong, and S. Denuyl. 2020. Social biases in NLP models as barriers for persons with disabilities. ACL.

Jaech, A., G. Mulcaire, S. Hathi, M. Ostendorf, and N. A. Smith. 2016. Hierarchical character-word models for language identification. ACL Workshop on NLP for Social Media.

Jauhiainen, T., M. Lui, M. Zampieri, T. Baldwin, and K. Lindén. 2019. Automatic language identification in texts: A survey. JAIR, 65(1):675–782.

Jurgens, D., Y. Tsvetkov, and D. Jurafsky. 2017. Incorporating dialectal variability for socially equitable language identification. ACL.

Kiritchenko, S. and S. M. Mohammad. 2018. Examining gender and race bias in two hundred sentiment analysis systems. \*SEM.

Liu, B. and L. Zhang. 2012. A survey of opinion mining and sentiment analysis. In C. C. Aggarwal and C. Zhai, eds, *Mining text data*, 415–464. Springer.

Lui, M. and T. Baldwin. 2011. Cross-domain feature selection for language identification. IJCNLP.

Lui, M. and T. Baldwin. 2012. langid.py: An off-the-shelf language identification tool. ACL.

Manning, C. D., P. Raghavan, and H. Schütze. 2008. *Introduction to Information Retrieval*. Cambridge.

Maron, M. E. 1961. Automatic indexing: an experimental inquiry. *Journal of the ACM*, 8(3):404–417.

McCallum, A. and K. Nigam. 1998. A comparison of event models for naive Bayes text classification. AAAI/ICML-98 Workshop on Learning for Text Categorization.

Metsis, V., I. Androutsopoulos, and G. Paliouras. 2006. Spam filtering with naive Bayes—which naive Bayes? CEAS.

Minsky, M. 1961. Steps toward artificial intelligence. *Proceedings of the IRE*, 49(1):8–30.

Mitchell, M., S. Wu, A. Zaldivar, P. Barnes, L. Vasserman, B. Hutchinson, E. Spitzer, I. D. Raji, and T. Gebru. 2019. Model cards for model reporting. ACM FAccT.

Mosteller, F. and D. L. Wallace. 1963. Inference in an authorship problem: A comparative study of discrimination methods applied to the authorship of the disputed federalist papers. *Journal of the American Statistical Association*, 58(302):275–309.

Mosteller, F. and D. L. Wallace. 1964. *Inference and Disputed Authorship: The Federalist*. Springer-Verlag. 1984 2nd edition: *Applied Bayesian and Classical Inference*.

Murphy, K. P. 2012. *Machine learning: A probabilistic perspective*. MIT Press.

Noreen, E. W. 1989. *Computer Intensive Methods for Testing Hypothesis*. Wiley.

Pang, B. and L. Lee. 2008. Opinion mining and sentiment analysis. *Foundations and trends in information retrieval*, 2(1–2):1–135.

Pang, B., L. Lee, and S. Vaithyanathan. 2002. Thumbs up? Sentiment classification using machine learning techniques. EMNLP.

Park, J. H., J. Shin, and P. Fung. 2018. Reducing gender bias in abusive language detection. EMNLP.

Pennebaker, J. W., R. J. Booth, and M. E. Francis. 2007. *Linguistic Inquiry and Word Count: LIWC 2007*. Austin, TX.

Popp, D., R. A. Donovan, M. Crawford, K. L. Marsh, and M. Peele. 2003. Gender, race, and speech style stereotypes. *Sex Roles*, 48(7–8):317–325.

Sahami, M., S. T. Dumais, D. Heckerman, and E. Horvitz. 1998. A Bayesian approach to filtering junk e-mail. AAAI Workshop on Learning for Text Categorization.

Sap, M., D. Card, S. Gabriel, Y. Choi, and N. A. Smith. 2019. The risk of racial bias in hate speech detection. ACL.

Søgaard, A., A. Johannsen, B. Plank, D. Hovy, and H. M. Alonso. 2014. What’s in a p-value in NLP? CoNLL.

Stamatatos, E. 2009. A survey of modern authorship attribution methods. JASIST, 60(3):538–556.

Stone, P., D. Dunphry, M. Smith, and D. Ogilvie. 1966. *The General Inquirer: A Computer Approach to Content Analysis*. MIT Press.

van Rijsbergen, C. J. 1975. *Information Retrieval*. Butterworths.

Wang, S. and C. D. Manning. 2012. Baselines and bigrams: Simple, good sentiment and topic classification. ACL.

Wilson, T., J. Wiebe, and P. Hoffmann. 2005. Recognizing contextual polarity in phrase-level sentiment analysis. EMNLP.

Witten, I. H. and E. Frank. 2005. *Data Mining: Practical Machine Learning Tools and Techniques*, 2nd edition. Morgan Kaufmann.

Yang, Y. and J. Pedersen. 1997. A comparative study on feature selection in text categorization. ICML.
