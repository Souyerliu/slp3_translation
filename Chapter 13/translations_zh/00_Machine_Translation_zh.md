# 机器翻译

[原始 PDF](../../MinerU-Skill/ed3book_aug26_3a047d/split_pdf/13_Machine_Translation.pdf)

> “我想说你们族人的方言。说话若不能让人理解，就毫无用处。”
>
> Zora Neale Hurston，*Moses, Man of the Mountain*，1939，第 121 页

本章介绍**机器翻译**（machine translation, MT），即使用计算机把一种语言翻译成另一种语言。

当然，完整意义上的翻译——例如文学或诗歌翻译——是一项困难、迷人而极具人性的事业，其丰富程度不亚于人类创造活动的任何其他领域。

因此，当前形式的机器翻译主要聚焦于若干非常实用的任务。今天最常见的用途或许是信息获取：我们可能想翻译网上的一些说明，例如喜爱菜肴的食谱或家具组装步骤；也可能想阅读报纸文章，或从其他语言的维基百科、政府网页等在线资源获取信息。

用于信息获取的 MT 可能是 NLP 技术最常见的用途之一；仅 Google 翻译每天就在 100 多种语言之间翻译数千亿词：

> En un recipiente hondo, mezclar el jugo de naranja con el azúcar, jengibre, y nuez moscada.
>
> 在一个深碗中，将橙汁与糖、姜和肉豆蔻混合。

改进机器翻译因而有助于缩小信息获取中所谓的**数字鸿沟**：英语和富裕国家所用的其他语言拥有多得多的信息。英语网络搜索返回的信息远多于其他语言，维基百科等在线资源的英语版本和其他高资源语言版本也大得多。高质量翻译可以帮助低资源语言的使用者获取这些信息。

机器翻译的另一常见用途是协助人工译者。MT 系统通常先生成翻译草稿，再由人工译者在**译后编辑**阶段修订。这项任务常称为**计算机辅助翻译**（computer-aided translation, CAT）。CAT 通常是**本地化**（localization）的一部分，即让内容或产品适应特定语言社群的任务。

最后，MT 较新的应用是满足即时人际交流需求，包括**增量翻译**——在整句尚未结束时即时翻译语音，常用于同声传译；还包括以图像为中心的翻译，例如对手机相机图像中的文本进行 OCR，并将结果输入 MT 系统，以翻译菜单或路牌。

MT 的标准算法是**编码器—解码器模型**。第 9 章曾简要提到，编码器—解码器或序列到序列模型用于把输入序列映射为整个输入序列之复杂函数的输出序列，例如机器翻译或语音识别。机器翻译中，目标语言词语与源语言词语的数量和顺序未必一致。考虑把下面虚构的英语句子翻译成日语：

(13.1) 英语：He wrote a letter to a friend

日语：tomodachi ni tegami-o kaita

朋友　向　信　写了

两种语言中的句子成分位置差异很大。英语动词位于句中，日语动词 kaita 则位于句末；日语句子不要求出现代词 he，英语却需要。

语言差异可能相当复杂。下面这个联合国真实例句中，请注意中文句子（我们给出了逐词英语释义）与人工译出的英文对应句之间的许多变化：

(13.2) 大会/General Assembly 在/on 1982年/1982 12月/December 10日/10 通过了/adopted 第37号/37th 决议/resolution，核准了/approved 第二次/second 探索/exploration 及/and 和平/peaceful 利用/using 外层空间/outer space 会议/conference 的/of 各项/various 建议/suggestions。

> On 10 December 1982, the General Assembly adopted resolution 37 in which it endorsed the recommendations of the Second United Nations Conference on the Exploration and Peaceful Uses of Outer Space.

英语与中文在许多方面不同。例如，整体语序差异显著：中文名词短语的顺序直译为“peaceful using outer space conference of suggestions”，英语则是“suggestions of the ... conference on peaceful use of outer space”；日期顺序等局部语序也不同。英语在许多中文无需冠词的地方要求使用 the，还增添了中文中不必出现的“in which”和“it”等细节。中文名词不以语法形式标记复数，而英语 recommendations 带有复数“-s”，所以中文必须用修饰语“各项”来表明建议不止一项。英语还要求部分词语大写。编码器—解码器网络非常擅长处理这类复杂的序列映射。

下一节首先讨论语言如何变化的语言学背景，以及这些差异对 MT 任务的影响。随后概述标准算法，说明输入词元化、建立平行句训练语料库等细节，进一步介绍编码器—解码器网络的底层机制，最后讨论 MT 评估并介绍简单的 chrF 指标。
