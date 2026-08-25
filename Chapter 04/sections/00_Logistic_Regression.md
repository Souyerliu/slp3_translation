![](../images/cd85276d16d83a0c3bda116490ec1cfd7115515fad4115bb8de841ab98141bff.jpg)

CHAPTER

# Logistic Regression and Text Classification

En sus remotas paginas est´ a escrito que los animales se dividen en:´

a. pertenecientes al Emperador h. incluidos en esta clasificacion´

b. embalsamados

i. que se agitan como locos

c. amaestrados

d. lechones

j. innumerables

k. dibujados con un pincel fin´ısimo de pelo de camello

e. sirenas

l. etcetera´

f. fabulosos

m. que acaban de romper el jarron´ g. perros sueltos n. que de lejos parecen moscas Borges (1964)

Classification lies at the heart of language processing and intelligence. Recognizing a letter, a word, or a face, sorting mail, assigning grades to homeworks; these are all examples of assigning a category to an input. The challenges of classification were famously highlighted by the fabulist Jorge Luis Borges (1964), who imagined an ancient mythical encyclopedia that classified animals into:

(a) those that belong to the Emperor, (b) embalmed ones, (c) those that are trained, (d) suckling pigs, (e) mermaids, (f)fabulous ones, (g) stray dogs, (h) those that are included in this classification, (i) those that tremble as if they were mad, (j) innumerable ones, (k) those drawn with a very fine camel’s hair brush, (l) others, (m) those that have just broken aflower vase, (n) those that resemblefliesfrom a distance.

Luckily, the classes we use for language processing are easier to define than those of Borges. In this chapter we introduce the logistic regression algorithm for classification. For our running example, we’ll apply text categorization, the task of assigning a label or category to a text or document. We’ll introduce sentiment analysis, the task of classifying sentiment, the positive or negative orientation that a writer expresses toward some object. A review of a movie, book, or product expresses the author’s sentiment toward the product, while an editorial or political text expresses sentiment toward an action or candidate. Extracting sentiment is relevant for fields from marketing to politics. Other text classification tasks are equally important. In spam detection we assign an email to one of the two classes spam or not-spam. Language id is the task of determining what language a text is written in, while authorship attribution is the task of determining a text’s author, relevant to both humanistic and forensic analysis.

But what makes classification so important is that language modeling can also be viewed as classification: each word can be thought of as a class, and so we can think of predicting the next word as classifying the context-so-far into a class for each next word! This intuition underlies large language models.

The algorithm for classification we introduce in this chapter, logistic regression, is equally important. First, logistic regression has a close relationship with neural networks. As we will see in Chapter 6, a neural network can be viewed as a series of logistic regression classifiers stacked on top of each other. Second, logistic regression introduces ideas that are fundamental to language models, like the sigmoid and softmax functions, the logit, and the key gradient descent algorithm for learning. Finally, logistic regression is also one of the most important analytic tools in the social and natural sciences.

Finally, we’ll be thinking about the features we need for classification. For sentiment analysis words like awesome and love, or awful and ridiculously are very informative features for a classifier to make use of, as we can see from these sample extracts from movie/restaurant reviews:

\+ ...awesome caramel sauce and sweet toasty almonds. I love this place!

...awful pizza and ridiculously overpriced...
