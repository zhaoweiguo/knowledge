Graphviz实践
####################

实例1:
''''''''

.. literalinclude:: /files/graphvizs/example1.dot


.. figure:: /files/graphvizs/example1.png
   :width: 50%


实例2
''''''''


.. literalinclude:: /files/graphvizs/example2.dot


.. figure:: /files/graphvizs/example2.png
   :width: 50%



实例3
''''''''


.. literalinclude:: /files/graphvizs/example3.dot


.. figure:: /files/graphvizs/example3.png
   :width: 50%

增加一行::

      rankdir=LR


.. figure:: /files/graphvizs/example3_1.png
   :width: 50%

给结点struct1增加shape: Mrecord::

  struct1 [shape=Mrecord, label="<f0> left|<f1> mid&#92; dle|<f2> right"];


.. figure:: /files/graphvizs/example3_2.png
   :width: 50%



实例4
''''''''


.. literalinclude:: /files/graphvizs/example4.dot


.. figure:: /files/graphvizs/example4.png
   :width: 80%











