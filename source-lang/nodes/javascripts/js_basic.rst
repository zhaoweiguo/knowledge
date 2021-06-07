

js的常用函数收集
##############################


::

    o = {"key1":"value1", "key2":"value2"}
    JSON.stringify(o)   //把json类型转化为string
    $.parseJSON(str);   //把string转化为json类型



base64相关::

    $.base64Encode(msg);    //加密
    $.base64Decode(msg);   //解密


大小写相关::

  //转换成大写
  toUpperCase 方法
  strVariable.toUpperCase( )
  "String Literal".toUpperCase( )
  
  //转换成大写
  toLowerCase 方法
  strVariable.toLowerCase( )
  "String Literal".toLowerCase( )

替换相关::

  <stringObject>.replace(regexp/substr,replacement)

encode & decode::


    function htmlencode(s){
       var div = document.createElement('div');
       div.appendChild(document.createTextNode(s));
       return div.innerHTML;
    }
    function htmldecode(s){
       var div = document.createElement('div');
       div.innerHTML = s;
       return div.innerText || div.textContent;
    }

    实例测试
    document.onclick = function (){
       //&lt;p&gt; &amp; &lt;/p&gt;
       alert(htmlencode('<p> & </p>'));

       //<p> & © ABC 中文 中文 </p>
       alert(htmldecode('&lt;p&gt; &amp; &copy; &#65;&#66;&#67; &#20013;&#25991; &#x4E2D;&#x6587; &lt;/p&gt;'));
    }
  

jquery 如何使用innerHTML::

  $("#responsediv") 是个Jquery对象，它Val()是对Value属性赋值对它无意义,Jquery没有innerHTML这个属性
  应该这样写$("#responsediv")[0].innerHTML=msg 就可以获得这个Dom对象使用innerHTML
  or
  document.getElementById("#tabs").innerHTML;


onclick事件::

  onclick="javascript:jump('{{$ad['url']}}')"
  // 记得函数加单引号

  
url参数值::

  // 使用正则表示
  function getQueryString(name) {
      var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
      var r = window.location.search.substr(1).match(reg);
      if (r != null) return unescape(r[2]); return null;
  }

ie剪切版::


      if($.browser.msie){
          window.clipboardData.setData("Text",$(this).text());
      }





      
