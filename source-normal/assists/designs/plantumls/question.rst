常见问题
###############


文件太大显示不全::

    PlantUML limits image width and height to 4096. 
    可通过修改环境变量来解决: PLANTUML_LIMIT_SIZE. 
    1. 方法1:
    set PLANTUML_LIMIT_SIZE=8192
    or
    setenv PLANTUML_LIMIT_SIZE 8192
    2. 方法2:
    java -DPLANTUML_LIMIT_SIZE=8192 -jar /path/to/plantuml.jar ...




