vue_router
==================

动态路由::

  //匹配
  /user/:username                  /user/evan
  /user/:username/post/:post_id    /user/evan/post/123

  //响应路由参数的变化
  watch: {
    '$route' (to, from) {
      // 对路由变化作出响应...
    }


嵌套路由::

  <div id="app">
    <router-view></router-view>
  </div>
  const User = {
    template: `
      <div class="user">
        <h2>User {{ $route.params.id }}</h2>
        <router-view></router-view>
      </div>
    `
  }
  const router = new VueRouter({
    routes: [
      { path: '/user/:id', component: User,
        children: [
          {
            // 当 /user/:id/profile 匹配成功，
            // UserProfile 会被渲染在 User 的 <router-view> 中
            path: 'profile',
            component: UserProfile
          },
          {
            // 当 /user/:id/posts 匹配成功
            // UserPosts 会被渲染在 User 的 <router-view> 中
            path: 'posts',
            component: UserPosts
          }
        ]
      }
    ]
  })

编程式的导航::

  声明式
  <router-link :to="..."> 
  编程式
  router.push(...)

  const userId = 123
  router.push({ name: 'user', params: { userId }}) // -> /user/123
  router.push({ path: `/user/${userId}` }) // -> /user/123
  // 这里的 params 不生效
  router.push({ path: '/user', params: { userId }}) // -> /user


重定向和别名::

  const router = new VueRouter({
    routes: [
      { path: '/a', redirect: '/b' },            // 1.普通的
      { path: '/a', redirect: { name: 'foo' }},  // 2.命名的路由
      { path: '/a', redirect: to => {            // 3.方法，动态返回重定向目标
        // 方法接收 目标路由 作为参数
        // return 重定向的 字符串路径/路径对象
      }}
      { path: '/a', component: A, alias: '/b' }  // 4.别名
    ]
  })














