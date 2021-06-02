<?php
class Pri_bind_ivr_set extends MX_Controller {

  // 类自有变量
  private $interface_name="pri_bind_ivr_set";

  //结构体
  public function __construct() {
    parent::__construct();

    $this->load->library('api_error');
    $this->load->library('api_param_sort');
    $this->load->service('api_secretkey', NULL, "api_secretkey");// 密钥相关的service
    $this->load->service("api_bind_ivr", NULL, "api_bind_ivr");
    //    echo "construct start! <br />";
    //    my_log("dd");
  }

  //首函数
  public function index(){

    /*---------------------------------------------------
     * 变量声明
     *---------------------------------------------------*/

    // a. 参数变量声明:
    $sn; $sign; $userkey; $tel; $ext; $type; $id; $name; $rule; ;

    // b. 临时数组声明
    $sign_params=array(); //准备用于签名的数组,格式"{key1=value1, ...}"
    $nsign=0;//与上面数组对应

    // c. 临时变量声明
    $sign_correct; //根据参数组合的签名,要和上面的$sign比对
    $secretkey; //密钥,通过$userkey查DB得到
   


    /*----------------------------------------------------------
     * 先对必选的参数进行处理过滤，缺少必选参数的返回错误json
     * 参数分为如下4种:
     *    1. 必选参数sn, 此参数要先行进行判断,因后面的错误返回都信赖于些参数
     *    2. 必选参数sign, 此参数不参与签名操作
     *    3. 其他必选参数
     *    4. 其余可选参数
     *--------------------------------------------------------*/

    // 1. 参数中是否有sn参数,如果没有返回40001错误;有则做相应赋值

    if(!isset($_POST['sn'])) {
        echo $this->api_error->return_error('40001', '', $this->$interface_name);
        return 0;
    } else {
      $sn=_GET['sn'];
      $sign_params[$nsign]='sn='.$sn;
      $nsign++;
    }

    // 2. 参数中是否含有sign参数,如果没有返回40002错误;有则做相应赋值
    if(!isset($_POST['sign'])) {
        echo $this->api_error->return_error('40002', '', $this->$interface_name);
        return 0;
    } else {
      $sign=_GET['sign'];
      $sign_params[$nsign]='sign='.$sign;
      $nsign++;
    }

    // 3. 其他必选参数是否都有值,如果没有返回40003错误[userkey, type]
    if(!isset($_POST['userkey'])) {
        echo $this->api_error->return_error('40003', '', $this->$interface_name);
        return 0;
    } else {
      $userkey=_GET['userkey'];
      $sign_params[$nsign]='userkey='.$userkey;
      $nsign++;
    }

    if(!isset($_POST['id'])) {
        echo $this->api_error->return_error('40007', '', $this->$interface_name);
        return 0;
    } else {
      $id=_GET['id'];
      $sign_params[$nsign]='id='.$id;
      $nsign++;
    }

    // 4. 其余的可选参数[ext]
       //none

    if(isset($_post['ext'])) {
        $ext=$_GET['ext'];
        $sign_params[$nsign]='ext='.$ext;
        $nsign++;
      }
    //----------------------------------------------------------
    // 对参数的内容合法性进行判断
    //----------------------------------------------------------

    //判断参数的值是否合法
    //......



    //根据userkey得到secretkey
    $secretkey=$this->api_secretkey->get_secretkey($userkey); //......

    //得到签名值
    $sign_correct=$this->api_param_sort->params_md5($params, $secretkey);

    //判断签名值是否正确
    if($sign!==$sign_correct) {
      echo $this->api_error->return_error("400101", $sn, $this->$interface_name);
      return 0;
    }

    //------------------------------------------------------------
    // 如果上面都正确，下面就该取值了
    //------------------------------------------------------------

    // 根据条件得到列表
    //并把得到的值组成json串
    $json=$this->api_bind_ivr->get_json($userkey, $type); //......
    echo $json;

    return 1;

  }// end the function index()





}// end the Class Pri_sound_get


/* End of file pri_sound_get.php */
/* Location: ./application/modules/api/controller */



