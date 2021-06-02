数学相关
########

添加Sphinx支持
==============

.. note:: 修改 conf.py 中的extensions项。推荐使用mathjax的支持方式，Sphinx会自动从CDN中导入MathJax



1. `sphinx.ext.pngmath <http://savannah.nongnu.org/projects/dvipng/>`_ ::

    将数学渲染为图像:
    通过 LaTeX 和 dvipng 将数学公式渲染成png格式显示，需要这两个程序支持才可以正常工作


2. `sphinx.ext.mathjax <http://www.mathjax.org/>`_ ::

    通过javascript呈现数学:
    通过 MathJax 将数学公式渲染在页面上显示

3. `sphinx.ext.jsmath <http://www.math.union.edu/~dpvc/jsmath/>`_ ::
   
    通过javascript呈现数学:
    这个扩展和Mathjax扩展一样工作，但使用的是旧的包 jsMath

常用表达式
==========

* \begin{pmatrix} \end{pmatrix} ： 矩阵
* a_{11}：a11（下标）
* & ： 矩阵中的元素
* cdots、\vdots、\ddots：横三点，竖三点、斜的三点
* \\ ：换行
* \left(、\right)：左右括号
* ^：次方
* {\rm A}：用以描述一种运算，保证字体

插入公式::

    如果是在文本中插入公式，则用$...$
    如果公式自成段落，则使用$$...$$

多行公式::

    \begin{equation}\begin{split} 
    end{split}\end{equation}

\\ 符号表示换行，再使用&符号表示要对齐的位置，例子如下::

    \begin{equation}\begin{split}
    H(Y|X)&=\sum_{x\in X} p(x)H(Y|X)\\
    &=-\sum_{x\in X} p(x)\sum_{y\in Y}p(y|x)\log p(y|x)\\
    &=-\sum_{x\in X} \sum_{y\in Y}p(y,x)\log p(y|x)
    \end{split}\end{equation}

字体::

    使用\mathbb或\Bbb来显示黑板粗体字，ℕℚℝℤNQRZ
    使用\mathbf来显示粗体字，ABCDabcdABCDabcd
    使用\mathtt来显示打印式字体，𝙰𝙱𝙲𝙳𝚊𝚋𝚌𝚍ABCDabcd
    使用\mathrm来显示罗马字体，ABCDabcdABCDabcd
    使用\mathcal来显示手写字体，abcdABCDabcd
    使用\mathscr来显示剧本字体，𝒜ℬ𝒞𝒟𝒶𝒷𝒸𝒹ABCDabcd
    使用\mathfrak来显示Fraktur字母(一种旧的德国字体)，𝔄𝔅ℭ𝔇𝔞𝔟𝔠𝔡

分组::

    注意这儿不同:
    x^10
    x^{10}






展示数学公式
============

行内展示语法::

    :math:`\sum\limits_{k=1}^\infty \frac{1}{2^k} = 1`

:math:`\sum\limits_{k=1}^\infty \frac{1}{2^k} = 1`


多行展示语法::

    .. math::

       (a + b)^2  &=  (a + b)(a + b) \\
                  &=  a^2 + 2ab + b^2

.. math::

   (a + b)^2  &=  (a + b)(a + b) \\
              &=  a^2 + 2ab + b^2


实例
====

.. math::

  (a + b)^2 = a^2 + 2ab + b^2
  (a - b)^2 = a^2 - 2ab + b^2

.. math::

  \begin{array}{ll}
  r_t = \mathrm{sigmoid}(W_{ir} x_t + b_{ir} + W_{hr} h_{(t-1)} + b_{hr}) \\
  z_t = \mathrm{sigmoid}(W_{iz} x_t + b_{iz} + W_{hz} h_{(t-1)} + b_{hz}) \\
  n_t = \tanh(W_{in} x_t + b_{in} + r_t * (W_{hn} h_{(t-1)}+ b_{hn})) \\
  h_t = (1 - z_t) * n_t + z_t * h_{(t-1)} \\
  \end{array}

:math:`$$x = {-b \pm \sqrt{b^2-4ac} \over 2a}.$$`

:math:`\frac{1}{\sqrt{x^2 + 1}}`

:math:`\begin{array}{cc} a & b \\ c & d \end{array}`


:math:`\min\limits_{w} \frac{1}{2^k} = 1`


* 矩阵: :math:`\begin{pmatrix} \end{pmatrix}`
* 矩阵2: 

.. math::

  \displaystyle \begin{pmatrix} a &b\\ c &d \end{pmatrix}^{-1} = \frac{1}{ad-bc} \begin{pmatrix}\phantom{-}d & -b \\ -c & \phantom{-}a \end{pmatrix}


* 左右括号: :math:`\left( {\rm A}^{\rm T}\right)^{\rm T} = {\rm A}`
* :math:`{\rm A}^p = {\rm S} \Lambda^p {\rm S}^{-1}`

.. math::

  \text{A} = \begin{pmatrix} a_{11} & a_{12} & \cdots & a_{1n} \\ a_{21} & a_{22} & \cdots & a_{2n} \\ \vdots & \vdots & \ddots & \vdots \\ a_{m1} & a_{m2} & \cdots & a_{mn} \end{pmatrix}













