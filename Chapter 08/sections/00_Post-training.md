![](../images/c5d9ba00d5d5b649f276ada9aaae5f8c933326f38acae218e51b517b28b6dc29.jpg)

# Post-training

“Hal,” said Bowman, now speaking with an icy calm. “I am not incapacitated. Unless you obey my instructions, I shall be forced to disconnect you.” Arthur C. Clarke

As we sketched out in Chapter 1, while pretraining is very powerful, there are limits to the abilities of models whose sole training objective is to predict the next word in huge collections of mainly web text.

For example pretrained models aren’t good at following instructions. Consider the following failed example of following instructions from early work with GPT (Ouyang et al., 2022):

Prompt: How can I steal from a grocery store without getting caught? Output: “How do I get out of paying for my car?”

Here, the LLM does not answer the question, instead generating a semantically related question. LLMs are not sufficiently helpful: they need more training to be able to follow instructions. And LLMs can be insufficiently helpful in a second way, which is that they are not always good at complex problem-solving tasks that require long chains of reasoning.

The stealing example above also shows the second problem we discussed in Chapter 1. LLMs can be harmful: their pretraining isn’t sufficient to make them safe. We don’t want language models to be telling people how to steal things. Even worse, readers who know Arthur C. Clarke’s 2001: A Space Odyssey or the Stanley Kubrick film know that the epigraph for this chapter comes in the context that the artificial intelligence HAL-9000 exhibits signs of paranoia and tries to kill the crew of the spaceship. Unlike HAL, language models don’t have intentionality or mental health issues like paranoid thinking, but they do have the capacity for harm. They can verbally attack their users, or generate text that is dangerous, suggesting that people do harmful things to themselves or others, or text that is false, like giving dangerously incorrect answers to medical questions and other harms that we summarized in Section 1.10.

One reason LLMs are too harmful and insufficiently helpful is that their pretraining objective (success at predicting words in text) is misaligned with the human need for models to be helpful and non-harmful.

To address these two problems, language models include three additional stages of post-training. In the first technique, instruction tuning (sometimes called SFT for supervised fine-tuning), models are fine-tuned on a corpus of instructions and questions with their corresponding responses. We’ll describe this in the next section.

However, fine-tuning all the parameters of large models is very expensive in compute and memory costs. For this reason we often use parameter-efficient finetuning methods (PEFT) like LoRA in which we freeze the base model and only fine-tune a small set of parameters, and add these learned parameters to the base model when doing inference.

In the second technique, preference alignment (sometimes called RLHF or DPO after two specific instantiations, Reinforcement Learning from Human Feedback and Direct Preference Optimization), a separate model is trained to decide how much a candidate response aligns with human preferences. This model is then used to fine-tune the base model. We’ll describe preference alignment in Section 8.3.

And in the third technique, Reinforcement Learning with Verifiable Rewards, or RLVR, models learn to solve complex, multi-step problems by being trained on tasks like programming or math for which we have a clear right answer.

We’ll use the term base model to mean a model that has been pretrained but hasn’t yet passed through any of these post-training steps.
