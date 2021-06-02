ImageMagick:图片处理相关
#############################

::

  // 安装
  yum install ImageMagick-devel

  convert -background '#FFFFFF' -fill '#000000' -size 100 -gravity Center -wave 5x100 -swirl 15  -pointsize 28 label:233 -draw 'Bezier 10,40 50,35 100,35 150,35 200,50 250,35 300,35' ./file.png

  convert -background lightblue  -fill blue label:@/etc/test   label_file.gif

  convert -resize 100x100 src.jpg des.jpg


常见问题::

  // 现象:
  $> convert -background lightblue  -fill blue label:test file.gif
  convert: not authorized `test' @ error/constitute.c/ReadImage/454.
  convert: no images defined `file.gif' @ error/convert.c/ConvertImageCommand/3046.
  // 解决:
  有一个文件/etc/ImageMagick/policy.xml
  此文件是为了安全原因增加的权限控制,这条语句使用了label权限,所以修改此xml文件中的
  <policy domain="coder" rights="none" pattern="LABEL" />
  为
  <policy domain="coder" rights="read|write" pattern="LABEL" />

