搜索
##########

中文搜索 [1]_
=============

安装jieba类库::

    pip install jieba

修改sphinx的conf.py文件，为项目设置为中文的搜索配置::

    # Language to be used for generating the HTML full-text search index.
    # Sphinx supports the following languages:
    #   'da', 'de', 'en', 'es', 'fi', 'fr', 'hu', 'it', 'ja'
    #   'nl', 'no', 'pt', 'ro', 'ru', 'sv', 'tr', 'zh'
    html_search_language = 'zh'

设置jieba的词典路径::

    # A dictionary with options for the search language support, empty by default.
    # 'ja' uses this config value.
    # 'zh' user can custom change `jieba` dictionary path.
    # html_search_options = {'dict': '/usr/lib/jieba.txt'}   # 根据需要设置jieba的词典路径





.. [1] https://www.chenyudong.com/archives/sphinx-doc-support-chinese-search.html