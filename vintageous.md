title:vintagous 是vim simoulor在 sublime text 中的一个加强版
---
1. 用 package Controler 安装
2. 安装后，修改C:\Users\Administrator\AppData\Roaming\Sublime Text 3\Packages\User 下的Default key map 把k j 映射成Esc 

3, 命令行时候的快捷键，C-a :go to bengining ,C-e :end; C-f:right ;
    C-b : left;
4, C:\Users\Administrator\AppData\Roaming\Sublime Text 3\Packages\User ，新增文件Default.sublime-keymap,
增加
```
[
    {
        "keys": ["k", "j"],
        "command": "_enter_normal_mode",
        "args": {
            "mode": "mode_insert"
        },
        "context": [{"key": "vi_insert_mode_aware"}]
    }
]
```

M-S-n ,分屏