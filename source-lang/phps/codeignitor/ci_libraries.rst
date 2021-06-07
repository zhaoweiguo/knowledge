.. _ci_libraries:

CI库(library)
===========================

原生CI库
---------------------

* 所有系统原生的库都放在目录 ``system/libraries`` 
* 在 ``control`` 中使用如下方法初使化函数::

    $this->load->library('form_validation');
    $this->load->library(array('email', 'table')); //一次加载多个库

自定义CI库
---------------------

* 自定义库放在目录 ``application/libraries`` 
* 你可以新增，扩展甚至替换原生库(注:Database库不能被扩展或替换)
* 命名约定:

    * 文件名必须开头大写,如 ``Myclass.php``
    * 类名必须和文件名匹配,对应上面的是 ``Myclass``

* 自定义类的使用::

    $this->load->library('myclass');//这儿可以用大写也可以用小写
    $this->myclass->some_function();//这儿的myclass是对象的实例，一律小写

* 初使化类的时候传递参数:

    * 通过第二个参数把数据传递到类的结构体::

        $params = array('type'=>'large', 'color'=>'red');
        $this->load->library("myclass', $params);

    * 在类的结构体中按如下实现::

        <?php if( ! defined('BASEPATH')) exit('No direct script access allowed!');
        class Myclass {
            public function __construct($params)
            {
                //Do something with $params
            }
        }

    * 使用config文件来实现如上功能:

        * 创建一配置文件名字和类一样
        * 并把它存放到 ``application/config/`` 中
        * 注: 如果你如上动态传递参数,则配置文件就不会生效

* 在你的库中使用CI的资源

    * 我们常用如下 ``$this`` 来使用CI的资源，但这些命令只能在 ``Controll`` , ``Module`` , ``View`` 中使用,如::

        $this->load->helper('url');
        $this->load->library('session');
        $this->config->item('base_url');

    * 如果在其他地方就要用如下创建一个实例::

        $CI=& get_instance();

    * 一但得到些引用实例(注意引用符号),就可以使用如下命令了::

        $CI =& get_instance();

        $CI->load->helper('url');
        $CI->load->library('session');
        $CI->config->item('base_url');

* 使用你自定义版本替换原生库:

    * 创建的文件名和类名都要和你要替换库一样
    * 实例:替换原生类 ``Email`` 你要创建 ``application/libraries/Email.php`` 文件，并用如下代码声明::

        class CI_Email {
        }

    * 大多数原生类都以 ``CI_`` 开头
    * 然后使用如下命令就是载入的你自己新库::

        $this->load->library('email');

* 扩展原生类:

    * 扩展类一是要extend父类，二要注意文件名和类名都要加 ``MY_`` (当然这是可配的)
    * 实例: 创建 ``application/libraries/MY_Email.php`` ,并声明如下::

        class MY_Email extends CI_Email {
            public function __construct()
            {
                parent::__construct();
            }
        }

    * 之后你就可以使用::

        $this->load->library('email');
        $this->email->some_function();

* 前缀设定(修改文件 ``application/config/config.php`` )::

    $config['subclass_prefix']='MY_'; //当然，这儿不能設定为CI_
