ios常见类
===============

NSUserDefaults::

  // 存取一些短小的信息
  NSString *str = [NSString stringWithString @"hahaha"];
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  [ud setObject:str forKey:@"myKey"];  // 设置
  NSString *value;
  value = [ud objectForKey:"myKey"];   // 读取



  
