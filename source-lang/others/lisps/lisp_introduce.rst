.. _lisp_introduce:

lisp入门
############

基本
========
::

    (+ 2 5)     ;返回7
    '(+ 2 5)    ;返回(+ 2 5)
    (list 1 2 3);   ;;列出1 2 3
    '(1 2 3)  ;同上

    (car '(a b c));     ;;列出集合中第一个元素
    (first '(a b c));   ;; 同上
    (cdr '(1 2 3));     ;; 列出第一个元素外剩余的元素
    (rest '(1 2 3));    ;;同上

    (cons 'lions '(tigers bears));      ;;用来把lions元素和(tigers bears)合并成一个list
    (list 'lions 'tigers 'bears 'zzzz); ;;用来把元素合并成一个list
    (append '(lions zzz) '(tigers bears) '(ccc));       ;;把元素合并成list

    (cons '2 nil);  ;; nil是空，2与空合并，还是2
    (nthcdr 2 '(pine fir oak maple));   ;;重复执行rest 2 次
    (nth 1 '("one" "two" "three"));     ;;重复执行first 2 次.

    (setq animals '(antelope giraffe lion tiger));
    (setcar animals 'zzzz);               ;;setcar更改list中第一个元素

    (setq animals '(antelope giraffe lion tiger));
    (setcdr animals '(111 222));          ;;setcdr更改list中的rest部分

    ;; 循环
    (setq animals '(gazelle giraffe lion tiger zzz));
    (defun print-elements-of-list (list)
      (while list
        (print (first list))
        (setq list (rest list))
      ) 
    );
    (print-elements-of-list animals);

    ;; 给变量赋值
    (set 'flowers '(rose violet daisy buttercup));      ;; 把集合赋给flowers这个变量
    (setq flowers '(rose violet daisy buttercup));      ;; 把集合赋给flowers这个变量

    (if (> 2 5) 0 1);    ;;若2>5，则返回0，否则返回1

    ;;s表达式上面的所有例子中括号套括号的表达式就叫s表达式

函数
========

defun 是用于定义自定义函数的函数。第一个参数是函数名，第二个参数是参数列表，第三个参数是希望执行的代码

实例::

    (defun my\_second (lst) (first (rest lst)));
    运行:
    (my_second '(1 2 3));

    (defun my\_max (x y) (if (> x y) x y));
    运行:
    (my_max 2 5); 返回5


递归
==========

lisp语言最适合于递归，下面的例子用递归实现集合之和::

    (defun total (x)  (if (null x)    0    (+ (first x) (total (rest x)))  ));
    (total '(1 2 3));
    ;; 返回6

高阶函数(lambda表达式)
==========================

::

    ((lambda (a b) (+ a b)) 101 102);
    ;;返回101+102=203
    ((lambda (arg) (+ arg 1)) 5);
    ;;返回5+1 = 6

    (setf total '(lambda (a b) (+ a b)));
    (total '(101 102));
    ;;返回101+102=203


宏
=======
::

    (defmacro times_two (x) (* 2 x));
    (times_two 2);
    ;;返回4

    (defmacro sum (x y) (+ x y));
    (sum 2 5);
    ;;返回7


数据可当作代码执行
========================

