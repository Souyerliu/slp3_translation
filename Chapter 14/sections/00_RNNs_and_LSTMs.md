# CHAPTER 14 <sup>RNNs</sup> <sup>and</sup> <sup>LSTMs</sup>

Time will explain.

Jane Austen, Persuasion

Language is an inherently temporal phenomenon. Spoken language is a sequence of acoustic events over time, and we comprehend and produce both spoken and written language as a sequential input stream. The temporal nature of language is reflected in the metaphors we use; we talk of theflow ofconversations, newsfeeds, and twitter streams, all of which emphasize that language is a sequence that unfolds in time.

This chapter introduces a deep learning architecture, the recurrent neural network (RNN), and RNN variants like LSTMs, that offer a different way of representing time than feedforward and transformer networks. RNNs have a mechanism that deals directly with the sequential nature of language, allowing them to handle the temporal nature of language without the use of arbitrary fixed-sized windows. The recurrent network offers a new way to represent the prior context, in its recurrent connections, allowing the model’s decision to depend on information from hundreds of words in the past. We’ll see how to apply the model to the task of language modeling, to text classification tasks like sentiment analysis, and to sequence modeling tasks like part-of-speech tagging.
