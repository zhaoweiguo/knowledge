.. _jquery_type:

javascript&jquery类型 [1]_
#####################################

字符串
=================

* 类型::

    typeof "some string";  // "string"

* 内置方法::

    "hello".charAt( 0 ) // "h"
    "hello".toUpperCase() // "HELLO"
    "Hello".toLowerCase() // "hello"
    "hello".replace( /e|o/g, "x" ) // "hxllx"
    "1,2,3".split(",") // [ "1", "2", "3" ]

    "Hello".length // 5

数字类型
====================

* 类型::

    typeof 12 // "number"
    typeof 3.543 // "number"

* 说明::

    0.1 + 0.2 // 0.30000000000000004

    Math.PI // 3.141592653589793
    Math.cos( Math.PI ) // -1

    parseInt( "123" ) = 123 // (implicit decimal)
    parseInt( "010" ) = 8 // (implicit octal)
    parseInt( "0xCAFE" ) = 51966 // (implicit hexadecimal)
    parseInt( "010", 10 ) = 10 // (explicit decimal)
    parseInt( "11", 2 ) = 3 // (explicit binary)
    parseFloat( "10.10" ) = 10.1

    "" + 1 + 2; // "12"
    "" + ( 1 + 2 ); // "3"
    "" + 0.0000001; // "1e-7"
    parseInt( 0.0000001 ); // 1 (!)

    String( 1 ) + String( 2 ); // "12"
    String( 1 + 2 ); // "3"

    parseInt( "hello", 10 ) // NaN
    isNaN( parseInt("hello", 10) ) // true

    1 / 0 // Infinity

    typeof NaN // "number"
    typeof Infinity // "number"

    NaN == NaN // false (!)

    Infinity == Infinity // true

object对象
====================

* 类型::

    var x = {};
    var y = {
      name: "Pete",
      age: 15
    };

    typeof {} // "object"

* 实例::

    // Dot Notation
    y.name // "Pete"
    y.age // 15
    x.name = y.name + " Pan" // "Pete Pan"
    x.age = y.age + 1 // 16

    // Array Notation
    var operations = {
      increase: "++",
      decrease: "--"
    };
    var operation = "increase";
    operations[ operation ] // "++"
    operations[ "multiply" ] = "*"; // "*"

    // Iteration
    var obj = {
      name: "Pete",
      age: 15
    };
    for( key in obj ) {
      alert( "key is " + [ key ] + ", value is " + obj[ key ] );
    }

    // jquery自带foreach方法
    jQuery.each( obj, function( key, value ) {
      console.log( "key", key, "value", value );
    });

    // Prototype
    ??暂不解

Array数组
=================

类型::

    var x = [];
    var y = [ 1, 2, 3 ];

    typeof []; // "object"
    typeof [ 1, 2, 3 ]; // "object"

实例::

    for ( var i = 0, j = a.length; i < j; i++ ) {
      // Do something with a[i]. PS:这方法只需要计算一次a.length
    }

    var x = [ 'a', 'b', 'c' ];
    jQuery.each( x, function( index, value ) {
      console.log( "index", index, "value", value );
    });

    var x = [];
    x.push( 1 );
    x[ x.length ] = 2;
    x // [ 1, 2 ]

    var x = [ 0, 3, 1, 2 ];
    x.reverse()      // [ 2, 1, 3, 0 ]
    x.join(" – ")    // "2 - 1 - 3 - 0"
    x.pop()          // 
    x.unshift( -1 )  // 可向数组的开头添加一个或更多元素，并返回新的长度
    x.shift()        // 方法用于把数组的第一个元素从其中删除，并返回第一个元素的值
    x.sort()         // 
    x.splice( 1, 2, 3, 4，5) // [ 2, 3 ]从下标1开始删除之后2个数，然后增加3,4,5三个数

PlainObject扁平对象
===========================

PlainObject类型主要被ajax函数用于保存数据請求。这种类型可能是 ``string`` 或 ``array<form elements>``::

    { 'key[]': [ 'valuea', 'valueb' ] }


on server-side::

    <?php
    $_REQUEST['key'][0]="valuea";
    $_REQUEST['key'][1]="valueb";

Function函数
===================

... 


.. [1] http://api.jquery.com/Types/?rdfrom=http%3A%2F%2Fdocs.jquery.com%2Fmw%2Findex.php%3Ftitle%3DTypes%26redirect%3Dno%22hello%22.replace(%20/e|o/g,%20%22x%22%20)

