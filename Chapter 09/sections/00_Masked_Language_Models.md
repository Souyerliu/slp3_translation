![](../images/48aecdbf7401ebd9fd541c899f74dc4baba8ffb4c290644f558555dc6db252a4.jpg)

# Masked Language Models

Larvatus prodeo [Masked, I goforward]

Descartes

In the previous two chapters we introduced the transformer and saw how to pretrain a transformer language model as a causal or left-to-right language model. In this chapter we’ll introduce a second paradigm for pretrained language models, the bidirectional transformer encoder, and the most widely-used version, the BERT family of models (Devlin et al., 2019). This model is trained via masked language modeling, where instead of predicting the following word, we mask a word in the middle and ask the model to guess the word given the words on both sides. This method thus allows the model to see both the right and left context.

We also introduced fine-tuning in the prior chapter. Here we describe a new kind of fine-tuning, in which we take the transformer network learned by these pretrained models, add a neural net classifier after the top layer of the network, and train it on some additional labeled data to perform some downstream task like named entity tagging or natural language inference. As before, the intuition is that the pretraining phase learns a language model that instantiates rich representations of word meaning, that thus enables the model to more easily learn (‘be finetuned to’) the requirements of a downstream language understanding task. This aspect of the pretrain-finetune paradigm is an instance of what is called transfer learning in machine learning: the method of acquiring knowledge from one task or domain, and then applying it (transferring it) to solve a new task.
