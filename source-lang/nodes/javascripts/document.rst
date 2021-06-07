.. _document:

#######
dom命令
#######

::
 
    document.anchors 是一个数组，包含了文档中所有锚标记（包含 name 属性的<a>标记），按照在文档中的次序，从 0 开始给每个锚标记定义了一个下标。
    document.links 也是一个数组，包含了文档中所有连接标记（包含 href 属性的<a>标记和<map>标记段里的<area>标记

对象属性::

    document.URL //设置URL属性从而在同一窗口打开另一网页
    document.fileCreatedDate //文件建立日期，只读属性
    document.fileModifiedDate //文件修改日期，只读属性
    document.fileSize //文件大小，只读属性
    document.cookie //设置和读出cookie
    document.charset //设置字符集 简体中文:gb2312

常用对象方法::

    document.write() //动态向页面写入内容
    document.createElement(Tag) //创建一个html标签对象
    document.getElementById(ID) //获得指定ID值的对象
    document.getElementsByName(Name) //获得指定Name值的对象
    document.body.appendChild(oTag)

body-主体子对象::

    document.body.topMargin //页面上边距
    document.body.leftMargin //页面左边距
    document.body.rightMargin //页面右边距
    document.body.bottomMargin //页面下边距
    document.body.background //背景图片
    document.body.appendChild(oTag) //动态生成一个HTML对象

常用对象事件::

    document.body.onclick=”func()” //鼠标指针单击对象是触发
    document.body.onmouseover=”func()” //鼠标指针移到对象时触发
    document.body.onmouseout=”func()” //鼠标指针移出对象时触发

location-位置子对象::

    document.location.hash // #号后的部分
    document.location.host // 域名+端口号
    document.location.hostname // 域名
    document.location.pathname // 目录部分
    document.location.port // 端口号
    document.location.protocol // 网络协议(http:)
    document.location.search // ?号后的部分
    documeny.location.reload() //刷新网页
    document.location.reload(URL) //打开新的网页
    document.location.assign(URL) //打开新的网页
    document.location.replace(URL) //打开新的网页

selection-选区子对象::

    document.selection

images集合(页面中的图象)
============================

a)通过集合引用::

    document.images //对应页面上的img标签
    document.images.length //对应页面上img标签的个数
    document.images[0] //第1个img标签
    document.images[i] //第i-1个img标签

b)通过nane属性直接引用::

    img name=”oImage”
    document.images.oImage //document.images.name属性

c)引用图片的src属性::

    document.images.oImage.src //document.images.name属性.src

d)创建一个图象::

    var oImage
    oImage = new Image()
    document.images.oImage.src=”1.jpg”

* 同时在页面上建立一个img /标签与之对应就可以显示

forms集合(页面中的表单)
============================

a)通过集合引用::

    document.forms //对应页面上的form标签
    document.forms.length //对应页面上/formform标签的个数
    document.forms[0] //第1个/formform标签
    document.forms[i] //第i-1个/formform标签
    document.forms[i].length //第i-1个/formform中的控件数
    document.forms[i].elements[j] //第i-1个/formform中第j-1个控件

b)通过标签name属性直接引用::

    /formform name=”Myform”>input name=”myctrl”/>/form
    document.Myform.myctrl //document.表单名.控件名

c)访问表单的属性::

    document.forms[i].name //对应form name>属性
    document.forms[i].action //对应/formform action>属性
    document.forms[i].encoding //对应/formform enctype>属性
    document.forms[i].target //对应/formform target>属性
    document.forms[i].appendChild(oTag) //动态插入一个控件
    document.all.oDiv //引用图层oDiv
    document.all.oDiv.style.display=”" //图层设置为可视
    document.all.oDiv.style.display=”none” //图层设置为隐藏
    document.getElementId(”oDiv”) //通过getElementId引用对象
    document.getElementId(”oDiv”).style=”"
    document.getElementId(”oDiv”).display=”none”
    //document.all表示document中所有对象的集合只有ie支持此属性，因此也用来判断浏览器的种类


图层对象的4个属性::

    document.getElementById(”ID”).innerText //动态输出文本
    document.getElementById(”ID”).innerHTML //动态输出HTML
    document.getElementById(”ID”).outerText //同innerText
    document.getElementById(”ID”).outerHTML //同innerHTML






