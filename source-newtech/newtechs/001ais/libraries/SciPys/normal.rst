常用
####


安装::

    $ pip install numpy scipy matplotlib ipython jupyter pandas sympy nose

    $ apt-get install python-numpy python-scipy python-matplotlib ipython ipython-notebook python-pandas python-sympy python-nose

    $ brew install numpy scipy ipython jupyter


使用::

    from scipy import optimize, special
    from numpy import *
    from pylab import *
     
    x = arange(0,10,0.01)
     
    for k in arange(0.5,5.5):
         y = special.jv(k,x)
         plot(x,y)
         f = lambda x: -special.jv(k,x)
         x_max = optimize.fminbound(f,0,6)
         plot([x_max], [special.jv(k,x_max)],'ro')

    title('Different Bessel functions and their local maxima')
    show()






