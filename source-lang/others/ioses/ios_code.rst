ios代码片段
===================

常用方法::

   // 打印
   NSLog(@"%@", <variable>);


   @selector()就是取类方法的编号,selector可以叫做选择器，其实指的就是对象的方法,他的行为基本可以等同C语言的中函数指针
   @selector(xxxx)返回的类型是SEL
   一般用于[a performSelector:@selector(b)];就是说去调用a对象的b方法，和[a b];的意思一样，但是这样更加动态一些
   [对象　performSelector:SEL变量　withObject:参数1　withObject:参数2];
   
  

   

函数格式::

  // 一般函数
  + (TJParam *)getSignature: (TJParam *)params
  //1. +:函数说明
  //2. 返回值类型
  //3. 函数名
  //4. 参数名



::

  // Outlet 被定义为 IBOutlet 属性
  @property (weak, nonatomic) IBOutlet UITextField *textField;
  // IBOutlet 关键词告诉 Xcode，您可以从 Interface Builder 连接到该属性
  

  //导航控制器 (UINavigationController)
  视图控制的前进、后退

  // 将导航控制器添加到表格视图控制器(在屏幕上方增加航栏)
  “Editor”>“Embed In”>“Navigation Controller”


类型::

  NSString 和 NSMutableString
  NSData 和 NSMutableData
  NSDate
  NSNumber
  NSValue
  
  NSString *anotherString = [NSString stringWithFormat:@"%d %@", 1, @"String"];
  NSString *fromCString = [NSString stringWithCString:"A C string" encoding:NSUTF8StringEncoding];

  NSNumber *myIntValue    = @32;
  NSNumber *myDoubleValue = @3.22346432;
  NSNumber *myBoolValue = @YES;
  NSNumber *myCharValue = @'V';

  // 集类类型
  NSArray 和 NSMutableArray—数组
  NSSet 和 NSMutableSet—集合
  NSDictionary 和 NSMutableDictionary

  + (id)arrayWithObject:(id)anObject;
  + (id)arrayWithObjects:(id)firstObject, ...;
  - (id)initWithObjects:(id)firstObject, ...;
  // arrayWithObjects: 和 initWithObjects: 方法都采用了以 nil 结束且数量可变的参数
  NSArray *someArray = [NSArray arrayWithObjects:someObject, someString, someNumber, someValue, nil];
  NSUInteger numberOfItems = [someArray count];  // 个数

  // 排序
  NSArray *unsortedStrings = @[@"gammaString", @"alphaString", @"betaString"];
  NSArray *sortedStrings = [unsortedStrings sortedArrayUsingSelector:@selector(compare:)];

  NSDictionary: 字典类型
  // 实例
  NSDictionary *dictionary = @{
     @"carrierName"        : carrier.carrierName,
     @"mobileCountryCode"  : carrier.mobileCountryCode,
  }
  // 查询字典
  [dictionary objectForKey:@"magicNumber"];
  dictionary[@"magicNumber"];

  
viewController相关::

  viewDidLoad:在视图加载后被调用
  viewWillAppear:视图即将可见时调用。默认情况下不执行任何操作
  viewDidAppear: 视图已完全过渡到屏幕上时调用
  viewWillDisappear:视图被驳回时调用，覆盖或以其他方式隐藏。默认情况下不执行任何操作
  viewDidDisappear:视图被驳回后调用，覆盖或以其他方式隐藏。默认情况下不执行任何操作


NSTimer相关::

  setFireDate



* 本地存储数据简单的说有三种方式::

    数据库、NSUserDefaults和文件

  




  
