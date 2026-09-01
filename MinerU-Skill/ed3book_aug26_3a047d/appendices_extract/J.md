J

# Pointwise Mutual Information (PMI)

An alternative weighting function to tf-idf, PPMI (positive pointwise mutual information), is used for term-term-matrices, when the vector dimensions correspond to words rather than documents. PPMI draws on the intuition that the best way to weigh the association between two words is to ask how much more the two words co-occur in our corpus than we would have a priori expected them to appear by chance.

Pointwise mutual information (Fano, 1961)<sup>1</sup> is one of the most important concepts in NLP. It is a measure of how often two events x and y occur, compared with what we would expect if they were independent:

$$
I ( x , y ) = \log _ { 2 } \frac { P ( x , y ) } { P ( x ) P ( y ) }\tag{J.2}
$$

The pointwise mutual information between a target word w and a context word c (Church and Hanks 1989, Church and Hanks 1990) is then defined as:

$$
\operatorname { P M I } ( w , c ) = \log _ { 2 } { \frac { P ( w , c ) } { P ( w ) P ( c ) } }\tag{J.3}
$$

The numerator tells us how often we observed the two words together (assuming we compute probability by using the MLE). The denominator tells us how often we would expect the two words to co-occur assuming they each occurred independently; recall that the probability of two independent events both occurring is just the product of the probabilities of the two events. Thus, the ratio gives us an estimate of how much more the two words co-occur than we expect by chance. PMI is a useful tool whenever we need to find words that are strongly associated.

PMI values range from negative to positive infinity. But negative PMI values (which imply things are co-occurring less often than we would expect by chance) tend to be unreliable unless our corpora are enormous. To distinguish whether two words whose individual probability is each $1 0 ^ { - 6 }$ occur together less often than chance, we would need to be certain that the probability of the two occurring together is significantly less than $1 0 ^ { - 1 2 }$ , and this kind of granularity would require an enormous corpus. Furthermore it’s not clear whether it’s even possible to evaluate such scores of ‘unrelatedness’ with human judgments. For this reason it is more common to use Positive PMI (called PPMI) which replaces all negative PMI values with zero (Church and Hanks 1989, Dagan et al. 1993, Niwa and Nitta 1994)<sup>2</sup>:

$$
\mathrm { P P M I } ( w , c ) = \operatorname* { m a x } ( \log _ { 2 } \frac { P ( w , c ) } { P ( w ) P ( c ) } , 0 )\tag{J.4}
$$

(J.1)

More formally, let’s assume we have a co-occurrence matrix F with W rows (words) and C columns (contexts), where $f _ { i j }$ gives the number of times word w<sub>i</sub> occurs with context $c _ { j }$ . This can be turned into a PPMI matrix where $\mathrm { P P M I } _ { i j }$ gives the PPMI value of word w with context $c _ { j }$ (which we can also express as $\mathsf { P P M I } ( \boldsymbol { w } _ { i } , \boldsymbol { c } _ { j } )$ or $\mathrm { P P M I } ( w = i , c = j ) )$ as follows:

$$
\begin{array} { r } { p _ { i j } = \frac { f _ { i j } } { \sum _ { i ^ { \prime } = 1 } ^ { W } \sum _ { j ^ { \prime } = 1 } ^ { C } f _ { i ^ { \prime } j ^ { \prime } } } , ~ p _ { i ^ { * } } = \frac { \sum _ { j = 1 } ^ { C } f _ { i j } } { \sum _ { i ^ { \prime } = 1 } ^ { W } \sum _ { j ^ { \prime } = 1 } ^ { C } f _ { i ^ { \prime } j ^ { \prime } } } , ~ p _ { * j } = \frac { \sum _ { i = 1 } ^ { W } f _ { i j } } { \sum _ { i ^ { \prime } = 1 } ^ { W } \sum _ { j ^ { \prime } = 1 } ^ { C } f _ { i ^ { \prime } j ^ { \prime } } } } \end{array}\tag{J.5}
$$

$$
\mathrm { P P M I } _ { i j } = \operatorname* { m a x } ( \log _ { 2 } \frac { p _ { i j } } { p _ { i * } p _ { * j } } , 0 )\tag{J.6}
$$

Let’s see some PPMI calculations. We’ll use Fig. J.2, which repeats Fig. J.1 plus all the count marginals, and let’s pretend for ease of calculation that these are the only words/contexts that matter.

Here’s the original figure:

<table><tr><td></td><td>aardvark</td><td></td><td>computer</td><td>data</td><td>result</td><td>pie</td><td>sugar</td><td>…</td></tr><tr><td>cherry</td><td>0</td><td></td><td>2</td><td>8</td><td>9</td><td>442</td><td>25</td><td>·</td></tr><tr><td>strawberry</td><td>0</td><td></td><td>0</td><td>0</td><td>1</td><td>60</td><td>19</td><td>...</td></tr><tr><td>digital</td><td>0</td><td></td><td>1670</td><td>1683</td><td>85</td><td>5</td><td>4</td><td></td></tr><tr><td>information</td><td>0</td><td></td><td>3325</td><td>3982</td><td>378</td><td>5</td><td>13</td><td>...</td></tr></table>

Figure J.1 Co-occurrence vectors for four words in the Wikipedia corpus, showing six of the dimensions (hand-picked for pedagogical purposes). The vector for digital is outlined in red. Note that a real vector would have vastly more dimensions and thus be much sparser, i.e. would have zero values in most dimensions.

<table><tr><td></td><td>computer</td><td>data</td><td>result</td><td>pie</td><td>sugar</td><td>count(w)</td></tr><tr><td>cherry</td><td>2</td><td>8</td><td>9</td><td>442</td><td>25</td><td>486</td></tr><tr><td>strawberry</td><td>0</td><td>0</td><td>1</td><td>60</td><td>19</td><td>80</td></tr><tr><td>digital</td><td>1670</td><td>1683</td><td>85</td><td>5</td><td>4</td><td>3447</td></tr><tr><td>information</td><td>3325</td><td>3982</td><td>378</td><td>5</td><td>13</td><td>7703</td></tr><tr><td>count(context)</td><td>4997</td><td>5673</td><td>473</td><td>512</td><td>61</td><td>11716</td></tr></table>

Figure J.2 Co-occurrence counts for four words in 5 contexts in the Wikipedia corpus, together with the marginals, pretending for the purpose of this calculation that no other words/contexts matter.

Thus for example we could compute PPMI(information,data), assuming we pretended that Fig. J.1 encompassed all the relevant word contexts/dimensions, as follows:

$$
\begin{array} { r c l } { { \displaystyle P ( \mathrm { w = i n f o r m a t i o n } , \mathsf { c = d a t a } ) ~ = ~ \frac { 3 9 8 2 } { 1 1 7 1 6 } = . 3 3 9 9 } } \\ { { \displaystyle P ( \mathrm { w = i n f o r m a t i o n } ) ~ = ~ \frac { 7 7 0 3 } { 1 1 7 1 6 } = . 6 5 7 5 } } \\ { { \displaystyle P ( \mathrm { c = d a t a } ) ~ = ~ \frac { 5 6 7 3 } { 1 1 7 1 6 } = . 4 8 4 2 } } \\ { { \displaystyle \mathrm { P P M I ( i n f o r m a t i o n , d a t a ) } ~ = ~ \log _ { 2 } ( . 3 3 9 9 / ( . 6 5 7 5 * . 4 8 4 2 ) ) = . 0 9 4 4 } } \end{array}
$$

Fig. J.3 shows the joint probabilities computed from the counts in Fig. J.2, and Fig. J.4 shows the PPMI values. Not surprisingly, cherry and strawberry are highly associated with both pie and sugar, and data is mildly associated with information.

<table><tr><td colspan="6">p(w,context)</td><td>p(w)</td></tr><tr><td></td><td>computer</td><td>data</td><td>result</td><td>pie</td><td>sugar</td><td>p(w)</td></tr><tr><td>cherry</td><td>0.0002</td><td>0.0007</td><td>0.0008</td><td>0.0377</td><td>0.0021</td><td>0.0415</td></tr><tr><td>strawberry</td><td>0.0000</td><td>0.0000</td><td>0.0001</td><td>0.0051</td><td>0.0016</td><td>0.0068</td></tr><tr><td>digital</td><td>0.1425</td><td>0.1436</td><td>0.0073</td><td>0.0004</td><td>0.0003</td><td>0.2942</td></tr><tr><td>information</td><td>0.2838</td><td>0.3399</td><td>0.0323</td><td>0.0004</td><td>0.0011</td><td>0.6575</td></tr><tr><td>p(context)</td><td>0.4265</td><td>0.4842</td><td>0.0404</td><td>0.0437</td><td>0.0052</td><td></td></tr></table>

Figure J.3 Replacing the counts in Fig. J.1 with joint probabilities, showing the marginals in the right column and the bottom row.

<table><tr><td></td><td>computer</td><td>data</td><td>result</td><td>pie</td><td>sugar</td></tr><tr><td>cherry</td><td>0</td><td>0</td><td>0</td><td>4.38</td><td>3.30</td></tr><tr><td>strawberry</td><td>0</td><td>0</td><td>0</td><td>4.10</td><td>5.51</td></tr><tr><td>digital</td><td>0.18</td><td>0.01</td><td>0</td><td>0</td><td>0</td></tr><tr><td>information</td><td>0.02</td><td>0.09</td><td>0.28</td><td>0</td><td>0</td></tr></table>

Figure J.4 The PPMI matrix showing the association between words and context words, computed from the counts in Fig. J.3. Note that most of the 0 PPMI values are ones that had a negative PMI; for example PMI(cherry,computer) = -6.7, meaning that cherry and computer co-occur on Wikipedia less often than we would expect by chance, and with PPMI we replace negative values by zero.

PMI has the problem of being biased toward infrequent events; very rare words tend to have very high PMI values. One way to reduce this bias toward low frequency events is to slightly change the computation for $P ( c )$ , using a different function $P _ { \alpha } ( c )$ that raises the probability of the context word to the power of α:

$$
\mathrm { P P M I } _ { \alpha } ( w , c ) = \operatorname* { m a x } ( \log _ { 2 } \frac { P ( w , c ) } { P ( w ) P _ { \alpha } ( c ) } , 0 )\tag{J.7}
$$

$$
P _ { \alpha } ( c ) = { \frac { c o u n t ( c ) ^ { \alpha } } { \sum _ { c } c o u n t ( c ) ^ { \alpha } } }\tag{J.8}
$$

Levy et al. (2015) found that a setting of $\alpha = 0 . 7 5$ improved performance of embeddings on a wide range of tasks (drawing on a similar weighting used for skipgrams described in Chapter 5. This works because raising the count to $\alpha = 0 . 7 5$ increases the probability assigned to rare contexts, and hence lowers their PMI $( P _ { \alpha } ( c ) > P ( c )$ when c is rare).

Another possible solution is Laplace smoothing: Before computing PMI, a small constant k (values of 0.1-3 are common) is added to each of the counts, shrinking (discounting) all the non-zero values. The larger the $k ,$ , the more the non-zero counts are discounted.

Church, K. W. and P. Hanks. 1989. Word association norms, mutual information, and lexicography. ACL.

Church, K. W. and P. Hanks. 1990. Word association norms, mutual information, and lexicography. Computational Linguistics, 16(1):22–29.

Dagan, I., S. Marcus, and S. Markovitch. 1993. Contextual word similarity and estimation from sparse data. ACL.

Fano, R. M. 1961. Transmission of Information: A Statistical Theory ofCommunications. MIT Press.

Levy, O., Y. Goldberg, and I. Dagan. 2015. Improving distributional similarity with lessons learned from word embeddings. TACL, 3:211–225.

Niwa, Y. and Y. Nitta. 1994. Co-occurrence vectors from corpora vs. distance vectors from dictionaries. COLING.