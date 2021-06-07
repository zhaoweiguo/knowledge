tqdm 模块
#########

Tqdm 是一个快速，可扩展的 Python 进度条，可以在 Python 长循环中添加一个进度提示信息，用户只需要封装任意的迭代器 tqdm(iterator)。

安装::

    pip install tqdm

实例1::

    from tqdm import tqdm
    import time
    for i in tqdm(range(1000)):
         time.sleep(0.01)


实例2::

    from tqdm import trange
    import time
    for i in trange(100):
            time.sleep(0.1)

实例3::

    from tqdm import tqdm
    pbar = tqdm(["a", "b", "c", "d"])
    for char in pbar:
        pbar.set_description("Processing %s" % char)



在 Shell 的 tqdm 用法
=====================

统计所有 python 脚本的行数::

    $ time find . -name '*.py' -exec cat \{} \; | wc -l
    857365
     
    real    0m3.458s
    user    0m0.274s
    sys     0m3.325s
     
    $ time find . -name '*.py' -exec cat \{} \; | tqdm | wc -l
    857366it [00:03, 246471.31it/s]
    857365
     
    real    0m3.585s
    user    0m0.862s
    sys     0m3.358s

增加进度条::

    $ find . -name '*.py' -exec cat \{} \; |
        tqdm --unit loc --unit_scale --total 857366 >> /dev/null
    100%|███████████████████████████████████| 857K/857K [00:04<00:00, 246Kloc/s]









