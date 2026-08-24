# 练习

**5.1** 使用图 5.2 的共现计数，并且只使用 pie 和 result 两个维度，计算 $\cos(\text{cherry},\text{strawberry})$ 和 $\cos(\text{cherry},\text{digital})$。哪一对更相似？结果符合你对这些词义的直觉吗？

**5.2** 证明余弦相似度对缩放不变：对任意正常数 $c$，$\cos(c\mathbf v,\mathbf w)=\cos(\mathbf v,\mathbf w)$。结合第 5.4 节关于频率和向量长度的讨论，为什么这是词相似度指标所希望具有的性质？

**5.3** 对式 5.21 的损失分别关于 $\mathbf c_{pos}$、$\mathbf c_{neg}$ 和 $\mathbf w$ 求导，推导式 5.22—5.24 中的 SGNS 梯度。可以使用 $\frac{d\sigma(z)}{dz}=\sigma(z)(1-\sigma(z))$ 以及 $\frac{d(\mathbf c\cdot\mathbf w)}{d\mathbf w}=\mathbf c$。
