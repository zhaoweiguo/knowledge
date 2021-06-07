异常相关
=============


异常::

    # 处理异常:
    try:
        s = raw_input('输入 --> ')
    except EOFError:
        print '\n 产生EOF错误'
        sys.exit() # exit the program
    except:
        print '\n产生其他错误'

.. note:: Python 使用raise语句抛出一个指定的异常


引发异常::

    class ShortInputException(Exception):
        '''自定义的异常——ShortInputException.'''
        def __init__(self, length, atleast):
            Exception.__init__(self)
            self.length = length
            self.atleast = atleast

        try:
            s = raw_input('输入 --> ')
            if len(s) < 3:
                raise ShortInputException(len(s), 3)

        except EOFError:
            print('\nEOF错误产生?')
        except ShortInputException, x:
            print('ShortInputException: 输入长度为 %d, 规定至少为 %d' % (x.length, x.atleast))
        else:
            print('无错误产生.')

.. figure:: /images/languages/pythons/exception_class.png

   Python异常体系中的部分关系

Python 标准异常::

    BaseException：所有异常的 基类
    Exception：常规异常的 基类
    StandardError：所有的内建标准异常的基类

    1. ArithmeticError：所有数值计算异常的基类
    FloatingPointError：浮点计算异常
    OverflowError：数值运算超出最大限制
    ZeroDivisionError：除数为零
    AssertionError：断言语句（assert）失败
    AttributeError：尝试访问未知的对象属性

    2. EnvironmentError：操作系统异常的基类
    IOError：输入/输出操作失败
    OSError：操作系统产生的异常（例如打开一个不存在的文件）
    WindowsError：系统调用失败
    ImportError：导入模块失败的时候
    KeyboardInterrupt：用户中断执行

    3. EOFError：没有内建输入，到达EOF标记

    4. LookupError：无效数据查询的基类
    IndexError：索引超出序列的范围
    KeyError：字典中查找一个不存在的关键字
    MemoryError：内存溢出（可通过删除对象释放内存）
    NameError：尝试访问一个不存在的变量
    UnboundLocalError：访问未初始化的本地变量
    ReferenceError：弱引用试图访问已经垃圾回收了的对象
    RuntimeError：一般的运行时异常
    NotImplementedError：尚未实现的方法
    SyntaxError：语法错误导致的异常
    IndentationError：缩进错误导致的异常
    TabError：Tab和空格混用
    SystemError：一般的解释器系统异常
    TypeError：不同类型间的无效操作

    5. ValueError：传入无效的参数
    UnicodeError：Unicode相关的异常
    UnicodeDecodeError：Unicode解码时的异常
    UnicodeEncodeError：Unicode编码错误导致的异常
    UnicodeTranslateError：Unicode转换错误导致的异常

Python标准警告总结::

    Warning：警告的基类
    DeprecationWarning：关于被弃用的特征的警告
    FutureWarning：关于构造将来语义会有改变的警告
    UserWarning：用户代码生成的警告
    PendingDeprecationWarning：关于特性将会被废弃的警告
    RuntimeWarning：可疑的运行时行为(runtime behavior)的警告
    SyntaxWarning：可疑语法的警告
    ImportWarning：用于在导入模块过程中触发的警告
    UnicodeWarning：与Unicode相关的警告
    BytesWarning：与字节或字节码相关的警告
    ResourceWarning：与资源使用相关的警告







