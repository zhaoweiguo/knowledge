sphinx_rtd_theme主题
-------------------------

* 网站: https://sphinx-rtd-theme.readthedocs.io/
* demo: https://sphinx-rtd-theme.readthedocs.io/en/stable/demo/demo.html

安装::

  pip install sphinx_rtd_theme   // 我用这种方法好像没有起作用
  cat config.py:
    html_theme = "sphinx_rtd_theme"
  or
  git clone https://github.com/rtfd/sphinx_rtd_theme.git
  cp -r sphinx_rtd_theme/sphinx_rtd_theme ./source/_themes/
  cat config.py:
    html_theme = "sphinx_rtd_theme"
    html_theme_path = ["_themes", ]

其他配置::

  html_theme_options = {
      'canonical_url': '',
      'analytics_id': '',
      'logo_only': False,
      'display_version': True,
      'prev_next_buttons_location': 'bottom',
      'style_external_links': False,
      'vcs_pageview_mode': '',   // @todo  这个配置出错，原因未定
      # Toc options
      'collapse_navigation': True,
      'sticky_navigation': True,
      'navigation_depth': 4,
      'includehidden': True,
      'titles_only': False
  }

.. note:: 有问题时，一定记得来 `这儿 <https://sphinx-rtd-theme.readthedocs.io/en/stable/index.html>`_ 查使用方法


