sys模块
#######



sys模块::

    import sys
    # Script starts from here
    if len(sys.argv) < 2:
        print 'No action specified.'
        sys.exit()

    if sys.argv[1].startswith('--'):
        option = sys.argv[1][2:]
        # fetch sys.argv[1] but without the first two characters
        if option == 'version':
            print 'Version 1.2'
        elif option == 'help':
            print '''\
                 Options include:
                   --version : Prints the version number
                   --help    : Display this help'''
        else:
            print 'Unknown option.'
            sys.exit()

    //os模块(如果你希望你的程序能够与平台无关的话):
    os.name     # 指示你正在使用的平台(nt, posix)
    os.getcwd() # 得到当前工作目录
    os.getenv() # 读取环境变量
    os.putenv() # 设置环境变量
    os.listdir()  # 定目录下的所有文件和目录名
    os.remote()   # 删除一个文件
    os.system()   # 运行shell命令
    os.linesep    # 当前平台使用的行终止符(Windows使用'\r\n'，Linux使用'\n'而Mac使用'\r')
    os.path.split() # 一个路径的目录名和文件名
    os.path.isfile()  # 检验给出的路径是一个文件
    os.path.isdir()   # 检验给出的路径是一个目录


