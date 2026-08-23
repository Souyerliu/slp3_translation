## Exercises

2.1 Translate a sentence from one language you know to another. Now tokenize both sentences, for example using Tat Dat Duong’s Tiktokenizer visualizer (https://tiktokenizer.vercel.app/) and see if you see differences in the token count.

2.2 Tokenize a long number, a URL, and a chemical formula. Why might a large language model be bad at arithmetic given what you see?

2.3 Using Fig. 2.5, encode the following into UTF-8 by hand, showing the bit manipulation: (a) the character e (U+00E9), and (b) the character´ 进(U+8FDB). How many bytes does each take?

2.4 Write regular expressions for the following languages.

1. the set of all alphabetic strings;

2. the set of all lower case alphabetic strings ending in a b;

3. the set of all strings from the alphabet a,b such that each a is immediately preceded by and immediately followed by a b;

2.5 Write regular expressions for the following languages. By “word”, we mean an alphabetic string separated from other words by whitespace, any relevant punctuation, line breaks, and so forth.

1. the set of all strings with two consecutive repeated words (e.g., “Humbert Humbert” and “the the” but not “the bug” or “the big bug”);

2. all strings that start at the beginning of the line with an integer and that end at the end of the line with a word;

3. all strings that have both the word grotto and the word raven in them (but not, e.g., words like grottos that merely contain the word grotto);

4. write a pattern that places the first word of an English sentence in a register. Deal with punctuation.

2.6 Implement an ELIZA-like program, using substitutions such as those described on page 55. You might want to choose a different domain than a Rogerian psychologist, although keep in mind that you would need a domain in which your program can legitimately engage in a lot of simple repetition.

2.7 Compute the edit distance (using insertion cost 1, deletion cost 1, substitution cost 1) of “leda” to “deal”. Show your work (using the edit distance grid).

2.8 Figure out whether drive is closer to brief or to divers and what the edit distance is to each. You may use any version of distance that you like.

2.9 Now implement a minimum edit distance algorithm and use your hand-computed results to check your code.

2.10 Augment the minimum edit distance algorithm to output an alignment; you will need to store pointers and add a stage to compute the backtrace.
