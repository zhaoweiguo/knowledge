golang相关 [1]_
###############

install all of the dependent Go tools::

    Ctrl+Shift+p
    1. 安装依赖的Go tools
    > Go: Install/Update tools
    2. 查看GOPATH
    > Go: Current GOPATH



.. note:: File > Preferences > Settings (or press ⌘,) to edit the user settings.json file(Note for macOS users: The Preferences menu is under Code not File. For example, Code > Preferences > Settings.)




settting::

    go.gopath
    go.inferGopath
    go.toolsGopath
    "go.useLanguageServer": true,



插件安装
========

安装gocode::

    go get -u -v github.com/nsf/gocode

安装godef::

    go get -u -v github.com/rogpeppe/godef

安装golint::

    go get -u -v github.com/golang/lint/golint

安装go-find-references::

    go get -u -v github.com/lukehoban/go-find-references

安装gorename::

    go get -u -v golang.org/x/tools/cmd/gorename

安装gopkgs::

    go get -u -v github.com/tpng/gopkgs

安装go-symbols::

    go get -u -v github.com/newhook/go-symbols




.. [1] https://github.com/microsoft/vscode-go