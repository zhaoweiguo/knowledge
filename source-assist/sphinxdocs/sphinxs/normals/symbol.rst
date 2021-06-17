符号
####

关系比较符号::

    符号     表示
    <       \lt
    >       \gt
    ≤       \le
    ≥       \ge
    ≠       \neq

运算符号::

    运算符     表示
    +         +
    −         -
    ×         \times
    ÷         \div
    ±         \pm
    ∓         mp
    ⋅         \cdot

集合符号::

    符号     表示
    ∪∪      \cup
    ∩∩      \cap
    ∖∖      \setminus
    ⊂⊂      \subset
    ⊆⊆      \subseteq
    ⊊⊊      \subsetneq
    ⊃⊃      \supset
    ∈∈      \in
    ∉∉      \notin
    ∅∅      \emptyset
    ∅∅      \varnothing

箭头符号::

    符号   表示
    →     \to
    →     \rightarrow
    ←     \leftarrow
    ⇒     \Rightarrow
    ⇐     \Leftarrow
    ↦     \mapsto
    ⇑     \Uparrow
    ↑     \uparrow
    ⇓     \Downarrow
    ↓     \downarrow

特殊符号::

    符号        表示
    ∞           \infty
    ∇           \nabla
    ∂           \partial
    ≈           \approx
    ∼           \sim
    ≃           \simeq
    ≅           \cong
    ≡           \equiv
    ≺           \prec
    (n+1   2k)    {n+1 \choose 2k} 或 \binom{n+1}{2k}
    ∧           \land
    ∨           \lor
    ¬           \lnot
    ∀           \forall
    ∃           \exists
    ⊤           \top
    ⊥           \bot
    ⊢           \vdash
    ⊨           \vDash
    ⋆           \star
    ∗           \ast
    ⊕           \oplus
    ∘           \circ
    ∙           \bullet

括号::

    符号      表示
    ()()      ()
    [][]      []
    {}{}      \{ \}
    ⟨⟨        `\langle
    ⟩⟩        `\rangle
    ⌈x⌉⌈x⌉    \lceil x \rceil
    ⌊x⌋⌊x⌋    \lfloor$ x \rfloor

求和、积分、极限与连乘::

    运算符     表示     示例  表示
    ∑        \sum     \sum_{k=-\infty}^{\infty}X(k\Omega)
    ∫        \int     \int_{-T/ 2}^{T/2}x(t)dt
    ∬        \iint      
    ∏        \prod    \prod_{i=1}^{n}i
    lim      \lim     \lim\limits_{n \to \infty}

.. image:: /images/sphinxdocs/symbol.png


矩阵::

    // 每一行末用\\结束，用&分隔矩阵元素
    $$
      \begin{matrix}
      1 & 0 & 0 \\
      0 & 1 & 0 \\
      0 & 0 & 1 \\
      \end{matrix}
    $$

    实例2:
    $$
      \begin{pmatrix}
      1 & a_1 & a_1^2 & \cdots & a_1^n\\
      1 & a_2 & a_2^2 & \cdots & a_2^n \\
      \vdots & \vdots & \ddots & \vdots \\  
      1 & a_n & a_n^2 & \cdots & a_n^n  \\
      \end{pmatrix}
    $$

绝对值和模::

    绝对值可以使用\lvert x\rvert 表示|x|
    对于向量的模长，则可以使用\lVert v\rVert ，‖v‖ 

高亮-实例1::

    为了显著表示某等式，可以使用\bbox:
    $$ \bbox[yellow]
    {
    e^x=\lim_{n\to\infty} \left( 1+\frac{x}{n} \right)^n
    \qquad (1)
    }
    $$

.. math::

  $$ \bbox[yellow]
  {
  e^x=\lim_{n\to\infty} \left( 1+\frac{x}{n} \right)^n
  \qquad (1)
  }
  $$

高亮-实例1::

    $$ \bbox[border:2px solid red]
    {
    e^x=\lim_{n\to\infty} \left( 1+\frac{x}{n} \right)^n
    \qquad (2) 
    }
    $$


.. math::

  $$ \bbox[border:2px solid red]
  {
  e^x=\lim_{n\to\infty} \left( 1+\frac{x}{n} \right)^n
  \qquad (2) 
  }
  $$








