PHP规范
============


laravel5.x框架规范::

    /.env              加入到.gitignore忽略文件
    /.env.example      增加此文件
    /app/Http/Model    增加此文件夹,里面存放model文件
    /app/Http/Service  增加此文件夹,里面存放service文件


编辑器(IDE)::

    1.1 不允许使用tab符号,统一定用两个空格代替tab
    1.2 编码格式统一为utf8

代码格式要整洁::

    2.1 使用大括号时统一在此行的最后加，不要在下一行加,如if (xxxxx) {
    2.2 变量赋值时，=号左右都要加空格, 如 $variable = “”;
    2.3 要起有意义的名字(做到见名知意)
    2.4 变量的起名建议使用「驼峰式」如strUserName
    2.5 每个方法建议增加简单的注释







