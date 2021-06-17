评论相关
########



disqus
========

文档 [1]_


gitalk
======

* 留言功能: https://github.com/gitalk/gitalk

安装::

    1. 直接引入
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/gitalk@1/dist/gitalk.css">
    <script src="https://cdn.jsdelivr.net/npm/gitalk@1/dist/gitalk.min.js"></script>

    <!-- or -->

    <link rel="stylesheet" href="https://unpkg.com/gitalk/dist/gitalk.css">
    <script src="https://unpkg.com/gitalk/dist/gitalk.min.js"></script>

    2. npm 安装
    npm i --save gitalk

    import 'gitalk/dist/gitalk.css'
    import Gitalk from 'gitalk'

使用::

    1. 选择一个公共github存储库用于存储评论
    2. 创建 GitHub Application，Authorization callback URL 填写当前使用插件页面的域名
        GitHub Application地址: https://github.com/settings/applications/new
    3. 应用到页面
        方式1:
        a. 添加一个容器：
        <div id="gitalk-container"></div>
        b. 用下面的 Javascript 代码来生成 gitalk 插件
        var gitalk = new Gitalk({
          clientID: '<GitHub Application Client ID>',
          clientSecret: '<GitHub Application Client Secret>',
          repo: '<GitHub repo>',
          owner: '<GitHub repo owner>',
          admin: ['GitHub repo owner and collaborators, only these guys can initialize github issues'],
          id: location.pathname,      // Ensure uniqueness and length less than 50
          distractionFreeMode: false  // Facebook-like distraction free mode
        })

        gitalk.render('gitalk-container')

        方式2：在React使用:
        a. 使用以下代码引入Gitalk组件
        import GitalkComponent from "gitalk/dist/gitalk-component";
        b. 按以下方式在React中使用Gitalk组件:
        <GitalkComponent options={{
          clientID: "...",
          // ...
          // 设置项
        }} />

参考:

* https://iochen.com/post/use-gitalk-in-hexo/

其它相关插件:

* https://github.com/imsun/gitment
* https://vssue.js.org/zh/




.. [1] https://www.jianshu.com/p/d68de067ea74?open_source=weibo_search