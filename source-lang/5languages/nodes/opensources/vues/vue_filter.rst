vue过滤器
===================

使用::

  <!-- 在双花括号中 -->
  {{ message | capitalize }}

  <!-- 在 `v-bind` 中 -->
  <div v-bind:id="rawId | formatId"></div>

定义::

  1.组件的选项中定义本地的过滤器
  filters: {
    capitalize: function (value) {
      if (!value) return ''
      value = value.toString()
      return value.charAt(0).toUpperCase() + value.slice(1)
    }
  }

  2.在创建 Vue 实例之前全局定义过滤器
  Vue.filter('capitalize', function (value) {
    if (!value) return ''
    value = value.toString()
    return value.charAt(0).toUpperCase() + value.slice(1)
  })

  new Vue({
    // ...
  })

其他::

  过滤器可以串联：
  {{ message | filterA | filterB }}

  过滤器是 JavaScript 函数，因此可以接收参数：
  {{ message | filterA('arg1', arg2) }}
  这里，filterA 被定义为接收三个参数的过滤器函数。其中 message 的值作为第一个参数，普通字符串 'arg1' 作为第二个参数，表达式 arg2 的值作为第三个参数。











