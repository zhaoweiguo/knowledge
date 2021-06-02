Android规范
==================

标识符的命名，以驼峰命名法为主，力求做到统一、达意和简洁。

1.包名::

  1.1使用小写字母如 com.colorful.utils，不要 com.Colorful.Utils
  单词间不要用字符隔开，比如 com.colorful.viewutils，而不要com.colorful.view_utils

  1.2后缀:
  使用不同的后缀表示不同的意思。比如：
  所有util包需添加utils后缀；com.colorful.utils

2.类名::

  2.1每个单词首字母大写，比如ColorfulUtils
  2.2后缀:使用不同的后缀表示不同的意思，比如:

    所有Activity类型的文件名需添加Activity后缀；如：XxxActivity.java
    所有Fragment类型的文件名需添加Fragment后缀；如：XxxFragment.java
    所有Adapter类型的文件名需添加Adapter后缀；如：XxxAdapter.java
    所有util包中的文件名需添加Utils后缀；如：XxxUtils.java

3.方法名::

  首字母小写，如 addOrder() 不要 AddOrder()
  动词在前，如 addOrder()，不要orderAdd()

4.变量::

  4.1所有类中的非常量成员变量均以m开头，并提供多行注释;
  例如：

  /**
   * 标识是否为Dog
   */
  private boolean mIsDog;
  4.2所有控件类型的变量，均需添加标识布局类型的前缀；

  例如：

  private TextView mTvContent; //(成员变量)
  RelativeLayout rlContentBackground;// (局部变量)
  4.3常量所有字母大写，以下划线隔开，并提供多行注释，例如

  /**
  * 备注最大个数
  */
  private int REMARKS _MAX _SIZE=5;

5.布局文件命名规范::

  Xml文件不能包含大写字母，单子之间以下划线间隔
  5.1 Activity类布局文件，以activity_前缀开头；
  5.2Fragment类布局文件，以fragment_前缀开头；
  5.3Dialog命名：dialog_描述.xml；例如：dialog_hint.xml
  5.4PopupWindow命名：ppw_描述.xml；例如：ppw_info.xml
  5.5列表项命名listitem_描述.xml；例如：listitem_city.xml
  5.6包含项：include_模块.xml；例如：include_head.xml、include_bottom.xml
  5.7自定义布局类的布局文件，以widget_前缀开头

6.其他规范::

    6.1所有的startActivityForResult()方法，标注请求来源的requestCode和resultCode统一以不可变常量添加在各自对应的类中，并添加多行注释
    6.2所有广播接收器地址标识字符串常量统一添加在GlobalUtil.java文件中，以BROADCAST_前缀开始，并添加多行注释

    例如:

    /**
      * 更新待办事项的广播地址
      */
    public static final String BROADCAST_UPDATE_TODO = "com.szqd.calendar.todofragment.todolist_update_broadcast";




