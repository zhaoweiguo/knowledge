pylab子包
#########
  
.. note:: pylab combines pyplot with numpy into a single namespace. This is convenient for interactive work, but for programming it is recommended that the namespaces be kept separate). 即: pylab 结合了 pyplot 和 numpy，对交互式使用来说比较方便，既可以画图又可以进行简单的计算。可在测试环境中测试用，但不建议在实际项目中使用


实例::

    import pylab
    my_list=[]
    for counter in range(10):
        my_list.append(counter*2)
    print my_list
    print len(my_list)
     
    #now plot the list
     
    pylab.plot(my_list)
    pylab.show()








