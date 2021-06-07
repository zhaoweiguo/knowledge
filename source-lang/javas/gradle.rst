gradle项目 [1]_
######################

Gradle是一个基于Apache Ant和Apache Maven概念的项目自动化构建工具。它使用一种基于Groovy的特定领域语言(DSL)来声明项目设置，抛弃了基于XML的各种繁琐配置
面向Java应用为主。当前其支持的语言限于Java、Groovy和Scala，计划未来将支持更多的语言


实例::

    dependencies {    
        compile fileTree(dir: 'libs', include: ['*.jar'])  
        compile 'com.android.support:appcompat-v7:21.0.2'    
        compile 'com.jpardogo.flabbylistview:library:+'    
        compile 'com.jpardogo.googleprogressbar:library:+'
        compile 'com.mcxiaoke.volley:library:1.0.+'   
        compile 'com.jakewharton:butterknife:6.0.0'    
        compile 'com.umeng.analytics:analytics:5.2.4'
    } 

打包::

    gradle build
    java -jar build/libs/mymodule-0.0.1-SNAPSHOT.jar




.. [1] https://gradle.org/


