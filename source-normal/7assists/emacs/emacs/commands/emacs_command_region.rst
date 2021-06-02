.. _emacs_command_region:

区块编辑
=============
* 如图::

    ---XXXXXxxx
    xxxXXXXXxxx
    xxxXXXXXxxx
    xxxXXXXX---

    连续区块: 为标记和光标点之间连续的区块；字符 X 和 x 均为连续区块
    矩形区块: 为标记和光标点之间矩形的区块；大写字符 X 为矩形区块

公共::

    整个缓冲区          C-x h (M-x mark-whole-buffer)
    交换标记和光标点     C-x C-x (M-x exchange-point-and-mark)
    在光标点处设置标记   C-SPC/C-@ (M-x set-mark-command)
    在单词结尾处设置标记  M-@ (M-x set-mark-word)
    选中段落            M-h (M-x mark-paragraph)
    在句末设置标记         (M-x mark-end-of-sentence)

矩形区块::

    C-space/C-@ set-mark-command    标记矩形区块的一个角（光标标记其相对的角）
    C-x r t string-rectangle  用字符串填充矩形区域
    C-x r k kill-rectangle    剪切: 剪切当前的矩形区块, 并将其保存在一个特殊的矩形区块缓冲区中
    C-x r d delete-rectangle  删除: 删除当前的矩形区块, 并不为粘贴而保存它
    C-x r c clear-rectangle   空格替换: 清除当前的矩形区块, 使用空白字符替换整个区域
    C-x r o open-rectangle    空格插入: 使用空白字符填充矩形区块, 并将矩形区块的所有文本向右移
    C-x r y yank-rectangle    粘贴:在光标处粘贴, 将所有的现有文本移动到右边









