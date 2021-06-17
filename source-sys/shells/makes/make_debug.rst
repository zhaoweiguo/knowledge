调试
#########

使用info/warning/error增加调试信息::

    方法1: $(info, "here add the debug info")
      但是此不能打印出.mk的行号

    方法2: $(warning, "here add the debug info")

    方法3: $(error "error: this will stop the compile")
      这个可以停止当前makefile的编译

    方法4: 打印变量的值
      $(info, $(TARGET_DEVICE) )

使用echo增加调试信息(echo只能在target：后面的语句中使用，且前面是个TAB)::

    方法1： @echo "start the compilexxxxxxxxxxxxxxxxxxxxxxx"

    方法2: @echo $(files)







