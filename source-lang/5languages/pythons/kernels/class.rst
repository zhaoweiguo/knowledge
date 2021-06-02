类和对象
########

类-实例1::

    class Person:
        def sayHi(self):
            print('Hello, how are you?')

    p = Person()
    p.sayHi()

    // 結果
    Hello, how are you?

    //__init__方法(在类的一个对象被建立时, 马上运行):

    class Person:
        def __init__(self, name):
            self.name = name
        def sayHi(self):
            print 'Hello, my name is', self.name

    p = Person('Swaroop')
    p.sayHi()

    // 結果
    Hello, my name is Swaroop

类-实例2::

    class Person():
        def __init__(self, name, email):
            self.name = name
            self.email = email
            
        def XDD(self, tem):
            return 'I am ' + self.name + tem

    hunter = Person('Elmer Fudd', "QQ@WW.tw")

    Husky = Person('Hsuky', "XDD@WW.tw")

    print(hunter.name)
    print(hunter.email)

    print(hunter.XDD('!!!'))

    print(Husky.name)
    print(Husky.email)

继承
====

继承::

    class math():
        def add(self, a, b):
            print("add:", a + b)

    class mean(math):
        pass
        
    ab = mean()
    ab.add(1, 3)

    ac = math()
    ac.add(1,5)

覆盖方法::

    class math():
        def add(self, a, b):
            print("add:", a + b)

    class mean(math):
        def add(self, a, b):
            print("add:", a + b + b)
        
    ab = mean()
    ab.add(1, 3)

添加新方法::

    class math():
        def add(self, a, b):
            print("add:", a + b)

    class mean(math):
        def less(self, a, b):
            print("add:", a - b)
        
    ab = mean()
    ab.add(1, 3)
    ab.less(1, 3)

    ac = math()
    ac.add(1, 5)


使用super()方法用來扩充既有的屬性::

    class Person():
        def __init__(self, name, email):
            self.name = name
            self.email = email
            
    class Person_day(Person):
        def __init__(self, name, email, birthday):
            super().__init__(name, email)
            self.birthday = birthday
            
            
    hunter = Person('Elmer Fudd', 'QQ@CC.tw')
    husky = Person_day('Elmer Fudd', 'QQ@CC.tw', '2016/05/07')

    print(hunter.name)
    print(hunter.email)
    print('=============')
    print(husky.name)
    print(husky.email)
    print(husky.birthday)

属性getter 和 setter方法
========================

方法一: 若沒有给定setter函数，则无法通过property()來改变属性值::

    class Duck():
        def __init__(self, input_name):
            self.hidden_name = input_name
        
        #取的 name 的函数
        def get_name(self):
            print('---使用get函数---')
            return self.hidden_name + '!!'
        
        #设定 name 的函数
        def set_name(self, input_name):
            print('---使用set函数---')
            self.hidden_name = input_name + '??'
        
        #使用property(get,set)來包裝，让使用上更方便
        name = property(get_name, set_name)  # 注意这儿

    #定义Object为Duck类，并给定name，从头到尾都沒有直接抄作hidden_name來改变属性值
    fowl = Duck('Howard')
    print('提取名称时，则调用get函数')
    print(fowl.name)

    print('\n设定名称时，则调用set函数')
    fowl.name = 'Daffy'
    print('nname被改成Daffy:')
    print(fowl.name)

    print('\n当然也可以通过原始的set_name()与get_name()进行修改私有属性')
    print(fowl.get_name())
    fowl.set_name('Daffyyyy')
    print(fowl.get_name())

    输出:
    提取名称时，则调用get函数
    ---使用get函数---
    Howard!!

    设定名称时，则调用set函数
    ---使用set函数---
    nname被改成Daffy
    ---使用get函数---
    Daffy??!!

    当然也可以通过原始的set_name()与get_name()进行修改私有属性
    ---使用get函数---
    Daffy??!!
    ---使用set函数---
    ---使用get函数---
    Daffyyyy??!!


方法二: 通过装饰器::

    class Duck():
        def __init__(self, input_name):
            self.hidden_name = input_name
        
        @property
        def name(self):
            print('---使用get函数---')
            return self.hidden_name

        @name.setter
        def name(self, input_name):
            print('---使用set函数---')
            self.hidden_name = input_name
            
    #定义Object为Duck类，并给定name
    fowl = Duck('Howard')

    print('提取名称时，则调用get函数')
    print(fowl.name)

    print('\n设定名称时，则调用set函数')
    fowl.name = 'Daffy'
    print('nname被改成Daffy')
    print(fowl.name)

使用名称重整保持私有性::

    class Duck():
        def __init__(self, input_name):
            self.__name = input_name
        
        @property
        def name(self):
            print('---使用get函數---')
            return self.__name
        
        @name.setter
        def name(self, input_name):
            print('---使用set函數---')
            self.__name = input_name

    fowl = Duck('Howard')
    print(fowl.name)
    fowl.name = 'Donald'
    print(fowl.name)
    #fowl.__name        #直接修改會錯誤
    #fowl._Duck__name   #重整完的名稱

类本身方法
==========

类本身也是可以设定属性以及方法::

    @staticmethod不需使用cls参数
    @classmethod第一个参数需为cls参数

classmethod::

    class A():
        count = 0           #类属性
        def __init__(self):
            A.count += 1    #修改类属性
        
        def exclaim(self):
            print("I'm an A!")
        
        @classmethod        #类方法(methond)
        def kids(cls):
            print("A has", cls.count, " objects.")  # A has 3 objects.
            print("A has", A.count, " objects.")    # A has 3 objects.
            
        @classmethod        #类方法(methond)
        def kids2(A):
            print("A has", A.count, " objects.")    # A has 3 objects.

    easy_a = A()
    breezy_a = A()
    wheezy_a = A()
    A.kids()
    A.kids2()

staticmethod::

    class CoyoteWeapon():
        @staticmethod
        def commercial():
            print('This CoyoteWeapon has been brought to you by Acme')
            
    CoyoteWeapon.commercial()

公有和私有变量
==============

.. note:: 在 Python 中定义私有变量只需要在变量名或函数名前加上“__”两个下划线，那么这个函数或变量就会为私有的了。

实例::

    class JustCounter:
        __secretCount = 0  # 私有变量
        publicCount = 0  # 公开变量

        def __foo(self):  # 私有方法
            print('这是私有方法')

    # 调用: 
    counter = JustCounter()

    # 直接调用私有函数会报错
    print(counter.__secretCount)  
    # AttributeError: 'JustCounter' object has no attribute '__secretCount'

    # Python的私有为伪私有
    print(counter._JustCounter__secretCount)  # 2 



多态
====

::

    class Quote():
        def __init__(self, person, words):
            self.person = person
            self.words = words
        
        def who(self):
            return self.person

        def says(self):
            return self.words + '.'
        
    class BabblingBrook():
        def who(self):
            return 'Brook'
        
        def says(self):
            return 'Babble'
        
    hunter = Quote('Elmer', "wabbits")
    brook = BabblingBrook()

    #尽管两者完全独立没有关系，但只要有相同名称的函数就可以调用到
    def who_says(obj):
        print(obj.who(), 'says', obj.says())
        
    who_says(hunter)    # Elmer says wabbits.
    who_says(brook)     # Brook says Babble


组合
====

.. note:: 如果要新建的类有相似的类可以继承的話就可以采用继承来取得父类的所有，但若两个类差异太大，或是沒有关系，我们就可以采用组合來合并这些类

例如，鸭子是鸟的一种，所以可以继承鸟的类，但是嘴巴和尾巴不是鸟的一种，而是鸭子的组成::

    class Bill():
        def __init__(self, description):
            self.description = description
            
    class Tail():
        def __init__(self, length):
            self.length = length
        

    class Duck():
        def __init__(self, bill, tail):
            self.bill = bill
            self.tail = tail
        def about(self):
            print('这只鸭子有一个', bill.description, '嘴巴，然后有', tail.length, '长的尾巴')

            
    bill = Bill('红色的')
    tail = Tail('白色，15cm')

    duck = Duck(bill, tail)
    duck.about()    # 这只鸭子有一个 红色的 嘴巴，然后有 白色，15cm 长的尾巴



实例
====

代码::

    class SchoolMember:
        '''任一学校成员.'''
        def __init__(self, name, age):
            self.name = name
            self.age = age
            print('(初使化成员: %s)' % self.name)

        def tell(self):
            print('名字:"%s" 年齡:"%s"' % (self.name, self.age))

    class Teacher(SchoolMember):    # 继承
        '''展现老师情况.'''
        def __init__(self, name, age, salary):
            SchoolMember.__init__(self, name, age)
            self.salary = salary
            print('(初使化老师: %s)' % self.name)

        def tell(self):
            SchoolMember.tell(self)
            print ('工资: "%d"' % self.salary)

    class Student(SchoolMember):    # 继承
        '''展现学生情况.'''
        def __init__(self, name, age, marks):
            SchoolMember.__init__(self, name, age)
            self.marks = marks
            print ('(初使化学生: %s)' % self.name)

        def tell(self):
            SchoolMember.tell(self)
            print ('Marks: "%d"' % self.marks)

    t = Teacher('Mrs. Shrividya', 40, 30000)
    s = Student('Swaroop', 22, 75)

    members = [t, s]
    for member in members:
        member.tell()

输出::

    (初使化成员: Mrs. Shrividya)
    (初使化老师: Mrs. Shrividya)
    (初使化成员: Swaroop)
    (初使化老师: Swaroop)
    名字:"Mrs. Shrividya" 年齡:"40"
    工资: "30000"
    名字:"Swaroop" 年齡:"22"
    Marks: "75"






