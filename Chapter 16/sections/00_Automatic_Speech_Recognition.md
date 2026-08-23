16

# Automatic Speech Recognition

I KNOW not whether

I see your meaning: if I do, it lies

Upon the wordy wavelets of your voice,

Dim as an evening shadow in a brook,

Thomas Lovell Beddoes, 1851

Understanding spoken language, or at least transcribing the words into writing, is one of the earliest goals of computer language processing. In fact, speech processing

predates the computer by many decades! The first machine that recognized speech was a toy from the 1920s. “Radio Rex”, shown to the right, was a celluloid dog that moved (by means of a spring) when the spring was released by 500 Hz acoustic energy. Since 500 Hz is roughly the first formant of the vowel [eh] in “Rex”, Rex seemed to come when he was called (David, Jr. and Selfridge, 1962).

![](../images/cca972dbd0b42842945e1692148cb1371a8752003a340da5d92a549254549c13.jpg)

In modern times, we expect more of our automatic systems. The task of automatic speech recognition (ASR) is to map any waveform like this:

![](../images/b642c9017f66508a35cb1716a1d6f0a803699d8a61920523cf8cc5bf8baf3b05.jpg)

to the appropriate string of words:

## It’s time for lunch!

Automatic transcription of speech by any speaker in any environment is still far from solved, but ASR technology has matured to the point where it is now viable for many practical tasks. Speech is a natural interface for communicating with appliances, or with digital assistants or chatbots, especially on cellphones, where keyboards are less convenient. ASR is also useful for general transcription, for example for automatically generating captions for audio or video text (transcribing movies or videos or live discussions). Transcription is important in fields like law where dictation plays an important role. Finally, ASR is important as part of augmentative communication (interaction between computers and humans with some disability resulting in difficulties or inabilities in typing or audition). The blind Milton famously dictated Paradise Lost to his daughters, and Henry James dictated his later novels after a repetitive stress injury.

In the next sections we’ll introduce the various goals of the ASR task, describe how acoustic features are extracted, and introduce the convolutional neural net architecture which is commonly used as an initial layer in speech recognition tasks.

We’ll then introduce two families of methods for ASR. The first is the encoderdecoder paradigm, and we’ll introduce the baseline attention-based encoder decoder algorithm, sometimes called Listen Attend and Spell after an early implementation. We’ll also introduce a more advanced encoder-decoder system, OpenAI’s Whisper system (Radford et al., 2023) as well an open system based on the same architecture, OWSM (the Open Whisper-style Speech Model) (Peng et al., 2023). (These models have additional capabilities including translation, as we’ll discuss later). The second is the use of self-supervised speech models (sometimes called SSL for selfsupervised learning) like Wav2Vec2.0 or HuBERT, which are encoders that learn abstract representations of speech that can be used for ASR by pairing them with the CTC loss function for decoding.

We’ll conclude with the standard word error rate metric used to evaluate ASR.
