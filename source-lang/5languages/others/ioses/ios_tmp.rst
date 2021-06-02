ios收集
################



* storyboard中三个标识::

    an orange cube that represents the first responder
    a yellow sphere that represents the scene’s view controller objct
    a green square that represents the destination of an unwind segue.


* 常用的菜单::

    Editor > Embed In > Navigation Controller

* property的几个实例::

    nonatomic
    copy
    weak/strong
    

* 收集::

    the _name, _location, and _date symbols refer to the instance variables that these properties represent
    the accessor methods—such as self.name;
    By convention, the underscore serves as a reminder that you shouldn’t access instance variables directly.
    The only two places where you should not use accessor methods are in init methods—such as initWithName—and in dealloc methods.
    
    a mutable array, which is an array that can grow.
    the copy attribute in (nonatomic, copy): It specifies that a copy of the object should be used for assignment.
    A class extension allows you to declare a method that is private to the class



* 方法::

    dispatch_async的意思就是将任务进行异步并行处理
    dispatch_group_async

    dispatch_get_main_queue() 函数就是返回主线程
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) 得到系统队列
    //还有两个:DISPATCH_QUEUE_PRIORITY_HIGH, DISPATCH_QUEUE_PRIORITY_LOW
    
* 说明::

    Grand Central Dispatch或者GCD，是一套低层API，提供了一种新的方法来进行并发程序编写。

* 应用跳转到AppStore指定关键字搜索界面::

    //应用跳转到AppStore指定关键字(呵呵)搜索界面
    NSString *str = [NSString stringWithFormat:
        @"https://itunes.apple.com/WebObjects/MZStore.woa/wa/search?mt=8&submit=edit&term=%@#software",
        [@"呵呵" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    // 跳转到下载界面
    NSString *str = [NSString stringWithFormat:
        @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%d",
        909480609 ];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    //根据分类搜索界面
    // NSString *stringURL = @"https://itunes.apple.com/cn/genre/ios-zhi-bo/id6007?mt=8";
    //https://itunes.apple.com/cn/artist/xiamen-meitu-technology-co./id416048308
    // https://itunes.apple.com/cn/artist/xiamen-meitu-technology-co./id416048308#
    NSString *stringURL = @"https://itunes.apple.com/cn/genre/ios-jiao-yu/id6017?mt=8";

    NSURL *url = [NSURL URLWithString:stringURL];
    [[UIApplication sharedApplication] openURL:url];


