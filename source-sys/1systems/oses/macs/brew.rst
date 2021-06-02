brew命令
###############

brew常见命令::

    brew install
    brew uninstall 
    brew link
    brew unlink
    brew doctor
    brew cleanup

brew cask::

    brew cask doctor   // Warning: Calling brew cask doctor is deprecated! Use brew doctor --verbose instead.


展示Homebrew的安装路径::

    // /usr/local on macOS 
    // /home/linuxbrew/.linuxbrew on Linux
    brew --prefix





brew与brew cask的区别
----------------------------

brew是从下载源码解压然后 ./configure && make install ，同时会包含相关依存库。并自动配置好各种环境变量，而且易于卸载。 

brew cask是 已经编译好了的应用包 （.dmg/.pkg），仅仅是下载解压，放在统一的目录中（/opt/homebrew-cask/Caskroom），省掉了自己去下载、解压、拖拽（安装）等蛋疼步骤，同样，卸载相当容易与干净。这个对一般用户来说会比较方便，包含很多在 AppStore 里没有的常用软件。



cask 官方的两个安装索引源，一个针对稳定版本，一个针对 Dev::

    https://github.com/Homebrew/homebrew-cask-versions
    https://github.com/Homebrew/homebrew-cask


brew主要用来下载一些不带界面的命令行下的工具和第三方库来进行二次开发
brew cask主要用来下载一些带界面的应用软件，下载好后会自动安装，并能在mac中直接运行使用

举个例子::

    brew install curl可以安装curl第三方库，这样你在开发时就可以使用它的库来进行开发
    brew cask install chrome可以安装谷歌浏览器应用程序，可直接运行







