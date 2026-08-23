# Lexicons for Sentiment, Affect, and Connotation

Some day we’ll be able to measure the power ofwords

Maya Angelou

In this chapter we turn to tools for interpreting affective meaning, extending our study of sentiment analysis in Appendix B. We use the word ‘affective’, following the tradition in affective computing (Picard, 1995) to mean emotion, sentiment, personality, mood, and attitudes. Affective meaning is closely related to subjectivity, the study of a speaker or writer’s evaluations, opinions, emotions, and speculations (Wiebe et al., 1999).

How should affective meaning be defined? One influential typology of affective states comes from Scherer (2000), who defines each class of affective states by factors like its cognitive realization and time course (Fig. 23.1).

Emotion: Relatively brief episode of response to the evaluation of an external or internal event as being of major significance. (angry, sad, joyful,fearful, ashamed, proud, elated, desperate)

Mood: Diffuse affect state, most pronounced as change in subjective feeling, of low intensity but relatively long duration, often without apparent cause. (cheerful, gloomy, irritable, listless, depressed, buoyant)

Interpersonal stance: Affective stance taken toward another person in a specific interaction, coloring the interpersonal exchange in that situation. (distant, cold, warm, supportive, contemptuous,friendly)

Attitude: Relatively enduring, affectively colored beliefs, preferences, and predispositions towards objects or persons. (liking, loving, hating, valuing, desiring)

Personality traits: Emotionally laden, stable personality dispositions and behavior tendencies, typical for a person. (nervous, anxious, reckless, morose, hostile, jealous)

Figure 23.1 The Scherer typology of affective states (Scherer, 2000).

We can design extractors for each of these kinds of affective states. Appendix B already introduced sentiment analysis, the task of extracting the positive or negative orientation that a writer expresses in a text. This corresponds in Scherer’s typology to the extraction of attitudes: figuring out what people like or dislike, from affectrich texts like consumer reviews of books or movies, newspaper editorials, or public sentiment in blogs or tweets.

Detecting emotion and moods is useful for detecting whether a student is confused, engaged, or certain when interacting with a tutorial system, whether a caller to a help line is frustrated, whether someone’s blog posts or tweets indicated depression. Detecting emotions like fear in novels, for example, could help us trace what groups or situations are feared and how that changes over time.

Detecting different interpersonal stances can be useful when extracting information from human-human conversations. The goal here is to detect stances like friendliness or awkwardness in interviews or friendly conversations, for example for summarizing meetings or finding parts of a conversation where people are especially excited or engaged, conversational hot spots that can help in meeting summarization. Detecting the personality of a user—such as whether the user is an extrovert or the extent to which they are open to experience— can help improve conversational agents, which seem to work better if they match users’ personality expectations (Mairesse and Walker, 2008). And affect is important for generation as well as recognition; synthesizing affect is important for conversational agents in various domains, including literacy tutors such as children’s storybooks, or computer games.

In Appendix B we introduced the use of naive Bayes classification to classify a document’s sentiment. Various classifiers have been successfully applied to many of these tasks, using all the words in the training set as input to a classifier which then determines the affect status of the text.

In this chapter we focus on an alternative model, in which instead of using every word as a feature, we focus only on certain words, ones that carry particularly strong cues to affect or sentiment. We call these lists of words affective lexicons or sentiment lexicons. These lexicons presuppose a fact about semantics: that words have affective meanings or connotations. The word connotation has different meanings in different fields, but here we use it to mean the aspects of a word’s meaning that are related to a writer or reader’s emotions, sentiment, opinions, or evaluations. In addition to their ability to help determine the affective status of a text, connotation lexicons can be useful features for other kinds of affective tasks, and for computational social science analysis.

In the next sections we introduce basic theories of emotion, show how sentiment lexicons are a special case of emotion lexicons, and mention some useful lexicons. We then survey three ways for building lexicons: human labeling, semi-supervised, and supervised. Finally, we talk about how to detect affect toward a particular entity, and introduce connotation frames.

## 23.1 Defining Emotion

One of the most important affective classes is emotion, which Scherer (2000) defines as a “relatively brief episode of response to the evaluation of an external or internal event as being of major significance”.

Detecting emotion has the potential to improve a number of language processing tasks. Emotion recognition could help dialogue systems like tutoring systems detect that a student was unhappy, bored, hesitant, confident, and so on. Automatically detecting emotions in reviews or customer responses (anger, dissatisfaction, trust) could help businesses recognize specific problem areas or ones that are going well. Emotion can play a role in medical NLP tasks like helping diagnose depression or suicidal intent. Detecting emotions expressed toward characters in novels might play a role in understanding how different social groups were viewed by society at different times.

Computational models of emotion in NLP have mainly been based on two families of theories of emotion (out of the many studied in the field of affective science). In one of these families, emotions are viewed as fixed atomic units, limited in number, and from which others are generated, often called basic emotions (Tomkins

1962, Plutchik 1962), a model dating back to Darwin. Perhaps the most well-known of this family of theories are the 6 emotions proposed by Ekman (e.g., Ekman 1999) to be universally present in all cultures: surprise, happiness, anger, fear, disgust, sadness. Another atomic theory is the Plutchik (1980) wheel of emotion, consisting of 8 basic emotions in four opposing pairs: joy–sadness, anger–fear, trust–disgust, and anticipation–surprise, together with the emotions derived from them, shown in Fig. 23.2.

![](images/figure23.2.jpg)  
Figure 23.2 Plutchik wheel of emotion.

The second class of emotion theories widely used in NLP views emotion as a space in 2 or 3 dimensions (Russell, 1980). Most models include the two dimensions valence and arousal, and many add a third, dominance. These can be defined as:

valence: the pleasantness of the stimulus

arousal: the level of alertness, activeness, or energy provoked by the stimulus

dominance: the degree of control or dominance exerted by the stimulus or the emotion

Sentiment can be viewed as a special case of this second view of emotions as points in space. In particular, the valence dimension, measuring how pleasant or unpleasant a word is, is often used directly as a measure of sentiment.

In these lexicon-based models of affect, the affective meaning of a word is generally fixed, irrespective of the linguistic context in which a word is used, or the dialect or culture of the speaker. By contrast, other models in affective science represent emotions as much richer processes involving cognition (Barrett et al., 2007). In appraisal theory, for example, emotions are complex processes, in which a person considers how an event is congruent with their goals, taking into account variables like the agency, certainty, urgency, novelty and control associated with the event (Moors et al., 2013). Computational models in NLP taking into account these richer theories of emotion will likely play an important role in future work.

## 23.2 Available Sentiment and Affect Lexicons

A wide variety of affect lexicons have been created and released. The most basic lexicons label words along one dimension of semantic variability, generally called “sentiment” or “valence”.

In the simplest lexicons this dimension is represented in a binary fashion, with a wordlist for positive words and a wordlist for negative words. The oldest is the General Inquirer (Stone et al., 1966), which drew on content analysis and on early work in the cognitive psychology of word meaning (Osgood et al., 1957). The General Inquirer has a lexicon of 1915 positive words and a lexicon of 2291 negative words (as well as other lexicons discussed below). The MPQA Subjectivity lexicon (Wilson et al., 2005) has 2718 positive and 4912 negative words drawn from prior lexicons plus a bootstrapped list of subjective words and phrases (Riloff and Wiebe, 2003). Each entry in the lexicon is hand-labeled for sentiment and also labeled for reliability (strongly subjective or weakly subjective). The polarity lexicon of Hu and Liu (2004) gives 2006 positive and 4783 negative words, drawn from product reviews, labeled using a bootstrapping method from WordNet.

<table><tr><td>Positive</td><td>admire, amazing, assure, celebration, charm, eager, enthusiastic, excellent, fancy, fantastic, frolic, graceful, happy, joy, luck, majesty, mercy, nice, patience, perfect, proud, rejoice, relief, respect, satisfactorily, sensational, super, terrific, thank, vivid, wise, wonderful, zest</td></tr><tr><td>Negative</td><td>abominable, anger, anxious, bad, catastrophe, cheap, complaint, condescending, deceit, defective, disappointment, embarrass, fake, fear, filthy, fool, guilt, hate, idiot, inflict, lazy, miserable, mourn, nervous, objection, pest, plot, reject, scream, silly, terrible, unfriendly, vile, wicked</td></tr></table>

Figure 23.3 Some words with consistent sentiment across the General Inquirer (Stone et al., 1966), the MPQA Subjectivity lexicon (Wilson et al., 2005), and the polarity lexicon of Hu and Liu (2004).

Slightly more general than these sentiment lexicons are lexicons that assign each word a value on all three affective dimensions. The NRC Valence, Arousal, and Dominance (VAD) lexicon (Mohammad, 2018a) assigns valence, arousal, and dominance scores to 20,000 words. Some examples are shown in Fig. 23.4.

<table><tr><td colspan="2">Valence</td><td colspan="2">Arousal</td><td colspan="2">Dominance</td></tr><tr><td>vacation</td><td>.840</td><td>enraged</td><td>.962</td><td>powerful</td><td>.991</td></tr><tr><td>delightful</td><td>.918</td><td>party</td><td>.840</td><td>authority</td><td>.935</td></tr><tr><td>whistle</td><td>.653</td><td>organized</td><td>.337</td><td>saxophone</td><td>.482</td></tr><tr><td>consolation</td><td>.408</td><td>effortless</td><td>.120</td><td>discouraged</td><td>.0090</td></tr><tr><td>torture</td><td>.115</td><td>napping</td><td>.046</td><td>weak</td><td>.045</td></tr></table>

Figure 23.4 Values of sample words on the emotional dimensions of Mohammad (2018a).

The NRC Word-Emotion Association Lexicon, also called EmoLex (Mohammad and Turney, 2013), uses the Plutchik (1980) 8 basic emotions defined above. The lexicon includes around 14,000 words including words from prior lexicons as well as frequent nouns, verbs, adverbs and adjectives. Values from the lexicon for some sample words:

<table><tr><td>Word</td><td>anger</td><td>anticipation</td><td>disgust</td><td>fear</td><td>joy</td><td>sadness</td><td>surprise</td><td>trust</td><td>positive</td><td>negative</td></tr><tr><td>reward</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>0</td><td>1</td><td>1</td><td>1</td><td>0</td></tr><tr><td>worry</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td></tr><tr><td>tenderness</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td></tr><tr><td>sweetheart</td><td>0</td><td>1</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>1</td><td>1</td><td>0</td></tr><tr><td>suddenly</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td></tr><tr><td>thirst</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>1</td><td>0</td><td>0</td><td>0</td></tr><tr><td>garbage</td><td>0</td><td>0</td><td>1</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>1</td></tr></table>

For a smaller set of 5,814 words, the NRC Emotion/Affect Intensity Lexicon (Mohammad, 2018b) contains real-valued scores of association for anger, fear, joy, and sadness; Fig. 23.5 shows examples.

<table><tr><td colspan="2">Anger</td><td colspan="2">Fear</td><td colspan="2">Joy</td><td colspan="2">Sadness</td></tr><tr><td>outraged violence coup oust suspicious nurture</td><td>0.964 0.742 0.578 0.484 0.484 0.059</td><td>horror anguish pestilence stressed failing confident</td><td>0.923 0.703 0.625 0.531 0.531 0.094</td><td>superb cheered rainbow gesture warms hardship</td><td>0.864 0.773 0.531 0.387 0.391 .031</td><td>sad guilt unkind difficulties beggar sing</td><td>0.844 0.750 0.547 0.421 0.422 0.017</td></tr></table>

Figure 23.5 Sample emotional intensities for words for anger, fear, joy, and sadness from Mohammad (2018b).

LIWC, Linguistic Inquiry and Word Count, is a widely used set of 73 lexicons containing over 2300 words (Pennebaker et al., 2007), designed to capture aspects of lexical meaning relevant for social psychological tasks. In addition to sentiment-related lexicons like ones for negative emotion (bad, weird, hate, problem, tough) and positive emotion (love, nice, sweet), LIWC includes lexicons for categories like anger, sadness, cognitive mechanisms, perception, tentative, and inhibition, shown in Fig. 23.6.

There are various other hand-built affective lexicons. The General Inquirer includes additional lexicons for dimensions like strong vs. weak, active vs. passive, overstated vs. understated, as well as lexicons for categories like pleasure, pain, virtue, vice, motivation, and cognitive orientation.

Another useful feature for various tasks is the distinction between concrete words like banana or bathrobe and abstract words like belief and although. The lexicon in Brysbaert et al. (2014) used crowdsourcing to assign a rating from 1 to 5 of the concreteness of 40,000 words, thus assigning banana, bathrobe, and bagel 5, belief1.19, although 1.07, and in between words like brisk a 2.5.

## 23.3 Creating Affect Lexicons by Human Labeling

The earliest method used to build affect lexicons, and still in common use, is to have crowdsourcing humans label each word. This is now most commonly done via crowdsourcing: breaking the task into small pieces and distributing them to a large number of annotators. Let’s take a look at some of the methodological choices for two crowdsourced emotion lexicons.

<table><tr><td>Positive Emotion</td><td>Negative Emotion</td><td>Insight</td><td>Inhibition</td><td>Family</td><td>Negate</td></tr><tr><td>appreciat*</td><td>anger*</td><td>aware*</td><td>avoid*</td><td>brother*</td><td>aren’t</td></tr><tr><td>comfort*</td><td>bore*</td><td>believe</td><td>careful*</td><td>cousin*</td><td>cannot</td></tr><tr><td>great</td><td>cry</td><td>decid*</td><td>hesitat*</td><td>daughter*</td><td>didn’t</td></tr><tr><td>happy</td><td>despair*</td><td>feel</td><td>limit*</td><td>family</td><td>neither</td></tr><tr><td>interest</td><td>fail*</td><td>figur*</td><td>oppos*</td><td>father*</td><td>never</td></tr><tr><td>joy*</td><td>fear</td><td>know</td><td>prevent*</td><td>grandf*</td><td>no</td></tr><tr><td>perfect*</td><td>griev*</td><td>knew</td><td>reluctan*</td><td>grandm*</td><td>nobod*</td></tr><tr><td>please*</td><td>hate*</td><td>means</td><td>safe*</td><td>husband</td><td>none</td></tr><tr><td>safe*</td><td>panic*</td><td>notice*</td><td>stop</td><td>mom</td><td>nor</td></tr><tr><td>terrific</td><td>suffers</td><td>recogni*</td><td>stubborn*</td><td>mother</td><td>nothing</td></tr><tr><td>value</td><td>terrify</td><td>sense</td><td>wait</td><td>niece*</td><td>nowhere</td></tr><tr><td>wow*</td><td>violent*</td><td>think</td><td>wary</td><td>wife</td><td>without</td></tr></table>

Figure 23.6 Samples from 5 of the 73 lexical categories in LIWC (Pennebaker et al., 2007). The \* means the previous letters are a word prefix and all words with that prefix are included in the category.

The NRC Emotion Lexicon (EmoLex) (Mohammad and Turney, 2013), labeled emotions in two steps. To ensure that the annotators were judging the correct sense of the word, they first answered a multiple-choice synonym question that primed the correct sense of the word (without requiring the annotator to read a potentially confusing sense definition). These were created automatically using the headwords associated with the thesaurus category of the sense in question in the Macquarie dictionary and the headwords of 3 random distractor categories. An example:

Which word is closest in meaning (most related) to startle?

• automobile

• shake

• honesty

• entertain

For each word (e.g. startle), the annotator was then asked to rate how associated that word is with each of the 8 emotions (joy, fear, anger, etc.). The associations were rated on a scale of not, weakly, moderately, and strongly associated. Outlier ratings were removed, and then each term was assigned the class chosen by the majority of the annotators, with ties broken by choosing the stronger intensity, and then the 4 levels were mapped into a binary label for each word (no and weak mapped to 0, moderate and strong mapped to 1).

The NRC VAD Lexicon (Mohammad, 2018a) was built by selecting words and emoticons from prior lexicons and annotating them with crowd-sourcing using bestworst scaling (Louviere et al. 2015, Kiritchenko and Mohammad 2017). In bestworst scaling, annotators are given N items (usually 4) and are asked which item is the best (highest) and which is the worst (lowest) in terms of some property. The set of words used to describe the ends of the scales are taken from prior literature. For valence, for example, the raters were asked:

Q1. Which of the four words below is associated with the MOST happiness / pleasure / positiveness / satisfaction / contentedness / hopefulness OR LEAST unhappiness / annoyance / negativeness / dissatisfaction /

split-half reliability

melancholy / despair? (Four words listed as options.)

Q2. Which of the four words below is associated with the LEAST happiness / pleasure / positiveness / satisfaction / contentedness / hopefulness OR MOST unhappiness / annoyance / negativeness / dissatisfaction / melancholy / despair? (Four words listed as options.)

The score for each word in the lexicon is the proportion of times the item was chosen as the best (highest V/A/D) minus the proportion of times the item was chosen as the worst (lowest V/A/D). The agreement between annotations are evaluated by splithalf reliability: split the corpus in half and compute the correlations between the annotations in the two halves.

## 23.4 Semi-supervised Induction of Affect Lexicons

Another common way to learn sentiment lexicons is to start from a set of seed words that define two poles of a semantic axis (words like good or bad), and then find ways to label each word w by its similarity to the two seed sets. Here we summarize two families of seed-based semi-supervised lexicon induction algorithms, axis-based and graph-based.

## 23.4.1 Semantic Axis Methods

One of the most well-known lexicon induction methods, the Turney and Littman (2003) algorithm, is given seed words like good or bad, and then for each word w to be labeled, measures both how similar it is to good and how different it is from bad. Here we describe a slight extension of the algorithm due to An et al. (2018), which is based on computing a semantic axis.

In the first step, we choose seed words by hand. There are two methods for dealing with the fact that the affect of a word is different in different contexts: (1) start with a single large seed lexicon and rely on the induction algorithm to fine-tune it to the domain, or (2) choose different seed words for different genres. Hellrich et al. (2019) suggests that for modeling affect across different historical time periods, starting with a large modern affect dictionary is better than small seedsets tuned to be stable across time. As an example of the second approach, Hamilton et al. (2016a) define one set of seed words for general sentiment analysis, a different set for Twitter, and yet another set for sentiment in financial text:

<table><tr><td>Domain</td><td>Positive seeds</td><td>Negative seeds</td></tr><tr><td>General</td><td>good, lovely, excellent, fortunate, pleasant, delightful, perfect, loved, love, happy</td><td>bad, horrible, poor, unfortunate, unpleasant, disgusting, evil, hated, hate, unhappy</td></tr><tr><td>Twitter</td><td>love, loved, loves, awesome, nice, amazing, best, fantastic, correct, happy</td><td>hate, hated, hates, terrible, nasty, awful, worst, horrible, wrong, sad</td></tr><tr><td>Finance</td><td>successful, excellent, profit, beneficial, improving, improved, success, gains, positive</td><td>negligent, loss, volatile, wrong, losses, damages, bad, litigation, failure, down, negative</td></tr></table>

In the second step, we compute embeddings for each of the pole words. These embeddings can be off-the-shelf word2vec embeddings, or can be computed directly on a specific corpus (for example using a financial corpus if a finance lexicon is the goal), or we can fine-tune off-the-shelf embeddings to a corpus. Fine-tuning is especially important if we have a very specific genre of text but don’t have enough data to train good embeddings. In fine-tuning, we begin with off-the-shelf embeddings like word2vec, and continue training them on the small target corpus.

Once we have embeddings for each pole word, we create an embedding that represents each pole by taking the centroid of the embeddings of each of the seed words; recall that the centroid is the multidimensional version of the mean. Given a set of embeddings for the positive seed words $S ^ { + } = \{ E ( w _ { 1 } ^ { + } ) , E ( w _ { 2 } ^ { + } ) , . . . , E ( w _ { n } ^ { + } ) \}$ , and embeddings for the negative seed words $S ^ { - } = \{ E ( w _ { 1 } ^ { - } ) , E ( w _ { 2 } ^ { - } ) , . . . , E ( w _ { m } ^ { - } ) \}$ , the pole centroids are:

$$
\begin{array}{l} \mathbf {V} ^ {+} = \frac {1}{n} \sum_ {1} ^ {n} E (w _ {i} ^ {+}) \\ \mathbf {V} ^ {-} = \frac {1}{m} \sum_ {1} ^ {m} E (w _ {i} ^ {-}) \end{array}\tag{23.1}
$$

The semantic axis defined by the poles is computed just by subtracting the two vectors:

$$
\mathbf {V} _ {\text {axis}} = \mathbf {V} ^ {+} - \mathbf {V} ^ {-}\tag{23.2}
$$

$\pmb { \mathsf { v } } _ { a x i s }$ , the semantic axis, is a vector in the direction of positive sentiment. Finally, we compute (via cosine similarity) the angle between the vector in the direction of positive sentiment and the direction of w’s embedding. A higher cosine means that w is more aligned with $S ^ { + }$ than $S ^ { - }$

$$
\begin{array}{r c l} \text {score} (w) & = & \cos \left(E (w), \mathbf {V} _ {\text {axis}}\right) \\ & = & \frac {E (w) \cdot \mathbf {V} _ {\text {axis}}}{\| E (w) \| \| \mathbf {V} _ {\text {axis}} \|} \end{array}\tag{23.3}
$$

If a dictionary of words with sentiment scores is sufficient, we’re done! Or if we need to group words into a positive and a negative lexicon, we can use a threshold or other method to give us discrete lexicons.

## 23.4.2 Label Propagation

An alternative family of methods defines lexicons by propagating sentiment labels on graphs, an idea suggested in early work by Hatzivassiloglou and McKeown (1997). We’ll describe the simple SentProp (Sentiment Propagation) algorithm of Hamilton et al. (2016a), which has four steps:

1. Define a graph: Given word embeddings, build a weighted lexical graph by connecting each word with its k nearest neighbors (according to cosine similarity). The weights of the edge between words w<sub>i</sub> and $w _ { j }$ are set as:

$$
\mathbf {E} _ {i, j} = \arccos \left(- \frac {\mathbf {w _ {i}} ^ {\top} \mathbf {w _ {j}}}{\| \mathbf {w _ {i}} \| \| \mathbf {w _ {j}} \|}\right).\tag{23.4}
$$

2. Define a seed set: Choose positive and negative seed words.

3. Propagate polarities from the seed set: Now we perform a random walk on this graph, starting at the seed set. In a random walk, we start at a node and then choose a node to move to with probability proportional to the edge probability. A word’s polarity score for a seed set is proportional to the probability of a random walk from the seed set landing on that word (Fig. 23.7).

4. Create word scores: We walk from both positive and negative seed sets, resulting in positive (rawscore $^ + ( w _ { i } ) )$ and negative (rawscore $\mathbf { \nabla } \cdot ( w _ { i } ) )$ raw label scores. We then combine these values into a positive-polarity score as:

$$
\operatorname{score} ^ {+} \left(w _ {i}\right) = \frac {\operatorname{rawscore} ^ {+} \left(w _ {i}\right)}{\operatorname{rawscore} ^ {+} \left(w _ {i}\right) + \operatorname{rawscore} ^ {-} \left(w _ {i}\right)}\tag{23.5}
$$

It’s often helpful to standardize the scores to have zero mean and unit variance within a corpus.

5. Assign confidence to each score: Because sentiment scores are influenced by the seed set, we’d like to know how much the score of a word would change if a different seed set is used. We can use bootstrap sampling to get confidence regions, by computing the propagation B times over random subsets of the positive and negative seed sets (for example using $B = 5 0$ and choosing 7 of the 10 seed words each time). The standard deviation of the bootstrap sampled polarity scores gives a confidence measure.

![](images/figure23.7.jpg)  
Figure 23.7 Intuition of the SENTPROP algorithm. (a) Run random walks from the seed words. (b) Assign polarity scores (shown here as colors green or red) based on the frequency of random walk visits.

## 23.4.3 Other Methods

The core of semisupervised algorithms is the metric for measuring similarity with the seed words. The Turney and Littman (2003) and Hamilton et al. (2016a) approaches above used embedding cosine as the distance metric: words were labeled as positive basically if their embeddings had high cosines with positive seeds and low cosines with negative seeds. Other methods have chosen other kinds of distance metrics besides embedding cosine.

For example the Hatzivassiloglou and McKeown (1997) algorithm uses syntactic cues; two adjectives are considered similar if they were frequently conjoined by and and rarely conjoined by but. This is based on the intuition that adjectives conjoined by the words and tend to have the same polarity; positive adjectives are generally coordinated with positive, negative with negative:

fair and legitimate, corrupt and brutal

but less often positive adjectives coordinated with negative:

\*fair and brutal, \*corrupt and legitimate

By contrast, adjectives conjoined by but are likely to be of opposite polarity:

fair but brutal

Another cue to opposite polarity comes from morphological negation (un-, im-, -less). Adjectives with the same root but differing in a morphological negative (adequate/inadequate, thoughtful/thoughtless) tend to be of opposite polarity.

Yet another method for finding words that have a similar polarity to seed words is to make use of a thesaurus like WordNet (Kim and Hovy 2004, Hu and Liu 2004). A word’s synonyms presumably share its polarity while a word’s antonyms probably have the opposite polarity. After a seed lexicon is built, each lexicon is updated as follows, possibly iterated.

Lex<sup>+</sup>: Add synonyms of positive words (well) and antonyms (like fine) of negative words

Lex−: Add synonyms of negative words (awful) and antonyms (like evil) of positive words

An extension of this algorithm assigns polarity to WordNet senses, called Senti-WordNet (Baccianella et al., 2010). Fig. 23.8 shows some examples.

<table><tr><td colspan="2">Synset</td><td>Pos</td><td>Neg</td><td>Obj</td></tr><tr><td>good#6</td><td>‘agreeable or pleasing’</td><td>1</td><td>0</td><td>0</td></tr><tr><td>respectable#2</td><td>honorable#4 good#4 estimable#2 ‘deserving of esteem’</td><td>0.75</td><td>0</td><td>0.25</td></tr><tr><td>estimable#3</td><td>computable#1 ‘may be computed or estimated’</td><td>0</td><td>0</td><td>1</td></tr><tr><td>sting#1</td><td>burn#4 bite#2 ‘cause a sharp or stinging pain’</td><td>0</td><td>0.875</td><td>.125</td></tr><tr><td>acute#6</td><td>‘of critical importance and consequence’</td><td>0.625</td><td>0.125</td><td>.250</td></tr><tr><td>acute#4</td><td>‘of an angle; less than 90 degrees’</td><td>0</td><td>0</td><td>1</td></tr><tr><td>acute#1</td><td>‘having or experiencing a rapid onset and short but severe course’</td><td>0</td><td>0.5</td><td>0.5</td></tr></table>

Figure 23.8 Examples from SentiWordNet 3.0 (Baccianella et al., 2010). Note the differences between senses of homonymous words: estimable#3 is purely objective, while estimable#2 is positive; acute can be positive (acute#6), negative (acute#1), or neutral (acute #4).

In this algorithm, polarity is assigned to entire synsets rather than words. A positive lexicon is built from all the synsets associated with 7 positive words, and a negative lexicon from synsets associated with 7 negative words. A classifier is then trained from this data to take a WordNet gloss and decide if the sense being defined is positive, negative or neutral. A further step (involving a random-walk algorithm) assigns a score to each WordNet synset for its degree of positivity, negativity, and neutrality.

In summary, semisupervised algorithms use a human-defined set of seed words for the two poles of a dimension, and use similarity metrics like embedding cosine, coordination, morphology, or thesaurus structure to score words by how similar they are to the positive seeds and how dissimilar to the negative seeds.

## 23.5 Supervised Learning of Word Sentiment

Semi-supervised methods require only minimal human supervision (in the form of seed sets). But sometimes a supervision signal exists in the world and can be made use of. One such signal is the scores associated with online reviews.

The web contains an enormous number of online reviews for restaurants, movies, books, or other products, each of which have the text of the review along with an associated review score: a value that may range from 1 star to 5 stars, or scoring 1 to 10. Fig. 23.9 shows samples extracted from restaurant, book, and movie reviews.

<table><tr><td colspan="2">Movie review excerpts (IMDb)</td></tr><tr><td>10</td><td>A great movie. This film is just a wonderful experience. It’s surreal, zany, witty and slapstick all at the same time. And terrific performances too.</td></tr><tr><td>1</td><td>This was probably the worst movie I have ever seen. The story went nowhere even though they could have done some interesting stuff with it.</td></tr><tr><td colspan="2">Restaurant review excerpts (Yelp)</td></tr><tr><td>5</td><td>The service was impeccable. The food was cooked and seasoned perfectly... The watermelon was perfectly square ... The grilled octopus was ... mouthwatering...</td></tr><tr><td>2</td><td>...it took a while to get our waters, we got our entree before our starter, and we never received silverware or napkins until we requested them...</td></tr><tr><td colspan="2">Book review excerpts (GoodReads)</td></tr><tr><td>1</td><td>I am going to try and stop being deceived by eye-catching titles. I so wanted to like this book and was so disappointed by it.</td></tr><tr><td>5</td><td>This book is hilarious. I would recommend it to anyone looking for a satirical read with a romantic twist and a narrator that keeps butting in</td></tr><tr><td colspan="2">Product review excerpts (Amazon)</td></tr><tr><td>5</td><td>The lid on this blender though is probably what I like the best about it... enables you to pour into something without even taking the lid off! ... the perfect pitcher! ... works fantastic.</td></tr><tr><td>1</td><td>I hate this blender... It is nearly impossible to get frozen fruit and ice to turn into a smoothie... You have to add a TON of liquid. I also wish it had a spout ...</td></tr></table>

Figure 23.9 Excerpts from some reviews from various review websites, all on a scale of 1 to 5 stars except IMDb, which is on a scale of 1 to 10 stars.

We can use this review score as supervision: positive words are more likely to appear in 5-star reviews; negative words in 1-star reviews. And instead of just a binary polarity, this kind of supervision allows us to assign a word a more complex representation of its polarity: its distribution over stars (or other scores).

Thus in a ten-star system we could represent the sentiment of each word as a 10-tuple, each number a score representing the word’s association with that polarity level. This association can be a raw count, or a likelihood $P ( w | c )$ , or some other function of the count, for each class c from 1 to 10.

For example, we could compute the IMDb likelihood of a word like disappoint(ed/ing) occurring in a 1 star review by dividing the number of times disappoint(ed/ing) occurs in 1-star reviews in the IMDb dataset (8,557) by the total number of words occurring in 1-star reviews (25,395,214), so the IMDb estimate of P(disappointing 1) is .0003.

A slight modification of this weighting, the normalized likelihood, can be used as an illuminating visualization (Potts, 2011)<sup>1</sup>

$$
\begin{array}{c} P (w | c) = \frac {\operatorname{count} (w , c)}{\sum_ {w \in C} \operatorname{count} (w , c)} \\ P o t t s S c o r e (w) = \frac {P (w | c)}{\sum_ {c} P (w | c)} \end{array}\tag{23.6}
$$

Dividing the IMDb estimate P(disappointing 1) of .0003 by the sum of the likelihood $P ( w | c )$ over all categories gives a Potts score of 0.10. The word disappointing thus is associated with the vector [.10, .12, .14, .14, .13, .11, .08, .06, .06, .05]. The

Potts diagram (Potts, 2011) is a visualization of these word scores, representing the prior sentiment of a word as a distribution over the rating categories.

Fig. 23.10 shows the Potts diagrams for 3 positive and 3 negative scalar adjectives. Note that the curve for strongly positive scalars have the shape of the letter J, while strongly negative scalars look like a reverse J. By contrast, weakly positive and negative scalars have a hump-shape, with the maximum either below the mean (weakly negative words like disappointing) or above the mean (weakly positive words like good). These shapes offer an illuminating typology of affective meaning.

![](images/figure23.10a.jpg)

![](images/figure23.10b.jpg)

![](images/figure23.10c.jpg)

![](images/figure23.10d.jpg)

![](images/figure23.10e.jpg)

![](images/figure23.10f.jpg)  
Figure 23.10 Potts diagrams (Potts, 2011) for positive and negative scalar adjectives, showing the J-shape and reverse J-shape for strongly positive and negative adjectives, and the hump-shape for more weakly polarized adjectives.

Fig. 23.11 shows the Potts diagrams for emphasizing and attenuating adverbs. Note that emphatics tend to have a J-shape (most likely to occur in the most positive reviews) or a U-shape (most likely to occur in the strongly positive and negative). Attenuators all have the hump-shape, emphasizing the middle of the scale and downplaying both extremes. The diagrams can be used both as a typology of lexical sentiment, and also play a role in modeling sentiment compositionality.

In addition to functions like posterior $P ( c | w )$ , likelihood $P ( w | c )$ , or normalized likelihood (Eq. 23.6) many other functions of the count of a word occurring with a sentiment label have been used. We’ll introduce some of these on page 534, including ideas like normalizing the counts per writer in Eq. 23.14.

## 23.5.1 Log Odds Ratio Informative Dirichlet Prior

One thing we often want to do with word polarity is to distinguish between words that are more likely to be used in one category of texts than in another. We may, for example, want to know the words most associated with 1 star reviews versus those associated with 5 star reviews. These differences may not be just related to sentiment. We might want to find words used more often by Democratic than Republican members of Congress, or words used more often in menus of expensive restaurants

![](images/figure23.11.jpg)  
Figure 23.11 Potts diagrams (Potts, 2011) for emphatic and attenuating adverbs.

than cheap restaurants.

Given two classes of documents, to find words more associated with one category than another, we could measure the difference in frequencies (is a word w more frequent in class A or class B?). Or instead of the difference in frequencies we could compute the ratio of frequencies, or compute the log odds ratio (the log of the ratio between the odds of the two words). We could then sort words by whichever association measure we pick, ranging from words overrepresented in category A to words overrepresented in category B.

The problem with simple log-likelihood or log odds methods is that they overemphasize differences in very rare words, and often also in very frequent words. Very rare words will seem to occur very differently in the two corpora since with tiny counts there may be statistical fluctuations, or even zero occurrences in one corpus compared to non-zero occurrences in the other. Very frequent words will also seem different since all counts are large.

In this section we walk through the details of one solution to this problem: the “log odds ratio informative Dirichlet prior” method of Monroe et al. (2008) that is a particularly useful method for finding words that are statistically overrepresented in one particular category of texts compared to another. It’s based on the idea of using another large corpus to get a prior estimate of what we expect the frequency of each word to be.

Let’s start with the goal: assume we want to know whether the word horrible occurs more in corpus i or corpus j. We could compute the log likelihood ratio, using $f ^ { i } ( w )$ to mean the frequency of word w in corpus i, and $n ^ { i }$ to mean the total number of words in corpus i:

$$
\begin{array}{r l} \operatorname{llr} (h o r r i b l e) & = \log \frac {P ^ {i} (h o r r i b l e)}{P ^ {j} (h o r r i b l e)} \\ & = \log P ^ {i} (h o r r i b l e) - \log P ^ {j} (h o r r i b l e) \\ & = \log \frac {\mathrm{f} ^ {i} (h o r r i b l e)}{n ^ {i}} - \log \frac {\mathrm{f} ^ {j} (h o r r i b l e)}{n ^ {j}} \end{array}\tag{23.7}
$$

Instead, let’s compute the log odds ratio: does horrible have higher odds in i or in

j:

$$
\begin{array}{l} \text {lor(horrible)} = \log \left(\frac {P ^ {i} (h o r r i b l e)}{1 - P ^ {i} (h o r r i b l e)}\right) - \log \left(\frac {P ^ {j} (h o r r i b l e)}{1 - P ^ {j} (h o r r i b l e)}\right) \\ = \log \left(\frac {\frac {\text {f} ^ {i} (h o r r i b l e)}{n ^ {i}}}{1 - \frac {\text {f} ^ {i} (h o r r i b l e)}{n ^ {i}}}\right) - \log \left(\frac {\frac {\text {f} ^ {j} (h o r r i b l e)}{n ^ {j}}}{1 - \frac {\text {f} ^ {j} (h o r r i b l e)}{n ^ {j}}}\right) \\ = \log \left(\frac {\text {f} ^ {i} (h o r r i b l e)}{n ^ {i} - \text {f} ^ {i} (h o r r i b l e)}\right) - \log \left(\frac {\text {f} ^ {j} (h o r r i b l e)}{n ^ {j} - \text {f} ^ {j} (h o r r i b l e)}\right) \end{array}\tag{23.8}
$$

The Dirichlet intuition is to use a large background corpus to get a prior estimate of what we expect the frequency of each word w to be. We’ll do this very simply by adding the counts from that corpus to the numerator and denominator, so that we’re essentially shrinking the counts toward that prior. It’s like asking how large are the differences between i and j given what we would expect given their frequencies in a well-estimated large background corpus.

The method estimates the difference between the frequency of word w in two corpora i and $j$ via the prior-modified log odds ratio for w, $\delta _ { w } ^ { ( i - j ) }$ , which is estimated as:

$$
\delta_ {w} ^ {(i - j)} = \log \left(\frac {f _ {w} ^ {i} + \alpha_ {w}}{n ^ {i} + \alpha_ {0} - (f _ {w} ^ {i} + \alpha_ {w})}\right) - \log \left(\frac {f _ {w} ^ {j} + \alpha_ {w}}{n ^ {j} + \alpha_ {0} - (f _ {w} ^ {j} + \alpha_ {w})}\right)\tag{23.9}
$$

(where $n ^ { i }$ is the size of corpus $i , n ^ { j }$ is the size of corpus $j , f _ { w } ^ { i }$ is the count of word w in corpus $i , f _ { w } ^ { j }$ is the count of word w in corpus $j ,$ <sub>α0</sub> is the scaled size of the background corpus, and $\alpha _ { w }$ is the scaled count of word w in the background corpus.)

In addition, Monroe et al. (2008) make use of an estimate for the variance of the log–odds–ratio:

$$
\sigma^ {2} \left(\hat {\delta} _ {w} ^ {(i - j)}\right) \approx \frac {1}{f _ {w} ^ {i} + \alpha_ {w}} + \frac {1}{f _ {w} ^ {j} + \alpha_ {w}}\tag{23.10}
$$

The final statistic for a word is then the z–score of its log–odds–ratio:

$$
\frac {\hat {\boldsymbol {\delta}} _ {w} ^ {(i - j)}}{\sqrt {\sigma^ {2} \left(\hat {\boldsymbol {\delta}} _ {w} ^ {(i - j)}\right)}}\tag{23.11}
$$

The Monroe et al. (2008) method thus modifies the commonly used log odds ratio in two ways: it uses the z-scores of the log odds ratio, which controls for the amount of variance in a word’s frequency, and it uses counts from a background corpus to provide a prior count for words.

Fig. 23.12 shows the method applied to a dataset of restaurant reviews from Yelp, comparing the words used in 1-star reviews to the words used in 5-star reviews (Jurafsky et al., 2014). The largest difference is in obvious sentiment words, with the 1-star reviews using negative sentiment words like worse, bad, awful and the 5-star reviews using positive sentiment words like great, best, amazing. But there are other illuminating differences. 1-star reviews use logical negation (no, not), while 5-star reviews use emphatics and emphasize universality (very, highly, every, always). 1- star reviews use first person plurals (we, us, our) while 5 star reviews use the second person. 1-star reviews talk about people (manager, waiter, customer) while 5-star reviews talk about dessert and properties of expensive restaurants like courses and atmosphere. See Jurafsky et al. (2014) for more details.

<table><tr><td>Class</td><td>Words in 1-star reviews</td><td>Class</td><td>Words in 5-star reviews</td></tr><tr><td>Negative</td><td>worst, rude, terrible, horrible, bad, awful, disgusting, bland, tasteless, gross, mediocre, overpriced, worse, poor</td><td>Positive</td><td>great, best, love(d), delicious, amazing, favorite, perfect, excellent, awesome, friendly, fantastic, fresh, wonderful, incredible, sweet, yum(my)</td></tr><tr><td>Negation</td><td>no, not</td><td>Emphatics/ universals</td><td>very, highly, perfectly, definitely, absolutely, everything, every, always</td></tr><tr><td>1Pl pro</td><td>we, us, our</td><td>2 pro</td><td>you</td></tr><tr><td>3 pro</td><td>she, he, her, him</td><td>Articles</td><td>a, the</td></tr><tr><td>Past verb</td><td>was, were, asked, told, said, did, charged, waited, left, took</td><td>Advice</td><td>try, recommend</td></tr><tr><td>Sequencers</td><td>after, then</td><td>Conjunct</td><td>also, as, well, with, and</td></tr><tr><td>Nouns</td><td>manager, waitress, waiter, customer, customers, attitude, waste, poisoning, money, bill, minutes</td><td>Nouns</td><td>atmosphere, dessert, chocolate, wine, course, menu</td></tr><tr><td>Irrealis modals</td><td>would, should</td><td>Auxiliaries</td><td>is/’s, can, ’ve, are</td></tr><tr><td>Comp</td><td>to, that</td><td>Prep, other</td><td>in, of, die, city, mouth</td></tr></table>

Figure 23.12 The top 50 words associated with one–star and five-star restaurant reviews in a Yelp dataset of 900,000 reviews, using the Monroe et al. (2008) method (Jurafsky et al., 2014).

## 23.6 Using Lexicons for Sentiment Recognition

In Appendix B we introduced the naive Bayes algorithm for sentiment analysis. The lexicons we have focused on throughout the chapter so far can be used in a number of ways to improve sentiment detection.

In the simplest case, lexicons can be used when we don’t have sufficient training data to build a supervised sentiment analyzer; it can often be expensive to have a human assign sentiment to each document to train the supervised classifier.

In such situations, lexicons can be used in a rule-based algorithm for classification. The simplest version is just to use the ratio of positive to negative words: if a document has more positive than negative words (using the lexicon to decide the polarity of each word in the document), it is classified as positive. Often a threshold λ is used, in which a document is classified as positive only if the ratio is greater than λ. If the sentiment lexicon includes positive and negative weights for each word, $\theta _ { w } ^ { + }$ and $\theta _ { w } ^ { - }$ , these can be used as well. Here’s a simple such sentiment algorithm:

$$
\begin{array}{r l} f ^ {+} & = \sum_ {\text {   w   s.t.   } w \in \text { positivelexicon }} \theta_ {w} ^ {+} \text { count } (w) \\ f ^ {-} & = \sum_ {\text {   w   s.t.   } w \in \text { negativelexicon }} \theta_ {w} ^ {-} \text { count } (w) \\ \text { sentiment } & = \left\{ \begin{array}{l l} + & \text { if   } \frac {f ^ {+}}{f ^ {-}} > \lambda \\ - & \text { if   } \frac {f ^ {-}}{f ^ {+}} > \lambda \\ 0 & \text { otherwise. } \end{array} \right. \end{array}\tag{23.12}
$$

If supervised training data is available, these counts computed from sentiment lexicons, sometimes weighted or normalized in various ways, can also be used as features in a classifier along with other lexical or non-lexical features. We return to such algorithms in Section 23.7.

## 23.7 Using Lexicons for Affect Recognition

Detection of emotion (and the other kinds of affective meaning described by Scherer (2000)) can be done by generalizing the algorithms described above for detecting sentiment.

The most common algorithms involve supervised classification: a training set is labeled for the affective meaning to be detected, and a classifier is built using features extracted from the training set. As with sentiment analysis, if the training set is large enough, and the test set is sufficiently similar to the training set, simply using all the words or all the bigrams as features in a powerful classifier like logistic regression or SVM is an excellent algorithm whose performance is hard to beat. Thus we can treat affective meaning classification of a text sample as simple document classification.

Some modifications are nonetheless often necessary for very large datasets. For example, the Schwartz et al. (2013) study of personality, gender, and age using 700 million words of Facebook posts used only a subset of the n-grams of lengths 1- 3. Only words and phrases used by at least 1% of the subjects were included as features, and 2-grams and 3-grams were only kept if they had sufficiently high PMI (PMI greater than 2 length, where length is the number of words):

$$
\operatorname{pmi} (\text { phrase }) = \log \frac {p (\text { phrase })}{\prod_ {w \in \text { phrase }} p (w)}\tag{23.13}
$$

Various weights can be used for the features, including the raw count in the training set, or some normalized probability or log probability. Schwartz et al. (2013), for example, turn feature counts into phrase likelihoods by normalizing them by each subject’s total word use.

$$
p (\text { phrase } | \text { subject }) = \frac {\operatorname{freq} (\text { phrase } , \text { subject })}{\sum_ {\text { phrase } ^ {\prime} \in \text { vocab } (\text { subject })} \operatorname{freq} (\text { phrase } ^ {\prime} , \text { subject })}\tag{23.14}
$$

If the training data is sparser, or not as similar to the test set, any of the lexicons we’ve discussed can play a helpful role, either alone or in combination with all the words and n-grams.

Many possible values can be used for lexicon features. The simplest is just an indicator function, in which the value of a feature $f _ { L }$ takes the value 1 if a particular text has any word from the relevant lexicon L. Using the notation of Appendix B, in which a feature value is defined for a particular output class c and document x.

$$
f _ {L} (c, x) = \left\{ \begin{array}{l l} 1 & \text { if } \exists w: w \in L \& w \in x \& c l a s s = c \\ 0 & \text { otherwise } \end{array} \right.
$$

Alternatively the value of a feature $f _ { L }$ for a particular lexicon L can be the total number of word tokens in the document that occur in L:

$$
f _ {L} = \sum_ {w \in L} c o u n t (w)
$$

For lexica in which each word is associated with a score or weight, the count can be multiplied by a weight $\theta _ { w } ^ { L }$ :

$$
f _ {L} = \sum_ {w \in L} \theta_ {w} ^ {L} \text { count } (w)
$$

Counts can alternatively be logged or normalized per writer as in Eq. 23.14.

However they are defined, these lexicon features are then used in a supervised classifier to predict the desired affective category for the text or document. Once a classifier is trained, we can examine which lexicon features are associated with which classes. For a classifier like logistic regression the feature weight gives an indication of how associated the feature is with the class.

## 23.8 Lexicon-based methods for Entity-Centric Affect

What if we want to get an affect score not for an entire document, but for a particular entity in the text? The entity-centric method of Field and Tsvetkov (2019) combines affect lexicons with contextual embeddings to assign an affect score to an entity in text. In the context of affect about people, they relabel the Valence/Arousal/Dominance dimension as Sentiment/Agency/Power. The algorithm first trains classifiers to map embeddings to scores:

1. For each word w in the training corpus:

(a) Use off-the-shelf pretrained encoders (like BERT) to extract a contextual embedding e for each instance of the word. No additional fine-tuning is done.

(b) Average over the e embeddings of each instance of w to obtain a single embedding vector for one training point w.

(c) Use the NRC VAD Lexicon to get S, A, and P scores for w.

2. Train (three) regression models on all words w to predict V, A, D scores from a word’s average embedding.

Now given an entity mention m in a text, we assign affect scores as follows:

1. Use the same pretrained LM to get contextual embeddings for m in context.

2. Feed this embedding through the 3 regression models to get S, A, P scores for the entity.

This results in a (S,A,P) tuple for a given entity mention; To get scores for the representation of an entity in a complete document, we can run coreference resolution and average the (S,A,P) scores for all the mentions. Fig. 23.13 shows the scores from their algorithm for characters from the movie The Dark Knight when run on Wikipedia plot summary texts with gold coreference.

## 23.9 Connotation Frames

The lexicons we’ve described so far define a word as a point in affective space. A connotation frame, by contrast, is a lexicon that incorporates a richer kind of grammatical structure, by combining affective lexicons with the frame semantic lexicons of Chapter 22. The basic insight of connotation frame lexicons is that a predicate like a verb expresses connotations about the verb’s arguments (Rashkin et al. 2016, Rashkin et al. 2017).

Consider sentences like:

(23.15) Country A violated the sovereignty of Country B

![](images/figure23.13a.jpg)

![](images/figure23.13b.jpg)

![](images/figure23.13c.jpg)  
Figure 2:Figure 23.13 Power (dominance), sentiment (valence) and agency (arousal) for characters acters inin the movie <sup>The Dark Knight</sup> computed from embeddings trained on the NRC VAD Lexicon. acters in The Dark Night as learned through the regres-<sub>Note the protagonist (Batman) and the antagonist (the Joker) have high power and agency</sub> sion model with ELMo embeddings. Scores generally<sub>scores but differ in sentiment, while the love interest Rachel has low power and agency but</sub> high sentiment.

## (23.16) the teenager ... survived the Boston Marathon bombing”

vey DeBy using the verb violate in (23.15), the author is expressing their sympathies with Rachel<sup>Country B, portraying Country B as a victim, and expressing antagonism toward</sup> the agent Country A. By contrast, in using the verb survive, the author of (23.16) is expressing that the bombing is a negative experience, and the subject of the sentence, erful, we can speculate that the corpora used to<sub>the teenager, is a sympathetic character. These aspects of connotation are inherent</sub> train ELMo and BERT portray them as powerful.in the meaning of the verbs violate and survive, as shown in Fig. 23.14.

![](images/figure23.14.jpg)  
Figure 23.14 Connotation frames for survive and violate. (a) For survive, the writer and reader have positive in one setting. Nevertheless, they do not outper- <sub>sentiment toward Role1, the subject, and negative sentiment toward Role2, the direct object. (b) For violate, the</sub> form Field et al. (2019), likely becauswriter and reader have positive sentiment instead toward Role2, the direct object.

est ageThe connotation frame lexicons of Rashkin et al. (2016) and Rashkin et al. (2017) also express other connotative aspects of the predicate toward each argument, including the effect (something bad happened to x) value: (x is valuable), and mental state: (x is distressed by the event). Connotation frames can also mark the Finally, we qualitatively analyze how well our power differential between the arguments (using the verb implore means that the method captures affect dimensions by analyzing theme argument has greater power than the agent), and the agency of each argument low-(waited is low agency). Fig. 23.15 shows a visualization from Sap et al. (2017).

driver. IConnotation frames can be built by hand (Sap et al., 2017), or they can be learned betweenby supervised learning (Rashkin et al., 2016), for example using hand-labeled train-<sub>a position of less power than the theme (“the tri-</sub> Figure 3: Samping data to supervise classifiers for each of the individual relations, e.g., whether bunal”). In contrast, “He demanded the tribunal with high annotS(writer  Role1) is + or -, and then improving accuracy via global constraints across all relations.

![](images/figure23.15.jpg)  
Figure 23.15 The connotation frames of Sap et al. (2017), showing that the verb implore Figure 2: The formal notation of the connotationimplies the agent has lower power than the theme (in contrast, say, with a verb like demanded), frames of power and agency. The first exampleand showing the low level of agency of the subject of waited. Figure from Sap et al. (2017).

## 23.10 Summary

ors” the theme (• Many kinds of affective states can be distinguished, including emotions, moods, <sub>viate from the well-known Bechdel test (Bechdel,</sub> writer implieattitudes (which include sentiment), interpersonal stance, and personality.

• Emotion can be represented by fixed atomic units often called basic emotions, or as points in space defined by dimensions like valence and arousal.

movies (e.g., Snow White) accidentally pass the agreement is 0.• Words have connotational aspects related to these affective states, and this Bechdel test and also because even movies withconnotational aspect of word meaning can be represented in lexicons.

<sup>verb</sup> <sup>denotes</sup> <sup>w</sup>• Affective lexicons can be built by hand, using crowd sourcing to label the affective content of each word.

<sup>2</sup> <sup>Connotation</sup> <sup>Frames</sup> <sup>of</sup> <sup>Power</sup> <sup>and</sup> <sub>For example, a</sub>• Lexicons can be built with semi-supervised, bootstrapping from seed words using similarity metrics like embedding cosine.

<sup>We</sup> <sup>create</sup> <sup>two</sup> <sup>new</sup> <sup>connotation</sup> <sup>relations,</sup> <sup>power</sup>  • Lexicons can be learned in a fully supervised manner, when a convenient training signal can be found in the world, such as ratings assigned by users on a review site.

with placeholders to avoid gender bias in the con- high agency as • Words can be assigned weights in a lexicon by using various functions of word text (e.g., X rescued Y; an example task is shown as agency(AG)counts in training texts, and ratio metrics like log odds ratio informative in tDirichlet prior.

56% and 51%• Affect can be detected, just like sentiment, by using standard supervised text Power Differentials Many verbs imply the au- tively. Despiteclassification techniques, using all the words or bigrams in a text as features. thority levels of the agent and theme relative to <sup>94%</sup>Additional features can be drawn from counts of words in lexicons.

<sup>2</sup>http://homes.cs.washington.edu/<sub>˜</sub>msap/ <sub>notators rarely s</sub>• Lexicons can also be used to detect affect in a rule-based classifier by picking <sup>movie-bias/.</sup> <sub>Some con</sub>the simple majority sentiment based on counts of words in each lexicon.

<sup>homes.cs.washington.edu/</sup>˜<sup>msap/movie-bias/.</sup>  • Connotation frames express richer relations of affective meaning that a predicate encodes about its arguments.

## Historical Notes

The idea of formally representing the subjective meaning of words began with Osgood et al. (1957), the same pioneering study that first proposed the vector space model of meaning described in Chapter 5. Osgood et al. (1957) had participants rate words on various scales, and ran factor analysis on the ratings. The most significant factor they uncovered was the evaluative dimension, which distinguished between pairs like good/bad, valuable/worthless, pleasant/unpleasant. This work influenced the development of early dictionaries of sentiment and affective meaning in the field of content analysis (Stone et al., 1966).

Wiebe (1994) began an influential line of work on detecting subjectivity in text, beginning with the task of identifying subjective sentences and the subjective characters who are described in the text as holding private states, beliefs or attitudes. Learned sentiment lexicons such as the polarity lexicons of Hatzivassiloglou and McKeown (1997) were shown to be a useful feature in subjectivity detection (Hatzivassiloglou and Wiebe 2000, Wiebe 2000).

The term sentiment seems to have been introduced in 2001 by Das and Chen (2001), to describe the task of measuring market sentiment by looking at the words in stock trading message boards. In the same paper Das and Chen (2001) also proposed the use of a sentiment lexicon. The list of words in the lexicon was created by hand, but each word was assigned weights according to how much it discriminated a particular class (say buy versus sell) by maximizing across-class variation and minimizing within-class variation. The term sentiment, and the use of lexicons, caught on quite quickly (e.g., inter alia, Turney 2002). Pang et al. (2002) first showed the power of using all the words without a sentiment lexicon; see also Wang and Manning (2012).

Most of the semi-supervised methods we describe for extending sentiment dictionaries drew on the early idea that synonyms and antonyms tend to co-occur in the same sentence (Miller and Charles 1991, Justeson and Katz 1991, Riloff and Shepherd 1997). Other semi-supervised methods for learning cues to affective meaning rely on information extraction techniques, like the AutoSlog pattern extractors (Riloff and Wiebe, 2003). Graph based algorithms for sentiment were first suggested by Hatzivassiloglou and McKeown (1997), and graph propagation became a standard method (Zhu and Ghahramani 2002, Zhu et al. 2003, Zhou et al. 2004a, Velikovich et al. 2010). Crowdsourcing can also be used to improve precision by filtering the result of semi-supervised lexicon learning (Riloff and Shepherd 1997, Fast et al. 2016).

Much recent work focuses on ways to learn embeddings that directly encode sentiment or other properties, such as the DENSIFIER algorithm of Rothe et al. (2016) that learns to transform the embedding space to focus on sentiment (or other) information.

## Exercises

23.1 Show that the relationship between a word w and a category c in the Potts Score in Eq. 23.6 is a variant of the pointwise mutual information pmi(w, c) without the log term.