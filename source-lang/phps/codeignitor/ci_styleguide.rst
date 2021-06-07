.. _ci_styleguide:

CI约定的风格与语法
========================

* 文件格式为UTF-8
* php结束标签(php文件前 ``<?php`` 后 ``?>`` 都不能有任何东西):

    默认结束标签是 ``?>`` ，但如果后面再写东西， 不管是注释还是什么都会显示在页面上，所以一般使用::

        /* End of file myfile.php */
        /* Location: ./system/modules/mymodule/myfile.php */

* 类的命名:

    * 类以大写字母开头， 其余字母都是小写
    * 多个单词之间用 ``_`` 分开
    * 不许使用 ``CamelCase`` 命名方法
    * 避免使用过长的名字
    * 要起有意义的名字

* 函数与变量的命名:

    * 和类命名相似，只是它们的全部字母都是小写
    * 短名字(如，i, j...)只用于在for循环中做迭代器
    * 举例::

        function get_file_properties()  // descriptive, underscore separator, and all lowercase letters

* 常量的命名:

    除了字母必须全部用大小写外其余一变量一样

* 注释(以下只是几个推荐格式)::

    /**
     * Super Class
     *
     * @package     Package Name
     * @subpackage  Subpackage
     * @category    Category
     * @author      Author Name
     * @link        http://example.com
     */
    class Super_class {

    /**
     * Encodes string for use in XML
     *
     * @access      public
     * @param       string
     * @return      string
     */
    function xml_encode($str)

* TRUE，FALSE和NULL

    必须全部是大写

* 逻辑操作::

    if ($foo OR $bar)  // not: if ($foo || $bar)
    if ($foo && $bar) // not: if ($foo AND $bar) 
    if ( ! $foo)  //  not: if (!$foo) 记得要加空格
    if ( ! is_array($foo)) //if (! is_array($foo)) 要加空格，“!号”前后都要加空格

* 返回值与类型转换:

    * 函数在错误的时候一般夫返回“”或0
    * 如果使用 ``== !=`` 而不是 ``=== !===`` 时,会出现各种问题
    * 类型转换时要注意:当把一个变量转化为字符串时:

        * NULL或二进制的FALSE会被转化为空字符串
        * 0或其他数字会被转化为数据字符串，如 ``(string)1-->"1"``
        * TRUE被转化为 ``"1"``

* 在提交的代码中不能有调试信息
* 一个文件一个类
* 使用unix换行来保存文件
* 代码缩进(使用Allman类型缩进)，除类的声明外， 其余大括号都是独占一行，即::

    function foo($bar)
    {
        // ...
    }

    foreach ($arr as $key => $val)
    {
        // ...
    }

* 方括号与圆括号内的空格符,通常情况下，不要在方括号"[]"和圆括号"()"内增加任何空格符.唯一的例外就是为了提高可读性和区别开它们与函数，在接受参数的PHP语法控制结构所使用的括号里，需要增加空格符(declare, do-while, elseif, for, foreach, if, switch, while)::

    不恰当的:
    $arr[ $foo ] = 'foo';
    正确的:
    $arr[$foo] = 'foo'; // 数组键值的方括号内没有空格

    不恰当的:
    function foo ( $bar )
    {
     
    }
    正确的:
    function foo($bar) // 函数声明的圆括号内没有空格
    {
      
    }

    不恰当的:
    foreach( $query->result() as $row ) // PHP语法控制结构之后有空格，但不是在圆括号内
    正确的:
    foreach ($query->result() as $row)

* 本地化文本，所有在control panel输出的文本都应该使用 lang 文件里的语言变量来允许本地化::

    INCORRECT:
    return "Invalid Selection";

    CORRECT:
    return $this->lang->line('invalid_selection');

* 如果方法和变量只在类的内部使用，应当使用下划线作为前缀::

    convert_text()              // public method
    _convert_text()                    // private method


* 使用一个不确定是否存在的变量时，先使用命令 ``isset()``
* 每行一条语句
* 字符串:

    * 尽量使用单绰号
    * 当需要解析变量时，使用双绰号，注意变量要加 ``{}`` ::

        "My string {$foo}"

    * 当字符串中有单引号时::

        "SELECT foo FROM bar WHERE baz = 'bag'"

* SQL查询:

    * SQL关键词总是大写
    * 为了可读性，将从句句分成多行来写::

        $query = $this->db->query("SELECT foo, bar, baz, foofoo, foobar AS raboof, foobaz
                          FROM exp_pre_email_addresses
                          WHERE foo != 'oof'
                          AND baz != 'zab'
                          ORDER BY foobaz
                          LIMIT 5, 100");



