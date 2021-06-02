android问题汇总
=====================

* source 1.6 中不支持 diamond 运算符:

.. figure:: /images/languages/androids/android_question1.jpg
  :width: 60%



NDK not configured::

    解决方法：
      Download the NDK from 
    http://developer.android.com/tools/sdk/ndk/.
    Then add 
    ndk.dir=path/to/ndk
    in local.properties.
     (On Windows, make sure you escape backslashes, e.g. C:\\ndk rather than C:\ndk)

    Error:Execution failed for task ':app:processDebugManifest'.







