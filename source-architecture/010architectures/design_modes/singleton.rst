单例模式 [1]_
#################

饿汉式单例::

    package org.mlinge.s01;
     
    public class MySingleton {
      
      private static MySingleton instance = new MySingleton();
      
      private MySingleton(){}
      
      public static MySingleton getInstance() {
        return instance;
      }
    }

懒汉式单例::

    package org.mlinge.s02;
 
    public class MySingleton {
      
      private static MySingleton instance = null;
      
      private MySingleton(){}
      
      public static MySingleton getInstance() {
        if(instance == null){//懒汉式
          instance = new MySingleton();
        }
        return instance;
      }
    }

线程安全的懒汉式单例::

    package org.mlinge.s05;
    public class MySingleton {
      
      //使用volatile关键字保其可见性
      volatile private static MySingleton instance = null;
      
      private MySingleton(){}
       
      public static MySingleton getInstance() {
        try {  
          if(instance != null){//懒汉式 
            
          }else{
            //创建实例之前可能会有一些准备性的耗时工作 
            Thread.sleep(300);
            synchronized (MySingleton.class) {
              if(instance == null){//二次检查
                instance = new MySingleton();
              }
            }
          } 
        } catch (InterruptedException e) { 
          e.printStackTrace();
        }
        return instance;
      }
    }






.. [1] https://blog.csdn.net/cselmu9/article/details/51366946

