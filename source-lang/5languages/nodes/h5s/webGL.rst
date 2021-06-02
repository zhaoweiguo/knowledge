webGL
###########

是一项使用JavaScript实现3D绘图的技术，浏览器无需插件支持，Web开发者直接使用js调用相关API就能借助系统显卡（GPU）进行编写代码从而呈现3D场景和对象

WebGL标准由科纳斯组织（Khronos Group）开发和维护，Google、Mozilla、Opera和Apple 等浏览器厂商都是其中的成员，为这一标准做出了显著贡献。从名称上我们就可以知道WebGL跟openGL肯定是小弟与大哥的关系。事实上webGL是基于OpenGL ES 2.0开发的，OpenGL ES 是 OpenGL 三维图形 API 的子集，针对手机、平板电脑和游戏主机等嵌入式设备而设计。浏览器内核通过对OpenGL API的封装，实现了通过JavaScript调用3D的能力。WebGL 内容作为 HTML5 中的Canvas标签的特殊上下文实现在浏览器中（这下canvas终于可以画3D图了，虽然用的是不同技术）

webGL的各大浏览器支持情况（截至2013年11月）：

桌面浏览器::

    Mozilla Firefox 4+
    Google Chrome 8+
    Internet Explorer 11+
    Safari 5.1+
    Opera 12+

移动浏览器::

    Firefox 25+
    Google Chrome 31+
    Opera Mobile 12+
    Android Browser 暂不支持
    iOS Safari暂不支持
    IE Mobile 暂不支持
