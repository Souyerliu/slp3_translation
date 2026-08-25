# Embeddings

荃者所以在鱼，得鱼而忘荃 Nets are for fish;

Once you get the fish, you can forget the net.

言者所以在意，得意而忘言

Words are for meaning;

Once you get the meaning, you can forget the words 庄子(Zhuangzi), Chapter 26

The asphalt that Los Angeles is famous for occurs mainly on its freeways. But in the middle of the city is another patch of asphalt, the La Brea tar pits, and this asphalt preserves millions of fossil bones from the last of the Ice Ages of the Pleistocene Epoch. One of these fossils is the Smilodon, or saber-toothed tiger, instantly recognizable by its long canines. Five million years ago or so, a completely different

saber-tooth tiger called Thylacosmilus lived in Argentina and other parts of South America. Thylacosmilus was a marsupial whereas Smilodon was a placental mammal, but Thylacosmilus had the same long upper canines and, like Smilodon, had a protective bone flange on the lower jaw. The similarity of these two mammals is one of many examples

![](../images/e0b2ef431d826b80bb2304a10fcd238534a58dbb1bd05edae6be0e0e5640a1ae.jpg)

of parallel or convergent evolution, in which particular contexts or environments lead to the evolution of very similar structures in different species (Gould, 1980).

The role of context is also important in the similarity of a less biological kind of organism: the word. Words that occur in similar contexts tend to have similar meanings. This link between similarity in how words are distributed and similarity in what they mean is called the distributional hypothesis. The hypothesis was first formulated in the 1950s by linguists like Joos (1950), Harris (1954), and Firth (1957), who noticed that words which are synonyms (like oculist and eye-doctor) tended to occur in the same environment (e.g., near words like eye or examined) with the amount of meaning difference between two words “corresponding roughly to the amount of difference in their environments” (Harris, 1954, p. 157).

In this chapter we introduce embeddings, vector representations of the meaning of words that are learned directly from word distributions in texts. Embeddings lie at the heart of large language models and other modern applications. The static embeddings we introduce here underlie the more powerful dynamic or contextualized embeddings like BERT that we will see in Chapter 7 and Chapter 9.

The linguistic field that studies embeddings and their meanings is called vector semantics. Embeddings are also the first example in this book of representation learning, automatically learning useful representations of the input text. Finding such self-supervised ways to learn representations of language, instead of creating representations by hand via feature engineering, is an important principle of modern NLP (Bengio et al., 2013).
