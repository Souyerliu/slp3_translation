H

CHAPTER

# Logical Representations of Sentence Meaning

ISHMAEL: Surely all this is not without meaning. Herman Melville, Moby Dick

In this chapter we introduce the idea that the meaning of linguistic expressions can be captured in formal structures called meaning representations. Consider tasks that require some form of semantic processing, like learning to use a new piece of software by reading the manual, deciding what to order at a restaurant by reading a menu, or following a recipe. Accomplishing these tasks requires representations that link the linguistic elements to the necessary non-linguistic knowledge of the world. Reading a menu and deciding what to order, giving advice about where to go to dinner, following a recipe, and generating new recipes all require knowledge about food and its preparation, what people like to eat, and what restaurants are like. Learning to use a piece of software by reading a manual, or giving advice on using software, requires knowledge about the software and similar apps, computers, and users in general.

In this chapter, we assume that linguistic expressions have meaning representations that are made up of the same kind of stuff that is used to represent this kind of everyday common-sense knowledge of the world. The process whereby such representations are created and assigned to linguistic inputs is called semantic parsing or semantic analysis, and the entire enterprise of designing meaning representations and associated semantic parsers is referred to as computational semantics.

![](images/ce7a8c6847e9cbf30f8d86b53ec13d512b2846f81cc70364dfd193cef77c9733.jpg)  
Figure H.1 A list of symbols, two directed graphs, and a record structure: a sampler of meaning representations for I have a car.

Consider Fig. H.1, which shows example meaning representations for the sentence I have a car using four commonly used meaning representation languages. The top row illustrates a sentence in First-Order Logic, covered in detail in Section H.3; the directed graph and its corresponding textual form is an example of an Abstract Meaning Representation (AMR) form (Banarescu et al., 2013), and on the right is a frame-based or slot-filler representation, discussed in Section H.5 and again in Chapter 21.

While there are non-trivial differences among these approaches, they all share the notion that a meaning representation consists of structures composed from a set of symbols, or representational vocabulary. When appropriately arranged, these symbol structures are taken to correspond to objects, properties of objects, and relations among objects in some state of affairs being represented or reasoned about. In this case, all four representations make use of symbols corresponding to the speaker, a car, and a relation denoting the possession of one by the other.

Importantly, these representations can be viewed from at least two distinct perspectives in all of these approaches: as representations of the meaning of the particular linguistic input I have a car, and as representations of the state of affairs in some world. It is this dual perspective that allows these representations to be used to link linguistic inputs to the world and to our knowledge of it.

In the next sections we give some background: our desiderata for a meaning representation language and some guarantees that these representations will actually do what we need them to do—provide a correspondence to the state of affairs being represented. In Section H.3 we introduce First-Order Logic, historically the primary technique for investigating natural language semantics, and see in Section H.4 how it can be used to capture the semantics of events and states in English.

## H.1 Computational Desiderata for Representations

Let’s consider why meaning representations are needed and what they should do for us. To focus this discussion, let’s consider a system that gives restaurant advice to tourists based on a knowledge base.

## Verifiability

Consider the following simple question:

## (H.1) Does Maharani serve vegetarian food?

To answer this question, we have to know what it’s asking, and know whether what it’s asking is true of Maharini or not. Verifiability is a system’s ability to compare the state of affairs described by a representation to the state of affairs in some world as modeled in a knowledge base. For example, we’ll need some sort of representation like Serves(Maharani,VegetarianFood), which a system can match against its knowledge base of facts about particular restaurants, and if it finds a representation matching this proposition, it can answer yes. Otherwise, it must either say No if its knowledge of local restaurants is complete, or say that it doesn’t know if it knows its knowledge is incomplete.

## Unambiguous Representations

Semantics, like all the other domains we have studied, is subject to ambiguity. Words and sentences have different meaning representations in different contexts. Consider the following example:

## (H.2) I wanna eat someplace that’s close to ICSI.

This sentence can either mean that the speaker wants to eat at some nearby location, or under a Godzilla-as-speaker interpretation, the speaker may want to devour some nearby location. The sentence is ambiguous; a single linguistic expression can have one of two meanings. But our meaning representations itself cannot be ambiguous. The representation of an input’s meaning should be free from any ambiguity, so that the system can reason over a representation that means either one thing or the other in order to decide how to answer.

A concept closely related to ambiguity is vagueness: in which a meaning representation leaves some parts of the meaning underspecified. Vagueness does not give rise to multiple representations. Consider the following request:

(H.3) I want to eat Italian food.

While Italian food may provide enough information to provide recommendations, it is nevertheless vague as to what the user really wants to eat. A vague representation of the meaning of this phrase may be appropriate for some purposes, while a more specific representation may be needed for other purposes.

## Canonical Form

The doctrine of canonical form says that distinct inputs that mean the same thing should have the same meaning representation. This approach greatly simplifies reasoning, since systems need only deal with a single meaning representation for a potentially wide range of expressions.

Consider the following alternative ways of expressing (H.1):

(H.4) Does Maharani have vegetarian dishes?

(H.5) Do they have vegetarian food at Maharani?

(H.6) Are vegetarian dishes served at Maharani?

(H.7) Does Maharani serve vegetarian fare?

Despite the fact these alternatives use different words and syntax, we want them to map to a single canonical meaning representations. If they were all different, assuming the system’s knowledge base contains only a single representation of this fact, most of the representations wouldn’t match. We could, of course, store all possible alternative representations of the same fact in the knowledge base, but doing so would lead to enormous difficulty in keeping the knowledge base consistent.

Canonical form does complicate the task of semantic parsing. Our system must conclude that vegetarian fare, vegetarian dishes, and vegetarian food refer to the same thing, that having and serving are equivalent here, and that all these parse structures still lead to the same meaning representation. Or consider this pair of examples:

(H.8) Maharani serves vegetarian dishes.

(H.9) Vegetarian dishes are served by Maharani.

Despite the different placement of the arguments to serve, a system must still assign Maharani and vegetarian dishes to the same roles in the two examples by drawing on grammatical knowledge, such as the relationship between active and passive sentence constructions.

## Inference and Variables

What about more complex requests such as:

(H.10) Can vegetarians eat at Maharani?

This request results in the same answer as the others not because they mean the same thing, but because there is a common-sense connection between what vegetarians eat and what vegetarian restaurants serve. This is a fact about the world. We’ll need to connect the meaning representation of this request with this fact about the world in a knowledge base. A system must be able to use inference—to draw valid conclusions based on the meaning representation of inputs and its background knowledge. It must be possible for the system to draw conclusions about the truth of propositions that are not explicitly represented in the knowledge base but that are nevertheless logically derivable from the propositions that are present.

Now consider the following somewhat more complex request:

(H.11) I’d like to find a restaurant where I can get vegetarian food.

This request does not make reference to any particular restaurant; the user wants information about an unknown restaurant that serves vegetarian food. Since no restaurants are named, simple matching is not going to work. Answering this request requires the use of variables, using some representation like the following:

$$
S e r \nu e s ( x , V e g e t a r i a n F o o d )\tag{H.12}
$$

Matching succeeds only if the variable x can be replaced by some object in the knowledge base in such a way that the entire proposition will then match. The concept that is substituted for the variable can then be used to fulfill the user’s request. It is critical for any meaning representation language to be able to handle these kinds of indefinite references.

## Expressiveness

Finally, a meaning representation scheme must be expressive enough to handle a wide range of subject matter, ideally any sensible natural language utterance. Although this is probably too much to expect from any single representational system, First-Order Logic, as described in Section H.3, is expressive enough to handle quite a lot of what needs to be represented.

## H.2 Model-Theoretic Semantics

What is it about meaning representation languages that allows them to fulfill these desiderata, bridging the gap from formal representations to representations that tell us something about some state of affairs in the world?

The answer is a model. A model is a formal construct that stands for the particular state of affairs in the world. Expressions in a meaning representation language can be mapped to elements of the model, like objects, properties of objects, and relations among objects. If the model accurately captures the facts we’re interested in, then a consistent mapping between the meaning representation and the model provides the bridge between meaning representation and world. Models provide a surprisingly simple and powerful way to ground the expressions in meaning representation languages.

First, some terminology. The vocabulary of a meaning representation consists of two parts: the non-logical vocabulary and the logical vocabulary. The non-logical vocabulary consists of the open-ended set of names for the objects, properties, and relations that make up the world we’re trying to represent. These appear in various schemes as predicates, nodes, labels on links, or labels in slots in frames. The logical vocabulary consists of the closed set of symbols, operators, quantifiers, links, etc., that provide the formal means for composing expressions in a given meaning representation language.

Each element of the non-logical vocabulary must have a denotation in the model, meaning that every element corresponds to a fixed, well-defined part of the model. Let’s start with objects. The domain of a model is the set of objects that are being represented. Each distinct concept, category, or individual denotes a unique element in the domain.

We represent properties of objects in a model by denoting the domain elements that have the property; that is, properties denote sets. The denotation of the property red is the set of things we think are red. Similarly, a relation among object denotes a set of ordered lists, or tuples, of domain elements that take part in the relation: the denotation of the relation Married is set of pairs of domain objects that are married. This approach to properties and relations is called extensional, because we define concepts by their extension, their denotations. To summarize:

• Objects denote elements of the domain

• Properties denote sets of elements of the domain

• Relations denote sets oftuples ofelements of the domain

We now need a mapping that gets us from our meaning representation to the corresponding denotations: a function that maps from the non-logical vocabulary of our meaning representation to the proper denotations in the model. We’ll call such a mapping an interpretation.

Let’s return to our restaurant advice application, and let its domain consist of sets of restaurants, patrons, facts about the likes and dislikes of the patrons, and facts about the restaurants such as their cuisine, typical cost, and noise level. To begin populating our domain, D, let’s assume that we’re dealing with four patrons designated by the non-logical symbols Matthew, Franco, Katie, and Caroline. denoting four unique domain elements. We’ll use the constants a,b,c and, d to stand for these domain elements. We’re deliberately using meaningless, non-mnemonic names for our domain elements to emphasize the fact that whatever it is that we know about these entities has to come from the formal properties of the model and not from the names of the symbols. Continuing, let’s assume that our application includes three restaurants, designated as Frasca, Med, and Rio in our meaning representation, that denote the domain elements e, f, and g. Finally, let’s assume that we’re dealing with the three cuisines Italian, Mexican, and Eclectic, denoted by h,i, and j in our model.

Properties like Noisy denote the subset of restaurants from our domain that are known to be noisy. Two-place relational notions, such as which restaurants individual patrons Like, denote ordered pairs, or tuples, of the objects from the domain. And, since we decided to represent cuisines as objects in our model, we can capture which restaurants Serve which cuisines as a set of tuples. One possible state of affairs using this scheme is given in Fig. H.2.

Given this simple scheme, we can ground our meaning representations by consulting the appropriate denotations in the corresponding model. For example, we can evaluate a representation claiming that Matthew likes the Rio, or that The Med serves Italian by mapping the objects in the meaning representations to their corresponding domain elements and mapping any links, predicates, or slots in the meaning representation to the appropriate relations in the model. More concretely, we can verify a representation asserting that Matthew likes Frasca by first using our interpretation function to map the symbol Matthew to its denotation a, Frasca to e, and the Likes relation to the appropriate set of tuples. We then check that set of tuples for the presence of the tuple ⟨a, e⟩. If, as it is in this case, the tuple is present in the model, then we can conclude that Matthew likes Frasca is true; if it isn’t then we can’t.

This is all pretty straightforward—we’re using sets and operations on sets to ground the expressions in our meaning representations. Of course, the more interesting part comes when we consider more complex examples such as the following:

6 APPENDIX H • LOGICAL REPRESENTATIONS OF SENTENCE MEANING
<table><tr><td>Domain</td><td> $\overline { { \mathcal { D } = \{ a , b , c , d , e , f , g , h , i , j \} } }$ </td></tr><tr><td>Matthew, Franco, Katie and Caroline</td><td> $a , b , c , d$ </td></tr><tr><td>Frasca, Med, Rio</td><td> $e , f , g$ </td></tr><tr><td>Italian, Mexican, Eclectic</td><td> $h , i , j$ </td></tr><tr><td>Properties</td><td></td></tr><tr><td>Noisy</td><td> $N o i s y = \{ e , f , g \}$ </td></tr><tr><td>Frasca, Med, and Rio are noisy</td><td></td></tr><tr><td>Relations Likes</td><td> $L i k e s = \{ \langle a , f \rangle , \langle c , f \rangle , \langle c , g \rangle , \langle b , e \rangle , \langle d , f \rangle , \langle d , g \rangle \}$ </td></tr><tr><td>Matthew likes the Med</td><td></td></tr><tr><td>Katie likes the Med and Rio</td><td></td></tr><tr><td>Franco likes Frasca</td><td></td></tr><tr><td>Caroline likes the Med and Rio</td><td></td></tr><tr><td>Serves</td><td> $S e r \nu e s = \{ \langle f , j \rangle , \langle g , i \rangle , \langle e , h \rangle \}$ </td></tr><tr><td>Med serves eclectic</td><td></td></tr><tr><td>Rio serves Mexican</td><td></td></tr><tr><td>Frasca serves Italian</td><td></td></tr></table>

Figure H.2 A model of the restaurant world.

(H.13) Katie likes the Rio and Matthew likes the Med.

(H.14) Katie and Caroline like the same restaurants.

(H.15) Franco likes noisy, expensive restaurants.

(H.16) Not everybody likes Frasca.

Our simple scheme for grounding the meaning of representations is not adequate for examples such as these. Plausible meaning representations for these examples will not map directly to individual entities, properties, or relations. Instead, they involve complications such as conjunctions, equality, quantified variables, and negations. To assess whether these statements are consistent with our model, we’ll have to tear them apart, assess the parts, and then determine the meaning of the whole from the meaning of the parts.

Consider the first example above. A meaning representation for this example will include two distinct propositions expressing the individual patron’s preferences, conjoined with some kind of implicit or explicit conjunction operator. Our model doesn’t have a relation that encodes pairwise preferences for all of the patrons and restaurants in our model, nor does it need to. We know from our model that Matthew likes the Med and separately that Katie likes the Rio (that is, the tuples $\langle a , f \rangle$ and $\langle c , g \rangle$ are members of the set denoted by the Likes relation). All we really need to know is how to deal with the semantics of the conjunction operator. If we assume the simplest possible semantics for the English word and, the whole statement is true if it is the case that each of the components is true in our model. In this case, both components are true since the appropriate tuples are present and therefore the sentence as a whole is true.

What we’ve done with this example is provide a truth-conditional semantics for the assumed conjunction operator in some meaning representation. That is, we’ve provided a method for determining the truth of a complex expression from the meanings of the parts (by consulting a model) and the meaning of an operator by consulting a truth table. Meaning representation languages are truth-conditional to the extent that they give a formal specification as to how we can determine the meaning of complex sentences from the meaning of their parts. In particular, we need to know the semantics of the entire logical vocabulary of the meaning representation scheme being used.

Formula → AtomicFormula   
Formula Connective Formula   
Quantifier Variable,... Formula   
¬ Formula   
(Formula)   
AtomicFormula → Predicate(Term,...)   
Term → Function(Term,...)   
Constant   
Variable   
Connective → ∧ | ∨ | =⇒   
Quantifier → ∀ | ∃   
Constant → A | VegetarianFood | Maharani···   
Variable → x | y | · · ·   
Predicate → Serves | Near | ···   
Function → LocationOf | CuisineOf | ···  
Figure H.3 A context-free grammar specification of the syntax of First-Order Logic representations. Adapted from Russell and Norvig 2002.

Note that although the details of how this happens depend on details of the particular meaning representation being used, it should be clear that assessing the truth conditions of examples like these involves nothing beyond the simple set operations we’ve been discussing. We return to these issues in the next section in the context of the semantics of First-Order Logic.

## H.3 First-Order Logic

First-Order Logic (FOL) is a flexible, well-understood, and computationally tractable meaning representation language that satisfies many of the desiderata given in Section H.1. It provides a sound computational basis for the verifiability, inference, and expressiveness requirements, as well as a sound model-theoretic semantics.

An additional attractive feature of FOL is that it makes few specific commitments as to how things ought to be represented, and those it does are shared by many of the schemes mentioned earlier: the represented world consists of objects, properties of objects, and relations among objects.

The remainder of this section introduces the basic syntax and semantics of FOL and then describes the application of FOL to the representation of events.

## H.3.1 Basic Elements of First-Order Logic

Let’s explore FOL by first examining its various atomic elements and then showing how they can be composed to create larger meaning representations. Figure H.3, which provides a complete context-free grammar for the particular syntax of FOL that we will use, is our roadmap for this section.

Let’s begin by examining the notion of a term, the FOL device for representing objects. As can be seen from Fig. H.3, FOL provides three ways to represent these basic building blocks: constants, functions, and variables. Each of these devices can be thought of as designating an object in the world under consideration.

Constants in FOL refer to specific objects in the world being described. Such constants are conventionally depicted as either single capitalized letters such as A and B or single capitalized words that are often reminiscent of proper nouns such as Maharani and Harry. Like programming language constants, FOL constants refer to exactly one object. Objects can, however, have multiple constants that refer to them.

Functions in FOL correspond to concepts that are often expressed in English as genitives such as Frasca’s location. A FOL translation of such an expression might look like the following.

## LocationOf(Frasca)

(H.17)

FOL functions are syntactically the same as single argument predicates. It is important to remember, however, that while they have the appearance of predicates, they are in fact terms in that they refer to unique objects. Functions provide a convenient way to refer to specific objects without having to associate a named constant with them. This is particularly convenient in cases in which many named objects, like restaurants, have a unique concept such as a location associated with them.

Variables are our final FOL mechanism for referring to objects. Variables, depicted as single lower-case letters, let us make assertions and draw inferences about objects without having to make reference to any particular named object. This ability to make statements about anonymous objects comes in two flavors: making statements about a particular unknown object and making statements about all the objects in some arbitrary world of objects. We return to the topic of variables after we have presented quantifiers, the elements of FOL that make variables useful.

Now that we have the means to refer to objects, we can move on to the FOL mechanisms that are used to state relations that hold among objects. Predicates are symbols that refer to, or name, the relations that hold among some fixed number of objects in a given domain. Returning to the example introduced informally in Section H.1, a reasonable FOL representation for Maharani serves vegetarian food might look like the following formula:

$$
S e r \nu e s ( M a h a r a n i , V e g e t a r i a n F o o d )\tag{H.18}
$$

This FOL sentence asserts that Serves, a two-place predicate, holds between the objects denoted by the constants Maharani and VegetarianFood.

A somewhat different use of predicates is illustrated by the following fairly typical representation for a sentence like Maharani is a restaurant:

## Restaurant(Maharani)

(H.19)

This is an example of a one-place predicate that is used, not to relate multiple objects, but rather to assert a property of a single object. In this case, it encodes the category membership of Maharani.

With the ability to refer to objects, to assert facts about objects, and to relate objects to one another, we can create rudimentary composite representations. These representations correspond to the atomic formula level in Fig. H.3. This ability to compose complex representations is, however, not limited to the use of single predicates. Larger composite representations can also be put together through the use of logical connectives. As can be seen from Fig. H.3, logical connectives let us create larger representations by conjoining logical formulas using one of three operators. Consider, for example, the following BERP sentence and one possible representation for it:

(H.20) I only have five dollars and I don’t have a lot of time.

$$
H a \nu e ( S p e a k e r , F i \nu e D o l l a r s ) \wedge \neg H a \nu e ( S p e a k e r , L o t O f T i m e )\tag{H.21}
$$

The semantic representation for this example is built up in a straightforward way from the semantics of the individual clauses through the use of the ∧ and ¬ operators. Note that the recursive nature of the grammar in Fig. H.3 allows an infinite number of logical formulas to be created through the use of these connectives. Thus, as with syntax, we can use a finite device to create an infinite number of representations.

## H.3.2 Variables and Quantifiers

We now have all the machinery necessary to return to our earlier discussion of variables. As noted above, variables are used in two ways in FOL: to refer to particular anonymous objects and to refer generically to all objects in a collection. These two uses are made possible through the use of operators known as quantifiers. The two operators that are basic to FOL are the existential quantifier, which is denoted ∃ and is pronounced as “there exists”, and the universal quantifier, which is denoted ∀ and is pronounced as “for all”.

The need for an existentially quantified variable is often signaled by the presence of an indefinite noun phrase in English. Consider the following example:

(H.22) a restaurant that serves Mexican food near ICSI.

Here, reference is being made to an anonymous object of a specified category with particular properties. The following would be a reasonable representation of the meaning of such a phrase:

$$
\begin{array} { l l } { \exists x R e s t a u r a n t ( x ) } & { \land \ S e r { \nu } e s ( x , M e x i c a n F o o d ) } \\ & { \land \ N e a r ( L o c a t i o n O f ( x ) , L o c a t i o n O f ( I C S I ) ) } \end{array}\tag{H.23}
$$

The existential quantifier at the head of this sentence instructs us on how to interpret the variable x in the context of this sentence. Informally, it says that for this sentence to be true there must be at least one object such that if we were to substitute it for the variable $x ,$ the resulting sentence would be true. For example, if AyCaramba is a Mexican restaurant near ICSI, then substituting AyCaramba for x results in the following logical formula:

$$
\begin{array} { r } { R e s t a u r a n t ( A y C a r a m b a ) \land S e r \nu e s ( A y C a r a m b a , M e x i c a n F o o d ) } \\ { \land N e a r ( ( L o c a t i o n O f ( A y C a r a m b a ) , L o c a t i o n O f ( I C S I ) ) } \end{array}\tag{H.24}
$$

Based on the semantics of the ∧ operator, this sentence will be true if all of its three component atomic formulas are true. These in turn will be true if they are either present in the system’s knowledge base or can be inferred from other facts in the knowledge base.

The use of the universal quantifier also has an interpretation based on substitution of known objects for variables. The substitution semantics for the universal quantifier takes the expressionfor all quite literally; the ∀ operator states that for the logical formula in question to be true, the substitution of any object in the knowledge base for the universally quantified variable should result in a true formula. This is in marked contrast to the ∃ operator, which only insists on a single valid substitution for the sentence to be true.

Consider the following example:

(H.25) All vegetarian restaurants serve vegetarian food.

A reasonable representation for this sentence would be something like the following:

$$
\forall x V e g e t a r i a n R e s t a u r a n t ( x ) \implies S e r \nu e s ( x , V e g e t a r i a n F o o d )\tag{H.26}
$$

For this sentence to be true, every substitution of a known object for x must result in a sentence that is true. We can divide the set of all possible substitutions into the set of objects consisting of vegetarian restaurants and the set consisting of everything else. Let us first consider the case in which the substituted object actually is a vegetarian restaurant; one such substitution would result in the following sentence:

$$
V e g e t a r i a n R e s t a u r a n t ( M a h a r a n i ) \implies S e r \nu e s ( M a h a r a n i , V e g e t a r i a n F o o d ) . I n t h e t a l l @ r e g i o n a l (\tag{H.27}
$$

If we assume that we know that the consequent clause

$$
S e r \nu e s ( M a h a r a n i , V e g e t a r i a n F o o d )\tag{H.28}
$$

is true, then this sentence as a whole must be true. Both the antecedent and the consequent have the value True and, therefore, according to the first two rows of Fig. H.4 on page 12 the sentence itself can have the value True. This result will be the same for all possible substitutions of Terms representing vegetarian restaurants for x.

Remember, however, that for this sentence to be true, it must be true for all possible substitutions. What happens when we consider a substitution from the set of objects that are not vegetarian restaurants? Consider the substitution of a nonvegetarian restaurant such as AyCaramba for the variable x:

$$
V e g e t a r i a n R e s t a u r a n t ( A y C a r a m b a ) \implies S e r \nu e s ( A y C a r a m b a , V e g e t a r i a n F o o d ) . I n p a
$$

Since the antecedent of the implication is False, we can determine from Fig. H.4 that the sentence is always True, again satisfying the ∀ constraint.

Note that it may still be the case that AyCaramba serves vegetarian food without actually being a vegetarian restaurant. Note also that, despite our choice of examples, there are no implied categorical restrictions on the objects that can be substituted for x by this kind of reasoning. In other words, there is no restriction of x to restaurants or concepts related to them. Consider the following substitution:

$$
V e g e t a r i a n R e s t a u r a n t ( C a r b u r e t o r ) \implies S e rnu e s ( C a r b u r e t o r , V e g e t a r i a n F o o d ) \implies
$$

Here the antecedent is still false so the rule remains true under this kind of irrelevant substitution.

To review, variables in logical formulas must be either existentially (∃) or universally (∀) quantified. To satisfy an existentially quantified variable, at least one substitution must result in a true sentence. To satisfy a universally quantified variable, all substitutions must result in true sentences.

## H.3.3 Lambda Notation

The final element we need to complete our discussion of FOL is called the lambda notation (Church, 1940). This notation provides a way to abstract from fully speci-

fied FOL formulas in a way that will be particularly useful for semantic analysis. The lambda notation extends the syntax of FOL to include expressions of the following form:

$$
\lambda x . P ( x )\tag{H.29}
$$

Such expressions consist of the Greek symbol λ, followed by one or more variables, followed by a FOL formula that makes use of those variables.

The usefulness of these λ-expressions is based on the ability to apply them to logical terms to yield new FOL expressions where the formal parameter variables are bound to the specified terms. This process is known as λ-reduction, and consists of a simple textual replacement of the λ variables and the removal of the λ. The following expressions illustrate the application of a λ-expression to the constant A, followed by the result of performing a λ-reduction on this expression:

$$
\begin{array} { c } { { \lambda x . P ( x ) ( A ) } } \\ { { P ( A ) } } \end{array}\tag{H.30}
$$

An important and useful variation of this technique is the use of one λ-expression as the body of another as in the following expression:

$$
\lambda x . \lambda y . N e a r ( x , y )\tag{H.31}
$$

This fairly abstract expression can be glossed as the state of something being near something else. The following expressions illustrate a single λ-application and subsequent reduction with this kind of embedded λ-expression:

$$
\begin{array} { c } { { \lambda x . \lambda y . N e a r ( x , y ) ( B a c a r o ) } } \\ { { \lambda y . N e a r ( B a c a r o , y ) } } \end{array}\tag{H.32}
$$

The important point here is that the resulting expression is still a λ -expression; the first reduction bound the variable x and removed the outer λ, thus revealing the inner expression. As might be expected, this resulting λ -expression can, in turn, be applied to another term to arrive at a fully specified logical formula, as in the following:

$$
\begin{array} { c } { { \lambda y . N e a r ( B a c a r o , y ) ( C e n t r o ) } } \\ { { N e a r ( B a c a r o , C e n t r o ) } } \end{array}\tag{H.33}
$$

This general technique, called currying<sup>1</sup> (Schonfinkel ¨ , 1924) is a way of converting a predicate with multiple arguments into a sequence of single-argument predicates.

The λ-notation also provides a way to incrementally gather arguments to a predicate when they do not all appear together as daughters of the predicate in a parse tree.

## H.3.4 The Semantics of First-Order Logic

The various objects, properties, and relations represented in a FOL knowledge base acquire their meanings by virtue of their correspondence to objects, properties, and relations out in the external world being modeled. We can accomplish this by employing the model-theoretic approach introduced in Section H.2. Recall that this approach employs simple set-theoretic notions to provide a truth-conditional mapping from the expressions in a meaning representation to the state of affairs being modeled. We can apply this approach to FOL by going through all the elements in Fig. H.3 on page 7 and specifying how each should be accounted for.

We can start by asserting that the objects in our world, FOL terms, denote elements in a domain, and asserting that atomic formulas are captured either as sets of domain elements for properties, or as sets of tuples of elements for relations. As an example, consider the following:

(H.34) Centro is near Bacaro.

Capturing the meaning of this example in FOL involves identifying the Terms and Predicates that correspond to the various grammatical elements in the sentence and creating logical formulas that capture the relations implied by the words and syntax of the sentence. For this example, such an effort might yield something like the following:

$$
N e a r ( C e n t r o , B a c a r o )\tag{H.35}
$$

The meaning of this logical formula is based on whether the domain elements denoted by the terms Centro and Bacaro are contained among the tuples denoted by the relation denoted by the predicate Near in the current model.

The interpretation of formulas involving logical connectives is based on the meanings of the components in the formulas combined with the meanings of the connectives they contain. Figure H.4 gives interpretations for each of the logical operators shown in Fig. H.3.

<table><tr><td>P</td><td>Q</td><td>¬P</td><td>P∧Q</td><td>PVQ</td><td>P ⇒ Q</td></tr><tr><td>False</td><td>False</td><td>True</td><td>False</td><td>False</td><td>True</td></tr><tr><td>False</td><td>True</td><td>True</td><td>False</td><td>True</td><td>True</td></tr><tr><td>True</td><td>False</td><td>False</td><td>False</td><td>True</td><td>False</td></tr><tr><td>True</td><td>True</td><td>False</td><td>True</td><td>True</td><td>True</td></tr></table>

Figure H.4 Truth table giving the semantics of the various logical connectives.

The semantics of the ∧ (and) and ¬ (not) operators are fairly straightforward, and are correlated with at least some of the senses of the corresponding English terms. However, it is worth pointing out that the ∨ (or) operator is not disjunctive in the same way that the corresponding English word is, and that the =⇒ (implies) operator is only loosely based on any common-sense notions of implication or causation.

The final bit we need to address involves variables and quantifiers. Recall that there are no variables in our set-based models, only elements of the domain and relations that hold among them. We can provide a model-based account for formulas with variables by employing the notion of a substitution introduced earlier on page 9. Formulas involving ∃ are true if a substitution of terms for variables results in a formula that is true in the model. Formulas involving ∀ must be true under all possible substitutions.

## H.3.5 Inference

A meaning representation language must support inference to add valid new propositions to a knowledge base or to determine the truth of propositions not explicitly contained within a knowledge base (Section H.1). This section briefly discusses modus ponens, the most widely implemented inference method provided by FOL.

Modus ponens is a form of inference that corresponds to what is informally known as if-then reasoning. We can abstractly define modus ponens as follows, where α and $\beta$ should be taken as FOL formulas:

$$
\frac { \alpha } { \beta }\tag{H.36}
$$

A schema like this indicates that the formula below the line can be inferred from the formulas above the line by some form of inference. Modus ponens states that if the left-hand side of an implication rule is true, then the right-hand side of the rule can be inferred. In the following discussions, we will refer to the left-hand side of an implication as the antecedent and the right-hand side as the consequent.

For a typical use of modus ponens, consider the following example, which uses a rule from the last section:

$$
\begin{array} { r l } & { V e g e t a r i a n R e s t a u r a n t ( L e a f ) } \\ & { \frac { \forall x V e g e t a r i a n R e s t a u r a n t ( x ) \implies S e r \nu e s ( x , V e g e t a r i a n F o o d ) } { S e r \nu e s ( L e a f , V e g e t a r i a n F o o d ) } } \end{array}\tag{H.37}
$$

Here, the formula VegetarianRestaurant(Leaf) matches the antecedent of the rule, thus allowing us to use modus ponens to conclude Serves(Leaf ,VegetarianFood).

Modus ponens can be put to practical use in one of two ways: forward chaining and backward chaining. In forward chaining systems, modus ponens is used in precisely the manner just described. As individual facts are added to the knowledge base, modus ponens is used to fire all applicable implication rules. In this kind of arrangement, as soon as a new fact is added to the knowledge base, all applicable implication rules are found and applied, each resulting in the addition of new facts to the knowledge base. These new propositions in turn can be used to fire implication rules applicable to them. The process continues until no further facts can be deduced.

The forward chaining approach has the advantage that facts will be present in the knowledge base when needed, because, in a sense all inference is performed in advance. This can substantially reduce the time needed to answer subsequent queries since they should all amount to simple lookups. The disadvantage of this approach is that facts that will never be needed may be inferred and stored.

In backward chaining, modus ponens is run in reverse to prove specific propositions called queries. The first step is to see if the query formula is true by determining if it is present in the knowledge base. If it is not, then the next step is to search for applicable implication rules present in the knowledge base. An applicable rule is one whereby the consequent of the rule matches the query formula. If there are any such rules, then the query can be proved if the antecedent of any one them can be shown to be true. This can be performed recursively by backward chaining on the antecedent as a new query. The Prolog programming language is a backward chaining system that implements this strategy.

To see how this works, let’s assume that we have been asked to verify the truth of the proposition Serves(Leaf,VegetarianFood), assuming the facts given above the line in (H.37). Since this proposition is not present in the knowledge base, a search for an applicable rule is initiated resulting in the rule given above. After substituting the constant Leaf for the variable x, our next task is to prove the antecedent of the rule, VegetarianRestaurant(Leaf), which, of course, is one of the facts we are given.

Note that it is critical to distinguish between reasoning by backward chaining from queries to known facts and reasoning backwards from known consequents to unknown antecedents. To be specific, by reasoning backwards we mean that if the consequent of a rule is known to be true, we assume that the antecedent will be as well. For example, let’s assume that we know that Serves(Leaf ,VegetarianFood) is true. Since this fact matches the consequent of our rule, we might reason backwards to the conclusion that VegetarianRestaurant(Leaf).

While backward chaining is a sound method of reasoning, reasoning backwards is an invalid, though frequently useful, form of plausible reasoning. Plausible reasoning from consequents to antecedents is known as abduction, and as we show in Chapter 25, is often useful in accounting for many of the inferences people make while analyzing extended discourses.

While forward and backward reasoning are sound, neither is complete. This means that there are valid inferences that cannot be found by systems using these methods alone. Fortunately, there is an alternative inference technique called resolution that is sound and complete. Unfortunately, inference systems based on resolution are far more computationally expensive than forward or backward chaining systems. In practice, therefore, most systems use some form of chaining and place a burden on knowledge base developers to encode the knowledge in a fashion that permits the necessary inferences to be drawn.

## H.4 Event and State Representations

Much of the semantics that we wish to capture consists of representations of states and events. States are conditions, or properties, that remain unchanged over an extended period of time, and events denote changes in some state of affairs. The representation of both states and events may involve a host of participants, props, times and locations.

The representations for events and states that we have used thus far have consisted of single predicates with as many arguments as are needed to incorporate all the roles associated with a given example. For example, the representation for Leaf serves vegetarian fare consists of a single predicate with arguments for the entity doing the serving and the thing served.

$$
S e r \nu e s ( L e a f , V e g e t a r i a n F a r e )\tag{H.38}
$$

This approach assumes that the predicate used to represent an event verb has the same number of arguments as are present in the verb’s syntactic subcategorization frame. Unfortunately, this is clearly not always the case. Consider the following examples of the verb eat:

(H.39) I ate.

(H.40) I ate a turkey sandwich.

(H.41) I ate a turkey sandwich at my desk.

(H.42) I ate at my desk.

(H.43) I ate lunch.

(H.44) I ate a turkey sandwich for lunch.

(H.45) I ate a turkey sandwich for lunch at my desk.

Clearly, choosing the correct number of arguments for the predicate representing the meaning of eat is a tricky problem. These examples introduce five distinct arguments, or roles, in an array of different syntactic forms, locations, and combinations. Unfortunately, predicates in FOL have fixed arity – they take a fixed number of arguments.

To address this problem, we introduce the notion of an event variable to allow us to make assertions about particular events. To do this, we can refactor our event predicates to have an existentially quantified variable as their first, and only, argument. Using this event variable, we can introduce additional predicates to represent the other information we have about the event. These predicates take an event variable as their first argument and related FOL terms as their second argument. The following formula illustrates this scheme with the meaning representation of H.40 from our earlier discussion.

$$
\exists e E a t i n g ( e ) \ \land \ E a t e r ( e , S p e a k e r ) \land E a t e n ( e , T u r k e y S a n d w i c h )
$$

Here, the quantified variable e stands for the eating event and is used to bind the event predicate with the core information provided via the named roles Eater and Eaten. To handle the more complex examples, we simply add additional relations to capture the provided information, as in the following for H.45.

$$
\begin{array} { l } { \exists e E a t i n g ( e ) \ \land \ E a t e r ( e , S p e a k e r ) \land E a t e n ( e , T u r k e y S a n d w i c h ) } \\ \ \land \ M e a l ( e , L u n c h ) \land L o c a t i o n ( e , D e s k )  \end{array}\tag{H.46}
$$

Event representations of this sort are referred to as neo-Davidsonian event representations (Davidson 1967, Parsons 1990) after the philosopher Donald Davidson who introduced the notion of an event variable (Davidson, 1967). To summarize, in the neo-Davidsonian approach to event representations:

• Events are captured with predicates that take a single event variable as an argument.

• There is no need to specify a fixed number of arguments for a given FOL predicate; rather, as many roles and fillers can be glued on as are provided in the input.

• No more roles are postulated than are mentioned in the input.

• The logical connections among closely related inputs that share the same predicate are satisfied without the need for additional inference.

This approach still leaves us with the problem of determining the set of predicates needed to represent roles associated with specific events like Eater and Eaten, as well as more general concepts like Location and Time. We’ll return to this problem in more detail in Chapter 21 and Chapter 22.

## H.5 Description Logics

As noted at the beginning of this chapter, a fair number of representational schemes have been invented to capture the meaning of linguistic utterances. It is now widely accepted that meanings represented in these various approaches can, in principle, be translated into equivalent statements in FOL with relative ease. The difficulty is that in many of these approaches the semantics of a statement are defined procedurally. That is, the meaning arises from whatever the system that interprets it does with it.

Description logics are an effort to better specify the semantics of these earlier structured network representations and to provide a conceptual framework that is especially well suited to certain kinds of domain modeling. Formally, the term Description Logics refers to a family of logical approaches that correspond to varying subsets of FOL. The restrictions placed on the expressiveness of Description Logics serve to guarantee the tractability of various critical kinds of inference. Our focus here, however, will be on the modeling aspects of DLs rather than on computational complexity issues.

When using Description Logics to model an application domain, the emphasis is on the representation of knowledge about categories, individuals that belong to those categories, and the relationships that can hold among these individuals. The set of categories, or concepts, that make up a particular application domain is called its terminology. The portion of a knowledge base that contains the terminology is traditionally called the TBox; this is in contrast to the ABox that contains facts about individuals. The terminology is typically arranged into a hierarchical organization called an ontology that captures the subset/superset relations among the categories.

Returning to our earlier culinary domain, we represented domain concepts using unary predicates such as Restaurant(x); the DL equivalent omits the variable, so the restaurant category is simply written as Restaurant.<sup>2</sup> To capture the fact that a particular domain element, such as Frasca, is a restaurant, we assert Restaurant(Frasca) in much the same way we would in FOL. The semantics of these categories are specified in precisely the same way that was introduced earlier in Section H.2: a category like Restaurant simply denotes the set of domain elements that are restaurants.

Once we’ve specified the categories of interest in a particular domain, the next step is to arrange them into a hierarchical structure. There are two ways to capture the hierarchical relationships present in a terminology: we can directly assert relations between categories that are related hierarchically, or we can provide complete definitions for our concepts and then rely on inference to provide hierarchical relationships. The choice between these methods hinges on the use to which the resulting categories will be put and the feasibility of formulating precise definitions for many naturally occurring categories. We’ll discuss the first option here and return to the notion of definitions later in this section.

To directly specify a hierarchical structure, we can assert subsumption relations between the appropriate concepts in a terminology. The subsumption relation is conventionally written as $C \subseteq D$ and is read as C is subsumed by D; that is, all members of the category C are also members of the category D. Not surprisingly, the formal semantics of this relation are provided by a simple set relation; any domain element that is in the set denoted by C is also in the set denoted by D.

Adding the following statements to the TBox asserts that all restaurants are commercial establishments and, moreover, that there are various subtypes of restaurants.

$$
\mathsf { R e s t a u r a n t \subseteq c o m m e r c i a l E s t a b l i s h m e n t }\tag{H.47}
$$

$$
\mathsf { l t a l i a n R e s t a u r a n t \subseteq R e s t a u r a n t }\tag{H.48}
$$

$$
{ \mathsf { C h i n e s e R e s t a u r a n t } } \ \sqsubseteq \ { \mathsf { R e s t a u r a n t } }\tag{H.49}
$$

$$
\mathsf { M e x i c a n R e s t a u r a n t \subseteq R e s t a u r a n t }\tag{H.50}
$$

Ontologies such as this are conventionally illustrated with diagrams such as the one shown in Fig. H.5, where subsumption relations are denoted by links between the nodes representing the categories.

![](images/01bae80777e139e46d77369df79e95e05ca710b2b697891c2f10c1e28c6905b6.jpg)  
Figure H.5 A graphical network representation of a set of subsumption relations in the restaurant domain.

Note, that it was precisely the vague nature of semantic network diagrams like this that motivated the development of Description Logics. For example, from this diagram we can’t tell whether the given set of categories is exhaustive or disjoint. That is, we can’t tell if these are all the kinds of restaurants that we’ll be dealing with in our domain or whether there might be others. We also can’t tell if an individual restaurant must fall into only one of these categories, or if it is possible, for example, for a restaurant to be both Italian and Chinese. The DL statements given above are more transparent in their meaning; they simply assert a set of subsumption relations between categories and make no claims about coverage or mutual exclusion.

If an application requires coverage and disjointness information, then such information must be made explicitly. The simplest ways to capture this kind of information is through the use of negation and disjunction operators. For example, the following assertion would tell us that Chinese restaurants can’t also be Italian restaurants.

$$
\mathtt { C h i n e s e R e s t a u r a n t \underbrace { = n o t \mid t a \mid i a n R e s t a u r a n t } _ { } }\tag{H.51}
$$

Specifying that a set of subconcepts covers a category can be achieved with disjunction, as in the following:

Restaurant ⊑

$$
( \mathbf { o r } \ | \mathsf { t a l i a n R e s t a u r a n t } \ C h i n e s e \mathsf { R e s t a u r a n t } \ \mathsf { M e x i c a n R e s t a u r a n t } )\tag{H.52}
$$

Having a hierarchy such as the one given in Fig. H.5 tells us next to nothing about the concepts in it. We certainly don’t know anything about what makes a restaurant a restaurant, much less Italian, Chinese, or expensive. What is needed are additional assertions about what it means to be a member of any of these categories. In Description Logics such statements come in the form of relations between the concepts being described and other concepts in the domain. In keeping with its origins in structured network representations, relations in Description Logics are typically binary and are often referred to as roles, or role-relations.

To see how such relations work, let’s consider some of the facts about restaurants discussed earlier in the chapter. We’ll use the hasCuisine relation to capture information as to what kinds of food restaurants serve and the hasPriceRange relation to capture how pricey particular restaurants tend to be. We can use these relations to say something more concrete about our various classes of restaurants. Let’s start with our ItalianRestaurant concept. As a first approximation, we might say something uncontroversial like Italian restaurants serve Italian cuisine. To capture these notions, let’s first add some new concepts to our terminology to represent various kinds of cuisine.

$$
{ \begin{array} { r l r } { { \mathsf { M e x i c a n C u i s i n e } } \ \sqsubseteq \ { \mathsf { C u i s i n e } } } & { \quad } & { { \mathsf { E x p e n s i v e R e s t a u r a n t } } \ \sqsubseteq \ { \mathsf { R e s t a u r a n t } } } \\ { { \mathsf { l t a l i a n C u i s i n e } } \ \sqsubseteq \ { \mathsf { C u i s i n e } } } & { \quad } & { { \mathsf { M o d e r a t e R e s t a u r a n t } } \ \sqsubseteq \ { \mathsf { R e s t a u r a n t } } } \\ { { \mathsf { C h i n e s e C u i s i n e } } \ \sqsubseteq \ { \mathsf { C u i s i n e } } } & { \quad } & { { \mathsf { C h e a p R e s t a u r a n t } } \ \sqsubseteq \ { \mathsf { R e s t a u r a n t } } } \\ { { \mathsf { V e g e t a r i a n C u i s i n e } } \ \sqsubseteq \ { \mathsf { C u i s i n e } } } & \end{array} }
$$

Next, let’s revise our earlier version of ItalianRestaurant to capture cuisine information.

$$
\mathsf { l t a l i a n R e s t a u r a n t \subseteq R e s t a u r a n t \Pi \exists h a s C u i s i n e . l t a l i a n C u i s i n e }\tag{H.53}
$$

The correct way to read this expression is that individuals in the category Italian-Restaurant are subsumed both by the category Restaurant and by an unnamed class defined by the existential clause—the set of entities that serve Italian cuisine. An equivalent statement in FOL would be

$$
\begin{array} { l l l } { { \forall x I t a l i a n R e s t a u r a n t ( x ) } } & { {  } } & { { R e s t a u r a n t ( x ) } } \\ { { } } & { { } } & { { \land ( \exists y S e r \nu e s ( x , y ) \land I t a l i a n C u i s i n e ( y ) ) } } \end{array}\tag{H.54}
$$

This FOL translation should make it clear what the DL assertions given above do and do not entail. In particular, they don’t say that domain entities classified as Italian restaurants can’t engage in other relations like being expensive or even serving Chinese cuisine. And critically, they don’t say much about domain entities that we know do serve Italian cuisine. In fact, inspection of the FOL translation makes it clear that we cannot infer that any new entities belong to this category based on their characteristics. The best we can do is infer new facts about restaurants that we’re explicitly told are members of this category.

Of course, inferring the category membership of individuals given certain characteristics is a common and critical reasoning task that we need to support. This brings us back to the alternative approach to creating hierarchical structures in a terminology: actually providing a definition of the categories we’re creating in the form of necessary and sufficient conditions for category membership. In this case, we might explicitly provide a definition for ItalianRestaurant as being those restaurants that serve Italian cuisine, and ModerateRestaurant as being those whose price range is moderate.

$$
\mathsf { l t a l i a n R e s t a u r a n t \equiv R e s t a u r a n t \Pi \exists h a s C u i s i n e . l t a l i a n C u i s i n e }\tag{H.55}
$$

$$
\mathsf { M o d e r a t e R e s t a u r a n t \equiv R e s t a u r a n t \Pi \ l n a s P r i c e R a n g e . M o d e r a t e P r i c e s }\tag{H.56}
$$

While our earlier statements provided necessary conditions for membership in these categories, these statements provide both necessary and sufficient conditions.

Finally, let’s now consider the superficially similar case of vegetarian restaurants. Clearly, vegetarian restaurants are those that serve vegetarian cuisine. But they don’t merely serve vegetarian fare, that’s all they serve. We can accommodate this kind of constraint by adding an additional restriction in the form of a universal quantifier to our earlier description of VegetarianRestaurants, as follows:

$$
{ \begin{array} { l } { { \mathsf { V e g e t a r i a n R e s t a u r a n t } } \equiv { \mathsf { R e s t a u r a n t } } } \\ { { \mathsf { T l h a s C u i s i n e . V e g e t a r i a n C u i s i n e } } } \\ { { \mathsf { N T M e n s C u i s i n e . V e g e t a r i a n C u i s i n e } } } \end{array} }\tag{H.57}
$$

## Inference

Paralleling the focus of Description Logics on categories, relations, and individuals is a processing focus on a restricted subset of logical inference. Rather than employing the full range of reasoning permitted by FOL, DL reasoning systems emphasize the closely coupled problems of subsumption and instance checking.

Subsumption, as a form of inference, is the task of determining, based on the facts asserted in a terminology, whether a superset/subset relationship exists between two concepts. Correspondingly, instance checking asks if an individual can be a member of a particular category given the facts we know about both the individual and the terminology. The inference mechanisms underlying subsumption and instance checking go beyond simply checking for explicitly stated subsumption relations in a terminology. They must explicitly reason using the relational information asserted about the terminology to infer appropriate subsumption and membership relations.

Returning to our restaurant domain, let’s add a new kind of restaurant using the following statement:

$$
1 | \mathsf { F o r n a i o } \sqsubset \mathsf { M o d e r a t e R e s t a u r a n t } \sqcap \mathsf { \exists h a s C u i s i n e . } | \mathsf { t a l i a n C u i s i n e }\tag{H.58}
$$

Given this assertion, we might ask whether the IlFornaio chain of restaurants might be classified as an Italian restaurant or a vegetarian restaurant. More precisely, we can pose the following questions to our reasoning system:

$$
| | \mathsf { F o r n a i o \subseteq \mathsf { I t a l i a n R e s t a u r a n t } }\tag{H.59}
$$

$$
\mathsf { I I F o r n a i o \Pi \subseteq \mathsf { V e g e t a r i a n R e s t a u r a n t } }\tag{H.60}
$$

The answer to the first question is positive since IlFornaio meets the criteria we specified for the category ItalianRestaurant: it’s a Restaurant since we explicitly classified it as a ModerateRestaurant, which is a subtype of Restaurant, and it meets the has.Cuisine class restriction since we’ve asserted that directly.

The answer to the second question is negative. Recall, that our criteria for vegetarian restaurants contains two requirements: it has to serve vegetarian fare, and that’s all it can serve. Our current definition for IlFornaio fails on both counts since we have not asserted any relations that state that IlFornaio serves vegetarian fare, and the relation we have asserted, hasCuisine.ItalianCuisine, contradicts the second criteria.

A related reasoning task, based on the basic subsumption inference, is to derive the implied hierarchy for a terminology given facts about the categories in the terminology. This task roughly corresponds to a repeated application of the subsumption operator to pairs of concepts in the terminology. Given our current collection of statements, the expanded hierarchy shown in Fig. H.6 can be inferred. You should convince yourself that this diagram contains all and only the subsumption links that should be present given our current knowledge.

Instance checking is the task of determining whether a particular individual can be classified as a member of a particular category. This process takes what is known about a given individual, in the form of relations and explicit categorical statements, and then compares that information with what is known about the current terminology. It then returns a list of the most specific categories to which the individual can belong.

As an example of a categorization problem, consider an establishment that we’re

![](images/26fb5615f175f220e3bd36195c2cde6bfaf57e2c29abe7e2548f38a990a7a108.jpg)  
Figure H.6 A graphical network representation of the complete set of subsumption relations in the restaurant domain given the current set of assertions in the TBox.

told is a restaurant and serves Italian cuisine.

## Restaurant(Gondolier) hasCuisine(Gondolier,ItalianCuisine)

Here, we’re being told that the entity denoted by the term Gondolier is a restaurant and serves Italian food. Given this new information and the contents of our current TBox, we might reasonably like to ask if this is an Italian restaurant, if it is a vegetarian restaurant, or if it has moderate prices.

Assuming the definitional statements given earlier, we can indeed categorize the Gondolier as an Italian restaurant. That is, the information we’ve been given about it meets the necessary and sufficient conditions required for membership in this category. And as with the IlFornaio category, this individual fails to match the stated criteria for the VegetarianRestaurant. Finally, the Gondolier might also turn out to be a moderately priced restaurant, but we can’t tell at this point since we don’t know anything about its prices. What this means is that given our current knowledge the answer to the query ModerateRestaurant(Gondolier) would be false since it lacks the required hasPriceRange relation.

The implementation of subsumption, instance checking, as well as other kinds of inferences needed for practical applications, varies according to the expressivity of the Description Logic being used. However, for a Description Logic of even modest power, the primary implementation techniques are based on satisfiability methods that in turn rely on the underlying model-based semantics introduced earlier in this chapter.

## OWL and the Semantic Web

The highest-profile role for Description Logics, to date, has been as a part of the development of the Semantic Web. The Semantic Web is an ongoing effort to provide a way to formally specify the semantics of the contents of the Web (Fensel et al., 2003). A key component of this effort involves the creation and deployment of ontologies for various application areas of interest. The meaning representation language used to represent this knowledge is the Web Ontology Language (OWL) (McGuiness and van Harmelen, 2004). OWL embodies a Description Logic that corresponds roughly to the one we’ve been describing here.

## H.6 Summary

This chapter has introduced the representational approach to meaning. The following are some of the highlights of this chapter:

• A major approach to meaning in computational linguistics involves the creation of formal meaning representations that capture the meaning-related content of linguistic inputs. These representations are intended to bridge the gap from language to common-sense knowledge of the world.

• The frameworks that specify the syntax and semantics of these representations are called meaning representation languages. A wide variety of such languages are used in natural language processing and artificial intelligence.

• Such representations need to be able to support the practical computational requirements of semantic processing. Among these are the need to determine the truth of propositions, to support unambiguous representations, to represent variables, to support inference, and to be sufficiently expressive.

• Human languages have a wide variety of features that are used to convey meaning. Among the most important of these is the ability to convey a predicateargument structure.

• First-Order Logic is a well-understood, computationally tractable meaning representation language that offers much of what is needed in a meaning representation language.

• Important elements of semantic representation including states and events can be captured in FOL.

• Semantic networks and frames can be captured within the FOL framework.

• Modern Description Logics consist of useful and computationally tractable subsets of full First-Order Logic. The most prominent use of a description logic is the Web Ontology Language (OWL), used in the specification of the Semantic Web.

## Historical Notes

The earliest computational use of declarative meaning representations in natural language processing was in the context of question-answering systems (Green et al. 1961, Raphael 1968, Lindsey 1963). These systems employed ad hoc representations for the facts needed to answer questions. Questions were then translated into a form that could be matched against facts in the knowledge base. Simmons (1965) provides an overview of these early efforts.

Woods (1967) investigated the use of FOL-like representations in question answering as a replacement for the ad hoc representations in use at the time. Woods (1973) further developed and extended these ideas in the landmark Lunar system. Interestingly, the representations used in Lunar had both truth-conditional and procedural semantics. Winograd (1972) employed a similar representation based on the Micro-Planner language in his SHRDLU system.

During this same period, researchers interested in the cognitive modeling of language and memory had been working with various forms of associative network representations. Masterman (1957) was the first to make computational use of a semantic network-like knowledge representation, although semantic networks are generally credited to Quillian (1968). A considerable amount of work in the semantic network framework was carried out during this era (Norman and Rumelhart 1975, Schank 1972, Wilks 1975b, Wilks 1975a, Kintsch 1974). It was during this period that a number of researchers began to incorporate Fillmore’s notion of case roles (Fillmore, 1968) into their representations. Simmons (1973) was the earliest adopter of case roles as part of representations for natural language processing.

Detailed analyses by Woods (1975) and Brachman (1979) aimed at figuring out what semantic networks actually mean led to the development of a number of more sophisticated network-like languages including KRL (Bobrow and Winograd, 1977) and KL-ONE (Brachman and Schmolze, 1985). As these frameworks became more sophisticated and well defined, it became clear that they were restricted variants of FOL coupled with specialized indexing inference procedures. A useful collection of papers covering much of this work can be found in Brachman and Levesque (1985). Russell and Norvig (2002) describe a modern perspective on these representational efforts.

Linguistic efforts to assign semantic structures to natural language sentences in the generative era began with the work of Katz and Fodor (1963). The limitations of their simple feature-based representations and the natural fit of logic to many of the linguistic problems of the day quickly led to the adoption of a variety of predicateargument structures as preferred semantic representations (Lakoff 1972, McCawley 1968). The subsequent introduction by Montague (1973) of the truth-conditional model-theoretic framework into linguistic theory led to a much tighter integration between theories of formal syntax and a wide range of formal semantic frameworks. Good introductions to Montague semantics and its role in linguistic theory can be found in Dowty et al. (1981) and Partee (1976).

The representation of events as reified objects is due to Davidson (1967). The approach presented here, which explicitly reifies event participants, is due to Parsons (1990).

A recent comprehensive treatment of logic and language can be found in van Benthem and ter Meulen (1997). A classic semantics text is Lyons (1977). McCawley (1993) is an indispensable textbook covering a wide range of topics concerning logic and language. Chierchia and McConnell-Ginet (1991) also broadly covers semantic issues from a linguistic perspective. Heim and Kratzer (1998) is a more recent text written from the perspective of current generative theory.

## Exercises

H.1 Peruse your daily newspaper for three examples of ambiguous sentences or headlines. Describe the various sources of the ambiguities.

H.2 Consider a domain in which the word coffee can refer to the following concepts in a knowledge-based system: a caffeinated or decaffeinated beverage, ground coffee used to make either kind of beverage, and the beans themselves. Give arguments as to which of the following uses of coffee are ambiguous and which are vague.

1. I’ve had my coffee for today.

2. Buy some coffee on your way home.

3. Please grind some more coffee.

H.3 The following rule, which we gave as a translation for Example H.25, is not a reasonable definition of what it means to be a vegetarian restaurant.

$$
\forall x V e g e t a r i a n R e s t a u r a n t ( x ) \implies S e r \nu e s ( x , V e g e t a r i a n F o o d )
$$

Give a FOL rule that better defines vegetarian restaurants in terms of what they serve.

H.4 Give FOL translations for the following sentences:

1. Vegetarians do not eat meat.

2. Not all vegetarians eat eggs.

H.5 Give a set of facts and inferences necessary to prove the following assertions:

1. McDonald’s is not a vegetarian restaurant.

2. Some vegetarians can eat at McDonald’s.

Don’t just place these facts in your knowledge base. Show that they can be inferred from some more general facts about vegetarians and McDonald’s.

H.6 On page 12, we gave the representation Near(Centro,Bacaro) as a translation for the sentence Centro is near Bacaro. In a truth-conditional semantics, this formula is either true or false given some model. Critique this truthconditional approach with respect to the meaning of words like near.

Banarescu, L., C. Bonial, S. Cai, M. Georgescu, K. Grif fitt, U. Hermjakob, K. Knight, P. Koehn, M. Palmer, and N. Schneider. 2013. Abstract meaning representation for sembanking. 7th Linguistic Annotation Workshop and In teroperability with Discourse.

van Benthem, J. and A. ter Meulen, eds. 1997. Handbook of Logic and Language. MIT Press.

Bobrow, D. G. and T. Winograd. 1977. An overview of KRL, a knowledge representation language. Cognitive Science, 1(1):3–46.

Brachman, R. J. 1979. On the epistemogical status of semantic networks. In N. V. Findler, ed., Associative Networks: Representation and Use of Knowledge by Computers, 3– 50. Academic Press.

Brachman, R. J. and H. J. Levesque, eds. 1985. Readings in Knowledge Representation. Morgan Kaufmann.

Brachman, R. J. and J. G. Schmolze. 1985. An overview of the KL-ONE knowledge representation system. Cognitive Science, 9(2):171–216.

Chierchia, G. and S. McConnell-Ginet. 1991. Meaning and Grammar. MIT Press.

Church, A. 1940. A formulation of a simple theory of types. Journal ofSymbolic Logic, 5:56–68.

Davidson, D. 1967. The logical form of action sentences. In N. Rescher, ed., The Logic of Decision and Action. University of Pittsburgh Press.

Dowty, D. R., R. E. Wall, and S. Peters. 1981. Introduction to Montague Semantics. D. Reidel.

Fensel, D., J. A. Hendler, H. Lieberman, and W. Wahlster, eds. 2003. Spinning the Semantic Web: Bring the World Wide Web to its Full Potential. MIT Press, Cambridge, MA.

Fillmore, C. J. 1968. The case for case. In E. W. Bach and R. T. Harms, eds, Universals in Linguistic Theory, 1–88. Holt, Rinehart & Winston.

Green, B. F., A. K. Wolf, C. Chomsky, and K. Laughery. 1961. Baseball: An automatic question answerer. Pro ceedings ofthe Western Joint Computer Conference 19.

Heim, I. and A. Kratzer. 1998. Semantics in a Generative Grammar. Blackwell Publishers, Malden, MA.

Katz, J. J. and J. A. Fodor. 1963. The structure of a semantic theory. Language, 39:170–210.

Kintsch, W. 1974. The Representation of Meaning in Mem ory. Wiley, New York.

Lakoff, G. 1972. Linguistics and natural logic. In D. David son and G. Harman, eds, Semantics for Natural Language, 545–665. D. Reidel.

Lindsey, R. 1963. Inferential memory as the basis of machines which understand natural language. In E. Feigenbaum and J. Feldman, eds, Computers and Thought, 217– 233. McGraw Hill.

Lyons, J. 1977. Semantics. Cambridge University Press.

Masterman, M. 1957. The thesaurus in syntax and semantics. Mechanical Translation, 4(1):1–2.

McCawley, J. D. 1968. The role of semantics in a grammar. In E. W. Bach and R. T. Harms, eds, Universals in Linguistic Theory, 124–169. Holt, Rinehart & Winston.

McCawley, J. D. 1993. Everything that Linguists Have Always Wanted to Know about Logic, 2nd edition. University of Chicago Press, Chicago, IL.

McGuiness, D. L. and F. van Harmelen. 2004. OWL web ontology overview. Technical Report 20040210, World Wide Web Consortium.

Montague, R. 1973. The proper treatment of quantification in ordinary English. In R. Thomason, ed., Formal Philosophy: Selected Papers of Richard Montague, 247–270. Yale University Press, New Haven, CT.

Norman, D. A. and D. E. Rumelhart. 1975. Explorations in Cognition. Freeman.

Parsons, T. 1990. Events in the Semantics of English. MIT Press.

Partee, B. H., ed. 1976. Montague Grammar. Academic Press.

Quillian, M. R. 1968. Semantic memory. In M. Minsky, ed., Semantic Information Processing, 227–270. MIT Press.

Raphael, B. 1968. SIR: A computer program for semantic information retrieval. In M. Minsky, ed., Semantic Information Processing, 33–145. MIT Press.

Russell, S. and P. Norvig. 2002. Artificial Intelligence: A Modern Approach, 2nd edition. Prentice Hall.

Schank, R. C. 1972. Conceptual dependency: A theory of natural language processing. Cognitive Psychology, 3:552–631.

Schonfinkel, M. 1924.¨ Uber die Bausteine der mathema-<sup>¨</sup> tischen Logik. Mathematische Annalen, 92:305–316. English translation appears in From Frege to Godel: A¨ Source Book in Mathematical Logic, Harvard University Press, 1967.

Simmons, R. F. 1965. Answering English questions by computer: A survey. CACM, 8(1):53–70.

Simmons, R. F. 1973. Semantic networks: Their computation and use for understanding English sentences. In R. C. Schank and K. M. Colby, eds, Computer Models of Thought and Language, 61–113. W.H. Freeman & Co.

Wilks, Y. 1975a. Preference semantics. In E. L. Keenan, ed., The Formal Semantics of Natural Language, 329– 350. Cambridge Univ. Press.

Wilks, Y. 1975b. A preferential, pattern-seeking, semantics for natural language inference. Artificial Intelligence, 6(1):53–74.

Winograd, T. 1972. Understanding Natural Language. Academic Press.

Woods, W. A. 1967. Semantics for a Question-Answering System. Ph.D. thesis, Harvard University.

Woods, W. A. 1973. Progress in natural language understanding. Proceedings of AFIPS National Conference.

Woods, W. A. 1975. What’s in a link: Foundations for semantic networks. In D. G. Bobrow and A. M. Collins, eds, Representation and Understanding: Studies in Cognitive Science, 35–82. Academic Press.