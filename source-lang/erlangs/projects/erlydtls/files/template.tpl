<?php
class {{ classname }} extends MX_Controller {

  // 类自有变量
  private $interface_name="{{ interface_name }}";

  //结构体
  public function __construct() {
    parent::__construct();
  }

  //首函数
  public function index(){

    // a. 参数变量声明:
    {{ variable }};

    return 1;

  }// end the function index()

}// end the Class Pri_sound_get


/* End of file {{ classname }}.php */
/* Location: ./application/modules/api/controller */



