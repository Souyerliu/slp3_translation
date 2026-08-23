## Exercises

5.1 Using the co-occurrence counts in Fig. 5.2, compute cos(cherry, strawberry) and cos(cherry, digital) using only the pie and result dimensions. Which pair is more similar, and does the result match your intuition about the words meanings?

5.2 Show that cosine similarity is invariant to scaling: for any positive constant c, cos $( c \nu , w ) = \cos ( \nu , w )$ . Why is this a desirable property for a word-similarity metric, given the discussion of frequency and vector length in Section 5.4?

5.3 Derive the SGNS gradients in Eq. 5.22-Eq. 5.24 by differentiating the loss in Eq. 5.21 with respect to $c _ { p o s } , c _ { n e g }$ , and w. You may use the fact that $\begin{array} { r } { \frac { d \sigma ( z ) } { d z } = } \end{array}$ $\sigma ( \boldsymbol { z } ) ( 1 - \sigma ( \boldsymbol { z } ) )$ and that $\begin{array} { r } { \frac { d ( c \mathbf { w } ) } { d \mathbf { w } } = c . } \end{array}$
