android语言
====================

::

   onCreate: 创建时执行
   onResume: 加载界面，可见时执行
   onDestroy: 一般由java垃圾回收机制操作
   onAttachedToWindow:
   看来我们最终要找的生命周期为onCreate->onStart->onResume->onAttachedToWindow
   


::

   // 切换activity
   intent = new Intent(this, TabHolderActivity.class);
   startActivity(intent);




   
