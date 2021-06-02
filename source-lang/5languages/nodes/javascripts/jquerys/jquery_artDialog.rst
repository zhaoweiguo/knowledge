基于jQuery的对话框插件artDialog
#############################################

::

    <script src="js/artDialog4.0.2/artDialog.source.js?skin=gray"></script> 
    <script src="js/artDialog4.0.2/artDialog.iframeTools.js"></script> 

写个button的按钮点击实现如下的函数::

    function openPage(){ 
       var setting={href:#,title:'测试',width:650,height:380,scrolling:no}; 
        setting.href='你要打开界面的路径'; 
        //要传递数据到里一个页面可以通过data来实现 
        art.dialog.data('key',value); 

        //打开窗口 
        art.Dialog.open(setting.href,setting); 
    } 

实现以上的函数就可以打开你要的窗口了,在里一个界面::

    var value=art.dialog.data('key'); 

获取你要传递的值, 如果想刷新父亲页面::

    var win=art.dialog.open.origin; 
    win.location.reload();



api
---------

http://www.planeart.cn/demo/artDialog/_doc/API.html
