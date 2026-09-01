# 练习

**F.1** 为下列 ATIS 短语画出树结构：

1. *Dallas*
2. *from Denver*
3. *after five p.m.*
4. *arriving in Washington*
5. *early flights*
6. *all redeye flights*
7. *on Thursday*
8. *a one-way fare*
9. *any delays in Denver*

**F.2** 为下列 ATIS 句子画出树结构：

1. *Does American Airlines have a flight between five a.m. and six a.m.?*
2. *I would like to fly on American Airlines.*
3. *Please repeat that.*
4. *Does American 487 have a first-class section?*
5. *I need to fly between Philadelphia and Atlanta.*
6. *What is the fare from Atlanta to Denver?*
7. *Is there an American Airlines flight from Philadelphia to Dallas?*

**F.3** 假定一个语法按照 F.3.4 节所述，针对不同的次范畴化含有许多 VP 规则，并含有 `Verb-with-NP-complement` 之类次范畴各异的动词规则。如果要正确处理 *the earliest flight that you have* 之类的例子，名词后关系从句规则 (F.4) 需要怎样修改？回忆一下，在这种例子中，代词 *that* 是动词 *get* 的宾语。你的规则应当允许这个名词短语，同时应正确排除不合语法的 S \**I get*。

**F.4** 你对上一题的解答能正确模拟 NP *the earliest flight that I can get* 吗？*the earliest flight that I think my mother wants me to book for her* 又如何？提示：这种现象称为长距离依存。

**F.5** 编写规则，表达英语助动词的动词次范畴；例如，可以有一条规则 `verb-with-bare-stem-VP-complement → can`。

**F.6** *Fortune’s office* 或 *my uncle’s marks* 这样的 NP 称为所有格名词短语或属格名词短语。可以把 *Fortune’s* 或 *my uncle’s* 这样的内部 NP 当作随后中心名词的限定词，从而为所有格名词短语建模。请为英语所有格编写语法规则。可以把 *’s* 当成独立的词来处理（即假定 *’s* 之前总有空格）。

**F.7** 第 8 页讨论了 Wh-NP 成分的必要性。最简单的 Wh-NP 是 wh-代词之一（*who, whom, whose, which*）。wh-词 *what* 和 *which* 还可以充当限定词，例如：*which four will you have?*、*what credit do you have with the Duke?*。请为不同类型的 Wh-NP 编写规则。

## 参考文献

Backus, J. W. 1959. The syntax and semantics of the proposed international algebraic language of the Zurich ACM-GAMM Conference. *Information Processing: Proceedings of the International Conference on Information Processing, Paris*. UNESCO.

Backus, J. W. 1996. Transcript of question and answer session. In R. L. Wexelblat, ed., *History of Programming Languages*, page 162. Academic Press.

Bazell, C. E. 1952/1966. The correspondence fallacy in structural linguistics. In E. P. Hamp, F. W. Householder, and R. Austerlitz, eds, *Studies by Members of the English Department, Istanbul University* (3), reprinted in *Readings in Linguistics II* (1966), 271–298. University of Chicago Press.

Biber, D., S. Johansson, G. Leech, S. Conrad, and E. Finegan. 1999. *Longman Grammar of Spoken and Written English*. Pearson.

Bies, A., M. Ferguson, K. Katz, and R. MacIntyre. 1995. Bracketing guidelines for Treebank II style Penn Treebank Project.

Bloomfield, L. 1914. *An Introduction to the Study of Language*. Henry Holt and Company.

Bloomfield, L. 1933. *Language*. University of Chicago Press.

Bresnan, J., ed. 1982. *The Mental Representation of Grammatical Relations*. MIT Press.

Charniak, E. 1997. Statistical parsing with a context-free grammar and word statistics. AAAI.

Chomsky, N. 1956. Three models for the description of language. *IRE Transactions on Information Theory*, 2(3):113–124.

Chomsky, N. 1956/1975. *The Logical Structure of Linguistic Theory*. Plenum.

Chomsky, N. 1957. *Syntactic Structures*. Mouton.

Chomsky, N. 1963. Formal properties of grammars. In R. D. Luce, R. Bush, and E. Galanter, eds, *Handbook of Mathematical Psychology*, volume 2, 323–418. Wiley.

Chomsky, N. 1995. *The Minimalist Program*. MIT Press.

Collins, M. 1999. *Head-Driven Statistical Models for Natural Language Parsing*. Ph.D. thesis, University of Pennsylvania, Philadelphia.

Culicover, P. W. and R. Jackendoff. 2005. *Simpler Syntax*. Oxford University Press.

Gazdar, G., E. Klein, G. K. Pullum, and I. A. Sag. 1985. *Generalized Phrase Structure Grammar*. Blackwell.

Harris, Z. S. 1946. From morpheme to utterance. *Language*, 22(3):161–183.

Hemphill, C. T., J. Godfrey, and G. Doddington. 1990. The ATIS spoken language systems pilot corpus. *Speech and Natural Language Workshop*.

Hopcroft, J. E. and J. D. Ullman. 1979. *Introduction to Automata Theory, Languages, and Computation*. Addison Wesley.

Huddleston, R. and G. K. Pullum. 2002. *The Cambridge Grammar of the English Language*. Cambridge University Press.

Joshi, A. K. 1985. Tree adjoining grammars: How much context-sensitivity is required to provide reasonable structural descriptions? In D. R. Dowty, L. Karttunen, and A. Zwicky, eds, *Natural Language Parsing*, 206–250. Cambridge University Press.

Kay, P. and C. J. Fillmore. 1999. Grammatical constructions and linguistic generalizations: The What’s X Doing Y? construction. *Language*, 75(1):1–33.

Magerman, D. M. 1995. Statistical decision-tree models for parsing. ACL.

Marcus, M. P., G. Kim, M. A. Marcinkiewicz, R. MacIntyre, A. Bies, M. Ferguson, K. Katz, and B. Schasberger. 1994. The Penn Treebank: Annotating predicate argument structure. HLT.

Marcus, M. P., B. Santorini, and M. A. Marcinkiewicz. 1993. Building a large annotated corpus of English: The Penn treebank. *Computational Linguistics*, 19(2):313–330.

Naur, P., J. W. Backus, F. L. Bauer, J. Green, C. Katz, J. McCarthy, A. J. Perlis, H. Rutishauser, K. Samelson, B. Vauquois, J. H. Wegstein, A. van Wijnagaarden, and M. Woodger. 1960. Report on the algorithmic language ALGOL 60. *CACM*, 3(5):299–314. Revised in *CACM* 6:1, 1–17, 1963.

Nivre, J., M.-C. de Marneffe, F. Ginter, Y. Goldberg, J. Hajič, C. D. Manning, R. McDonald, S. Petrov, S. Pyysalo, N. Silveira, R. Tsarfaty, and D. Zeman. 2016. Universal Dependencies v1: A multilingual treebank collection. LREC.

Percival, W. K. 1976. On the historical source of immediate constituent analysis. In J. D. McCawley, ed., *Syntax and Semantics Volume 7, Notes from the Linguistic Underground*, 229–242. Academic Press.

Pollard, C. and I. A. Sag. 1994. *Head-Driven Phrase Structure Grammar*. University of Chicago Press.

Quirk, R., S. Greenbaum, G. Leech, and J. Svartvik. 1985. *A Comprehensive Grammar of the English Language*. Longman.

Radford, A. 1997. *Syntactic Theory and the Structure of English: A Minimalist Approach*. Cambridge University Press.

Sag, I. A., T. Wasow, and E. M. Bender, eds. 2003. *Syntactic Theory: A Formal Introduction*. CSLI Publications, Stanford, CA.

Van Valin, Jr., R. D. and R. La Polla. 1997. *Syntax: Structure, Meaning, and Function*. Cambridge University Press.

Wundt, W. 1900. *Völkerpsychologie: eine Untersuchung der Entwicklungsgesetze von Sprache, Mythus, und Sitte*. W. Engelmann, Leipzig. Band II: Die Sprache, Zweiter Teil.
