26

## Conversation and its Structure

Conversation is an intricate and complex joint activity, and conversations have structure. This is true of all conversations, whether they are conversations between people or conversations between people and language models. Understanding the structure of human conversations is an important social science and linguistic task. The concepts we introduce in studying human conversation can also be a useful tool for analyzing human-LLM conversations.

[This draft is the initial stub of a chapter that will introduce different kinds of conversational structure and how to annotate them computationally.]

## 26.1 Properties of Human Conversation

What are the conversational phenomena that take place when humans converse with each other? Are conversations between humans and machines different? Consider what goes on in the conversation between a human travel agent and a human client excerpted in Fig. 26.1.

```txt
C1: ...I need to travel in May.
A2: And, what day in May did you want to travel?
C3: OK uh I need to be there for a meeting that's from the 12th to the 15th.
A4: And you're flying into what city?
C5: Seattle.
A6: And what time would you like to leave Pittsburgh?
C7: Uh hmm I don't think there's many options for non-stop.
A8: Right. There's three non-stops today.
C9: What are they?
A10: The first one departs PGH at 10:00am arrives Seattle at 12:05 their time. The second flight departs PGH at 5:55pm, arrives Seattle at 8pm. And the last flight departs PGH at 8:15pm arrives Seattle at 10:28pm.
C11: OK I'll take the 5ish flight on the night before on the 11th.
A12: On the 11th? OK. Departing at 5:55pm arrives Seattle at 8pm, U.S. Air flight 115.
C13: OK.
A14: And you said returning on May 15th?
C15: Uh, yeah, at the end of the day.
A16: OK. There's #two non-stops ...#
C17: #Act...actually #, what day of the week is the 15th?
A18: It's a Friday.
C19: Uh hmm. I would consider staying there an extra day til Sunday.
A20: OK...OK. On Sunday I have ...
Figure 26.1 Part of a phone conversation between a human travel agent (A) and human client (C). The passages framed by # in A16 and C17 indicate overlaps in speech.
```

## 26.1.1 Turns

A dialogue is a sequence of turns $( \mathbf { C } _ { 1 } , \mathbf { A } _ { 2 } , \mathbf { C } _ { 3 } ,$ , and so on), each a single contribution from one speaker to the dialogue (as if in a game: I take a turn, then you take a turn, then me, and so on). There are 20 turns in Fig. 26.1. A turn can consist of a sentence (like $\mathrm { C } _ { 1 } )$ , although it might be as short as a single word $( \mathbf { C } _ { 1 3 } )$ or as long as multiple sentences $\left( \mathsf { A } _ { 1 0 } \right)$

Turn structure has important implications for spoken dialogue. A human has to know when to stop talking; the client interrupts (in $\mathbf { A } _ { 1 6 }$ and $\mathbf { C } _ { 1 7 } )$ , so a system that was performing this role must know to stop talking (and that the user might be making a correction).

The same issues come up for LLMs; a system also has to know when to start talking. For example, most of the time in conversation, speakers start their turns almost immediately after the other speaker finishes, without a long pause, because people are can usually predict when the other person is about to finish talking.

Spoken language models must also detect whether a user is done speaking, so they can process the utterance and respond. This task—called endpointing or endpoint detection— can be quite challenging because of noise and because people often pause in the middle of turns.

## 26.1.2 Speech Acts

A key insight into conversation—due originally to the philosopher Wittgenstein (1953) but worked out more fully by Austin (1962)—is that each utterance in a dialogue is a kind of action being performed by the speaker. These actions are commonly called speech acts or dialogue acts: here’s one taxonomy consisting of 4 major classes (Bach and Harnish, 1979):

<table><tr><td>Constatives:</td><td>committing the speaker to something&#x27;s being the case (answering, claiming, confirming, denying, disagreeing, stating)</td></tr><tr><td>Directives:</td><td>attempts by the speaker to get the addressee to do something (advising, ask-ing, forbidding, inviting, ordering, requesting)</td></tr><tr><td>Commissives:</td><td>committing the speaker to some future course of action (promising, planning, vowing, betting, opposing)</td></tr><tr><td>Acknowledgments:</td><td>express the speaker&#x27;s attitude regarding the hearer with respect to some so-cial action (apologizing, greeting, thanking, accepting an acknowledgment)</td></tr></table>

A user asking a person or a dialogue system to do something (‘Turn up the music’) is issuing a DIRECTIVE. Asking a question that requires an answer is also a way of issuing a DIRECTIVE: in a sense when the system says $( \mathbf { A } _ { 2 } )$ “what day in May did you want to travel?” it’s as if the system is (very politely) commanding the user to answer. By contrast, a user stating a constraint (like $\mathrm { C } _ { 1 }$ ‘I need to travel in May’) is issuing a CONSTATIVE. A user thanking the system is issuing an ACKNOWLEDGMENT. The speech act expresses an important component of the intention of the speaker (or writer) in saying what they said.

## 26.1.3 Grounding

A dialogue is not just a series of independent speech acts, but rather a collective act performed by the speaker and the hearer. Like all collective acts, it’s important for the participants to establish what they both agree on, called the common ground (Stalnaker, 1978). Speakers do this by grounding each other’s utterances. Grounding means acknowledging that the hearer has understood the speaker (Clark, 1996). (People need grounding for non-linguistic actions as well; the reason an elevator button lights up when it’s pressed is to acknowledge that the elevator has indeed been called, essentially grounding your action of pushing the button (Norman, 1988).)

Grounding is also important when the hearer needs to indicate that the speaker has not succeeded in performing an action. If the hearer has problems in understanding, she must indicate these problems to the speaker, again so that mutual understanding can eventually be achieved.

How is closure achieved? Clark and Schaefer (1989) introduce the idea that each joint linguistic act or contribution has two phases, called presentation and acceptance. In the first phase, a speaker presents the hearer with an utterance, performing a sort of speech act. In the acceptance phase, the hearer has to ground the utterance, indicating to the speaker whether understanding was achieved.

What methods can the hearer B use to ground the speaker A’s utterance? Clark and Schaefer (1989) discuss a continuum of methods ordered from weakest to strongest:

<table><tr><td>Continued attention:</td><td>B shows she is continuing to attend and therefore remains satisfied with A&#x27;s presentation.</td></tr><tr><td>Next contribution:</td><td>B starts in on the next relevant contribution.</td></tr><tr><td>Acknowledgment:</td><td>B nods or says a continuer like uh-huh, yeah, or the like, or an assessment like that&#x27;s great.</td></tr><tr><td>Demonstration:</td><td>B demonstrates all or part of what she has understood A to mean, for example, by reformulating (paraphrasing) A&#x27;s utterance or by collaborative completion of A&#x27;s utterance.</td></tr><tr><td>Display:</td><td>B displays verbatim all or part of A&#x27;s presentation.</td></tr></table>

Examples of these kind of grounding occur in the travel agent conversation. We can ground by explicitly saying “OK”, as the agent does in A<sub>8</sub> or A<sub>10</sub>. Or we can ground by repeating what the other person says; in utterance A<sub>2</sub> the agent repeats “in May”, demonstrating her understanding to the client. Or notice that when the client answers a question, the agent begins the next question with “And”. The “And” implies that the new question is ‘in addition’ to the old question, again indicating to the client that the agent has successfully understood the answer to the last question.

This particular fragment doesn’t have an example of an acknowledgment, but there’s an example in another fragment:

C: He wants to fly from Boston to Baltimore

A: Uh huh

The word uh-huh here is a continuer, also often called an acknowledgment token or a backchannel. A continuer is a (short) optional utterance that acknowledges the content of the utterance of the other and that doesn’t require an acknowledgment by the other (Yngve, 1970; Jefferson, 1984; Schegloff, 1982; Ward and Tsukahara, 2000).

## 26.1.4 Subdialogues and Dialogue Structure

Conversations have structure. Consider, for example, the local structure between speech acts discussed in the field of conversation analysis (Sacks et al., 1974). QUESTIONS set up an expectation for an ANSWER. PROPOSALS are followed by ACCEPTANCE (or REJECTION). COMPLIMENTS (“Nice jacket!”) often give rise to DOWNPLAYERS (“Oh, this old thing?”). These pairs, called adjacency pairs, are composed of a first pair part and a second pair part (Schegloff, 1968), and these expectations can help systems decide what actions to take.

However, dialogue acts aren’t always followed immediately by their second pair part. The two parts can be separated by a side sequence (Jefferson 1972) or subdialogue. For example utterances $\mathrm { C } _ { 1 7 }$ to A<sub>20</sub> constitute a correction subdialogue (Litman 1985, Litman and Allen 1987, Chu-Carroll and Carberry 1998):

C : #Act. . . actually#, what day of the week is the 15th?

A<sub>18</sub>: It’s a Friday.

C<sub>19</sub>: Uh hmm. I would consider staying there an extra day til Sunday.

A<sub>20</sub>: OK. . . OK. On Sunday I have . . .

The question in $\mathrm { C } _ { 1 7 }$ interrupts the prior discourse, in which the agent was looking for a May 15 return flight. The agent must answer the question and also realize that ‘’I would consider staying...til Sunday” means that the client would probably like to change their plan, and now go back to finding return flights, but for the 17th.

Another side sequence is the clarification question, which can form a subdialogue between a REQUEST and a RESPONSE. This is especially common in dialogue systems where speech recognition errors causes the system to have to ask for clarifications or repetitions like the following:

User: What do you have going to UNKNOWN WORD on the 5th?

System: Let’s see, going where on the 5th?

User: Going to Hong Kong.

System: OK, here are some flights...

In addition to side-sequences, questions often have presequences, like the following example where a user starts with a question about the system’s capabilities (“Can you make train reservations”) before making a request.

User: Can you make train reservations?

System: Yes I can.

User: Great, I’d like to reserve a seat on the 4pm train to New York.

## 26.1.5 Initiative

Sometimes a conversation is completely controlled by one participant. For example a reporter interviewing a chef might ask questions, and the chef responds. We say that the reporter in this case has the conversational initiative (Carbonell, 1970; Nickerson, 1976). In normal human-human dialogue, however, it’s more common for initiative to shift back and forth between the participants, as they sometimes answer questions, sometimes ask them, sometimes take the conversations in new directions, sometimes not. You may ask me a question, and then I respond asking you to clarify something you said, which leads the conversation in all sorts of ways. We call such interactions mixed initiative (Carbonell, 1970).

Full mixed initiative, while the norm for human-human conversations, can be difficult for dialogue systems. The most primitive dialogue systems tend to use system-initiative, where the system asks a question and the user can’t do anything until they answer it, or user-initiative like simple search engines, where the user specifies a query and the system passively responds. Even modern large language model-based dialogue systems, which come much closer to using full mixed initiative, often don’t have completely natural initiative switching. Getting this right is an important goal for modern systems.

## 26.1.6 Inference and Implicature

Inference is also important in dialogue understanding. Consider the client’s response C<sub>3</sub>, repeated here:

A<sub>2</sub>: And, what day in May did you want to travel?

C<sub>3</sub>: OK uh I need to be there for a meeting that’s from the 12th to the 15th.

Notice that the client does not in fact answer the agent’s question. The client merely mentions a meeting at a certain time. What is it that licenses the agent to infer that the client is mentioning this meeting so as to inform the agent of the travel dates?

The speaker seems to expect the hearer to draw certain inferences; in other words, the speaker is communicating more information than seems to be present in the uttered words. This kind of example was pointed out by Grice (1975, 1978) as part of his theory of conversational implicature. Implicature means a particular class of licensed inferences. Grice proposed that what enables hearers to draw these inferences is that conversation is guided by a set of maxims, general heuristics that play a guiding role in the interpretation of conversational utterances. One such maxim is the maxim of relevance which says that speakers attempt to be relevant, they don’t just utter random speech acts. When the client mentions a meeting on the 12th, the agent reasons ‘There must be some relevance for mentioning this meeting. What could it be?’. The agent knows that one precondition for having a meeting (at least before Web conferencing) is being at the place where the meeting is held, and therefore that maybe the meeting is a reason for the travel, and if so, then since people like to arrive the day before a meeting, the agent should infer that the flight should be on the 11th.

These subtle characteristics of human conversations (turns, speech acts, grounding, dialogue structure, initiative, and implicature) are among the reasons it is difficult to build dialogue systems that can carry on natural conversations with humans. Many of these challenges are active areas of dialogue systems research.

## 26.2 Dialog Acts and Corpora

The ideas of speech acts and grounding are combined in a single kind of action called a dialogue act, a tag which represents the interactive function of the sentence being tagged.

Dialog acts can be used to analyze human-human conversation or human-LLM conversation. Both the nature of the participants and the type of dialogue (task-based or not task-based) influence the development of dialogue act tagsets.

Figure 26.2 shows a domain-specific tagset for the task of two people scheduling meetings. It has tags specific to the domain of scheduling, such as SUGGEST, used for the proposal of a particular date to meet, and ACCEPT and REJECT, used for acceptance or rejection of a proposal for a date, but also tags that have a more general function, like CLARIFY, used to request a user to clarify an ambiguous proposal.

Figure 26.3 shows a tagset for a restaurant recommendation system, and Fig. 26.4 shows these tags labeling a sample dialogue from the HIS system (Young et al., 2010). This example also shows the content of each dialogue acts, which are the slot fillers being communicated.

There are a number of more general and domain-independent dialogue act tagsets. In the DAMSL (Dialogue Act Markup in Several Layers) architecture inspired by the work of Clark and Schaefer (1989), Allwood et al. (1992), and (Allwood, 1995), each utterance is tagged for two types of functions, forward-looking functions like speech act functions, and backward-looking functions, like grounding and answering, which “look back” to the interlocutor’s previous utterance (Allen and Core, 1997; Walker et al., 1996; Carletta et al., 1997; Core et al., 1999).

<table><tr><td>Tag</td><td>Example</td></tr><tr><td>THANK</td><td>Thanks</td></tr><tr><td>GREET</td><td>Hello Dan</td></tr><tr><td>INTRODUCE</td><td>It&#x27;s me again</td></tr><tr><td>BYE</td><td>Alright bye</td></tr><tr><td>REQUEST-COMMENT</td><td>How does that look?</td></tr><tr><td>SUGGEST</td><td>from thirteenth through seventeenth June</td></tr><tr><td>REJECT</td><td>No Friday I&#x27;m booked all day</td></tr><tr><td>ACCEPT</td><td>Saturday sounds fine</td></tr><tr><td>REQUEST-SUGGEST</td><td>What is a good day of the week for you?</td></tr><tr><td>INIT</td><td>I wanted to make an appointment with you</td></tr><tr><td>GIVE_REASON</td><td>Because I have meetings all afternoon</td></tr><tr><td>FEEDBACK</td><td>Okay</td></tr><tr><td>DELIBERATE</td><td>Let me check my calendar here</td></tr><tr><td>CONFIRM</td><td>Okay, that would be wonderful</td></tr><tr><td>CLARIFY</td><td>Okay, do you mean Tuesday the 23rd?</td></tr><tr><td>DIGRESS</td><td>[we could meet for lunch] and eat lots of ice cream</td></tr><tr><td>MOTIVATE</td><td>We should go to visit our subsidiary in Munich</td></tr><tr><td>GARBAGE</td><td>Oops, I-</td></tr></table>

Figure 26.2 The 18 high-level dialogue acts for a meeting scheduling task, from the Verbmobil-1 system (Jekat et al., 1995).

<table><tr><td>Tag</td><td>Sys</td><td>User</td><td>Description</td></tr><tr><td>HELLO(a=x,b=y,...)</td><td>√</td><td>√</td><td>Open a dialogue and give info a=x,b=y,...</td></tr><tr><td>INFORM(a=x,b=y,...)</td><td>√</td><td>√</td><td>Give info a=x,b=y,...</td></tr><tr><td>REQUEST(a,b=x,...)</td><td>√</td><td>√</td><td>Request value for a given b=x,...</td></tr><tr><td>REQALTS(a=x,...)</td><td> $\chi$ </td><td>√</td><td>Request alternative with a=x,...</td></tr><tr><td>CONFIRM(a=x,b=y,...)</td><td>√</td><td>√</td><td>Explicitly confirm a=x,b=y,...</td></tr><tr><td>CONFREQ(a=x,...,d)</td><td>√</td><td> $\chi$ </td><td>Implicitly confirm a=x,... and request value of d</td></tr><tr><td>SELECT(a=x,a=y)</td><td>√</td><td> $\chi$ </td><td>Implicitly confirm a=x,... and request value of d</td></tr><tr><td>AFFIRM(a=x,b=y,...)</td><td>√</td><td>√</td><td>Affirm and give further info a=x,b=y,...</td></tr><tr><td>NEGATE(a=x)</td><td> $\chi$ </td><td>√</td><td>Negate and give corrected value a=x</td></tr><tr><td>DENY(a=x)</td><td> $\chi$ </td><td>√</td><td>Deny that a=x</td></tr><tr><td>BYE()</td><td>√</td><td>√</td><td>Close a dialogue</td></tr></table>

Figure 26.3 Dialogue acts used by the HIS restaurant recommendation system of Young et al. (2010). The Sys and User columns indicate which acts are valid as system outputs and user inputs, respectively.

<table><tr><td>Utterance</td><td>Dialogue act</td></tr><tr><td>U: Hi, I am looking for somewhere to eat.</td><td>hello(task = find,type=restaurant)</td></tr><tr><td>S: You are looking for a restaurant. What type of food do you like?</td><td>confreq(type = restaurant, food)</td></tr><tr><td>U: I&#x27;d like an Italian somewhere near the museum.</td><td>inform(food = Italian, near=museum)</td></tr><tr><td>S: Roma is a nice Italian restaurant near the museum.</td><td>inform(name = &quot;Roma&quot;, type = restaurant, food = Italian, near = museum)</td></tr><tr><td>U: Is it reasonably priced?</td><td>confirm(pricerange = moderate)</td></tr><tr><td>S: Yes, Roma is in the moderate price range.</td><td>affirm(name = &quot;Roma&quot;, pricerange = moderate)</td></tr><tr><td>U: What is the phone number?</td><td>request(phone)</td></tr><tr><td>S: The number of Roma is 385456.</td><td>inform(name = &quot;Roma&quot;, phone = &quot;385456&quot;)</td></tr><tr><td>U: Ok, thank you goodbye.</td><td>bye()</td></tr></table>

Figure 26.4 A sample dialogue from the HIS System of Young et al. (2010) using the dialogue acts in Fig. 26.3.

<table><tr><td colspan="2">Forward Looking Function</td></tr><tr><td>STATEMENT</td><td>a claim made by the speaker</td></tr><tr><td>INFO-REQUEST</td><td>a question by the speaker</td></tr><tr><td>CHECK</td><td rowspan="2">a question for confirming information (=Bach&#x27;s directives)</td></tr><tr><td>INFLUENCE-ON-ADDRESSEE</td></tr><tr><td>OPEN-OPTION</td><td>a weak suggestion or listing of options</td></tr><tr><td>ACTION-DIRECTIVE</td><td>an actual command</td></tr><tr><td>INFLUENCE-ON-SPEAKER</td><td>(=Austin&#x27;s commissives)</td></tr><tr><td>OFFER</td><td>speaker offers to do something,(subject to confirmation)</td></tr><tr><td>COMMIT</td><td>speaker is committed to doing something</td></tr><tr><td>CONVENTIONAL</td><td>other</td></tr><tr><td>OPENING</td><td>greetings</td></tr><tr><td>CLOSING</td><td>farewells</td></tr><tr><td>THANKING</td><td>thanking and responding to thanks</td></tr></table>

The backward looking function of DAMSL focuses on the relationship of an utterance to previous utterances by the other speaker. These include accepting and rejecting proposals (since DAMSL is focused on task-oriented dialogue), and grounding and repair acts:

<table><tr><td colspan="2">Backward Looking Function</td></tr><tr><td>AGREEMENT</td><td>speaker&#x27;s response to previous proposal</td></tr><tr><td>ACCEPT</td><td>accepting the proposal</td></tr><tr><td>ACCEPT-PART</td><td>accepting some part of the proposal</td></tr><tr><td>MAYBE</td><td>neither accepting nor rejecting the proposal</td></tr><tr><td>REJECT-PART</td><td>rejecting some part of the proposal</td></tr><tr><td>REJECT</td><td>rejecting the proposal</td></tr><tr><td>HOLD</td><td>putting off response, usually via subdialogue</td></tr><tr><td>ANSWER</td><td>answering a question</td></tr><tr><td>UNDERSTANDING</td><td>whether speaker understood previous</td></tr><tr><td>SIGNAL-NON-UNDER.</td><td>speaker didn&#x27;t understand</td></tr><tr><td>SIGNAL-UNDER.</td><td>speaker did understand</td></tr><tr><td>ACK</td><td>demonstrated via continuer or assessment</td></tr><tr><td>REPEAT-REPHRASE</td><td>demonstrated via repetition or reformulation</td></tr><tr><td>COMPLETION</td><td>demonstrated via collaborative completion</td></tr></table>

Fig. 26.5 shows a labeling of parts of our sample conversation using versions of

the DAMSL Forward and Backward tags.

<table><tr><td>[assert]</td><td> $C_1$ : ...I need to travel in May.</td></tr><tr><td>[info-req,ack]</td><td> $A_2$ : And, what day in May did you want to travel?</td></tr><tr><td>[assert, answer]</td><td> $C_3$ : OK uh I need to be there for a meeting that&#x27;s from the 12th to the 15th.</td></tr><tr><td>[info-req,ack]</td><td> $A_4$ : And you&#x27;re flying into what city?</td></tr><tr><td>[assert,answer]</td><td> $C_5$ : Seattle.</td></tr><tr><td>[info-req,ack]</td><td> $A_6$ : And what time would you like to leave Pittsburgh?</td></tr><tr><td>[check,hold]</td><td> $C_7$ : Uh hmm I don&#x27;t think there&#x27;s many options for non-stop.</td></tr><tr><td>[accept,ack]</td><td> $A_7$ : Right.</td></tr><tr><td>[assert]</td><td>There&#x27;s three non-stops today.</td></tr><tr><td>[info-req]</td><td> $C_8$ : What are they?</td></tr><tr><td>[assert, open-option]</td><td> $A_9$ : The first one departs PGH at 10:00am arrives Seattle at 12:05 their time. The second flight departs PGH at 5:55pm, arrives Seattle at 8pm. And the last flight departs PGH at 8:15pm arrives Seattle at 10:28pm.</td></tr><tr><td>[accept,ack]</td><td> $C_{10}$ : OK I&#x27;ll take the 5ish flight on the night before on the 11th.</td></tr><tr><td>[check,ack]</td><td> $A_{11}$ : On the 11th?</td></tr><tr><td>[assert,ack]</td><td>OK. Departing at 5:55pm arrives Seattle at 8pm, U.S. Air flight 115.</td></tr><tr><td>[ack]</td><td> $C_{12}$ : OK.</td></tr></table>

Figure 26.5 A potential DAMSL labeling of the beginning of the conversational fragment in Fig. 26.1.