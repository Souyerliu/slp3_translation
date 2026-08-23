# Transformers and Pretraining

![](../images/52759d800747e85a8f12f620032bed48b300392e74287b8f811db7434309d716.jpg)

“The true art ofmemory is the art ofattention

Samuel Johnson, Idler #74, September 1759

In this chapter we introduce the transformer, the standard architecture for building large language models, and how to pretrain them and how to use them to generate text. We’ll introduce transformers for left-to-right (sometimes called causal or autoregressive or decoder) language modeling, in which we are given a sequence of input tokens and predict output tokens one by one by conditioning on the prior context; we’ll introduce other architectures like the encoder architecture in Chapter 9.

![](../images/figure7.1.jpg)  
Figure 7.1 A transformer decoder for language modeling, showing the residual stream for processing an input token. A single token is embedded and passed forward in the network, with the feedforward and attention components adding information. The multihead attention layer takes inputs (not shown in detail) from the neighboring token streams. This is thus one column of an autoregressive transformer language model, taking an input token and outputting a distribution over next tokens.

Fig. 7.1 sketches the transformer architecture following a single token as it passes up through the layers of the network. Each token is first converted to an embedding from the embedding matrix E. Recall from Chapter 6 in Section 6.5 that E is a linear layer that maps a token id to a vector embedding representing that token. Each token in the vocabulary has an initial embedding representation in E. Transformers also have a special mechanism for encoding the position/index of the token in the input string, which is simply added to the embedding. The resulting embedding represents both the word and its position, and is then passed through a set of L transformer blocks.

It’s common to think of each of these transformer blocks as part of a stream in which the input embedding is directly passed up to the output, while simultaneously being enriched by the application of various processing modules: the multi-head attention layer, feedforward networks and the layer normalization. The value of the stream at any layer for any input token is a vector that is the sum of the original embedding for that token and all the outputs from all the previous layers and blocks.

The core intuition of the transformer, and the component that distinguishes it from the feedforward layers we saw in Chapter 6, is this multi-head attention layer, also called a self-attention layer. Attention can be thought of as a way to build contextual representations of a token’s meaning by attending to and integrating information from surrounding tokens, helping the model learn how tokens relate to each other over large spans. It can also be thought of as a way to move information from one residual stream to another, augmenting the stream at one token position with information from another token position.

After the L transformer blocks we take the output embedding that is produced by the final transformer block, pass it through a linear unembedding matrix U and then a softmax over the vocabulary to generate a distribution over possible next tokens. These last two components (the unembedding matrix and the softmax) are sometimes called the language modeling head. In the rest of this chapter we’ll introduce attention and the rest of these modules in more detail.

![](../images/figure7.2.jpg)  
Figure 7.2 The architecture of a (left-to-right) transformer, showing how each input token gets encoded, passed through a set of stacked transformer blocks, and then a language model head that predicts the next token. The embeddings at each token position in the residual stream are passed up the stack, and the arrows in the figure shows how information from the hidden representations of preceding tokens are also incorporated.

Fig. 7.2 shows the transformer architecture applied to a context window with the words So long and thanks for, showing at each token position what is the most likely token to be generated. In this full figure, the stack of L blocks over n tokens maps an entire context window of input vectors $\left( \mathbf { x } _ { 1 } , . . . , \mathbf { x } _ { n } \right)$ to a window of output vectors $\left( \mathbf { h } _ { 1 } , . . . , \mathbf { h } _ { n } \right)$ of the same length. A column might contain from $L = 1 2$ to $L = 9 6$ or more stacked blocks. The arrows in the figure show how information from the hidden representations of preceding tokens is incorporated into the transformer

block.

Transformer-based language models are complex, and so the details will unfold over this chapter and the next few chapters, in addition to the high-level overview in Chapter 1. This chapter will introduce multi-head attention, the rest of the transformer block, the input encoding and language modeling head components of the transformer, the concepts of decoding and sampling to generate output text, and the details of pretraining. Chapter 8 introduces post-training: fine-tuning and instructiontuning language models to perform NLP tasks, and aligning the model with human preferences. Chapter 9 introduces masked language modeling and the BERT family of bidirectional transformer encoder models. Chapter 13 will introduce machine translation with the encoder-decoder architecture. And we’ll see application of the transformer to speech recognition, as well as further use of the encoder-decoder architecture, in Chapter 16.
