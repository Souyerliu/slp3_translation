## Exercises

7.1 A transformer has L layers, model dimension d, A attention heads with $d _ { k } =$ $d _ { \nu } = d / A$ , and feedforward dimension $d _ { f } f = 4 d$

a. Count the parameters in one attention layer’s $W ^ { Q } , W ^ { K } , W ^ { V }$ , and $W ^ { O }$ Does your answer depend on A?

b. Count the parameters in one feedforward layer.

c. Show that the full stack of L blocks has about $1 2 L d ^ { 2 }$ parameters, ignoring biases and layer norm.

7.2 Why does the attention mask in Fig. 7.10 use <sub>∞</sub> rather than 0? What would happen if we used 0?

7.3 Compute the perplexity of a language model on the string It was a dream, assuming the conditional probabilities of each respective word are .0001, .0002, .000005, and .0000001.

7.4 Prove that the perplexity of a text is equal to the exp of the mean cross-entropy loss for the text.

7.5 With the logits in Fig. 7.17, compute the probabilities at $\tau = 0 . 2$ and $\tau = 2$ Verify each sums to 1. What happens as $\tau \to 0 ? \mathrm { \ A s \ } \tau \to \infty ?$
