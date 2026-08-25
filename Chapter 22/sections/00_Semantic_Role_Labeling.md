# emantic Role Labeling

“Who, What, Where, When, With what, Why, How” The seven circumstances, associated with Hermagoras and Aristotle (Sloan, 2010)

Sometime between the 7th and 4th centuries BCE, the Indian grammarian Pan¯ <sub>.</sub> ini<sup>1</sup> wrote a famous treatise on Sanskrit grammar, the As<sub>.</sub>t<sub>.</sub>adhy¯ ay¯ ¯ı (‘8 books’), a treatise

that has been called “one of the greatest monuments of human intelligence” (Bloomfield, 1933, 11). The work describes the linguistics of the Sanskrit language in the form of 3959 sutras, each very efficiently (since it had to be memorized!) expressing part of a formal rule system that brilliantly prefigured modern mechanisms of formal language theory (Penn and Kiparsky, 2012). One set of rules describes the karakas¯ , semantic relationships between a verb and noun arguments, roles like agent, instrument, or destination. Pan¯ <sub>.</sub> ini’s work was the earliest we know of that modeled the linguistic realization of events and their

![](../images/4df661d90c097c589866a0245b9cd44dbb7f9a1f77f5a9869a6bb53a340f6094.jpg)

participants. This task of understanding how participants relate to events—being able to answer the question “Who did what to whom” (and perhaps also “when and where”)—is a central question of natural language processing.

Let’s move forward 2.5 millennia to the present and consider the very mundane goal of understanding text about a purchase of stock by XYZ Corporation. This purchasing event and its participants can be described by a wide variety of surface forms. The event can be described by a verb (sold, bought) or a noun (purchase), and XYZ Corp can be the syntactic subject (of bought), the indirect object (of sold), or in a genitive or noun compound relation (with the noun purchase) despite having notionally the same role in all of them:

• XYZ corporation bought the stock.

• They sold the stock to XYZ corporation.

• The stock was bought by XYZ corporation.

• The purchase of the stock by XYZ corporation...

• The stock purchase by XYZ corporation...

In this chapter we introduce a level of representation that captures the commonality between these sentences: there was a purchase event, the participants were XYZ Corp and some stock, and XYZ Corp was the buyer. These shallow semantic representations , semantic roles, express the role that arguments of a predicate take in the event, codified in databases like PropBank and FrameNet. We’ll introduce semantic role labeling, the task of assigning roles to spans in sentences, and selectional restrictions, the preferences that predicates express about their arguments, such as the fact that the theme of eat is generally something edible.
