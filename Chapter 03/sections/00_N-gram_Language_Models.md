CHAPTER

# N-gram Language Models

“You are uniformly charming!” cried he, with a smile of associating and now and then I bowed and they perceived a chaise andfour to wishfor. Random sentence generated from a Jane Austen trigram model

Predicting is difficult—especially about the future, as the old quip goes. But how about predicting something that seems much easier, like the next word someone is going to say? What word, for example, is likely to follow

The water of Walden Pond is so beautifully ...

You might conclude that a likely word is blue, or green, or clear, but probably not refrigerator nor this. In this chapter we formalize this intuition by introducing n-gram language models or LMs. A language model is a machine learning model that predicts upcoming words. More formally, a language model assigns a probability to each possible next word, or equivalently gives a probability distribution over possible next words. Language models can also assign a probability to an entire sentence. Thus an LM could tell us that the following sequence has a much higher probability of appearing in a text:

all of a sudden I notice three guys standing on the sidewalk

than does this same set of words in a different order:

on guys all I of notice sidewalk three a sudden standing the

Why would we want to predict upcoming words? The main reason is that large language models are built just by training them to predict words!! As we’ll see in chapters 5-9, large language models learn an enormous amount about language solely from being trained to predict upcoming words from neighboring words.

This probabilistic knowledge can be very practical in other ways. Consider correcting grammar or spelling errors like Their are two midterms, in which There was mistyped as Their, or Everything has improve, in which improve should have been improved. The phrase There are is more probable than Their are, and has improved than has improve, so a language model can help users select the more grammatical variant.

Or for a speech system to recognize that you said I will be back soonish and not I will be bassoon dish, it helps to know that back soonish is a more probable sequence. Language models can also help in augmentative and alternative communication (Trnka et al. 2007, Kane et al. 2017). People can use AAC systems if they are physically unable to speak or sign but can instead use eye gaze or other movements to select words from a menu. Word prediction can be used to suggest likely words for the menu.

In this chapter we introduce the simplest kind of language model: the n-gram language model. An n-gram is a sequence of n words: a 2-gram (which we’ll call bigram) is a two-word sequence of words like The water, or water of, and a 3- gram (a trigram) is a three-word sequence of words like The water of, or water of Walden. But we also (in a bit of terminological ambiguity) use the word ‘ngram’ to mean a probabilistic model that can estimate the probability of a word given the n-1 previous words, and thereby also to assign probabilities to entire sequences.

In later chapters we will introduce the much more powerful neural large language models, based on the transformer architecture of Chapter 7. But because n-grams have a remarkably simple and clear formalization, we use them to introduce some major concepts of large language modeling, including training and test sets, perplexity, sampling, and interpolation.
