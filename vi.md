
title:vim 的常规使用
----

###参照入门文章[live with vim](http://yannesposito.com/Scratch/en/blog/Learn-Vim-
Progressively/) ### 共有以下几种模式 
0. :set nu ,显示行号 

1. 一般模式 

2. i编辑模式，当前光标处插入，a,光标的下一个处插入，o，下行插入 

3. r，取代模式，只取代一次，R,一直取代，知道按下esc 3. esc,退回一般模式，:wq储存离开，:q!,不存离开 

4. hjkl,nj, 
5. c+f 下移动一页，c+d,半页 
6. c+b 上移动一页c+u,半页 
7. n<space>向后移动n个字符 
8. :wq!,强制写入并退出 
9. 0，$， dd,ndd, 
10. G,gg,nG//移到第n行 11.
11. nyy 向下复制n行
12. 保存会话，mkssesion som.vim
13. zc zo 折叠，展开代码

more about
fold](http://www.cnblogs.com/fakis/archive/2011/04/14/2016213.html) 

26. 代码中可以用//{{{      //}}} 定义折叠 

27. N c+w < [>] ,改变当前窗口宽度为增减N 
30. N c+w + [-] ,改变窗口高度  
31. qa,开始记录动作在寄存器a中
32. n @a,重复n次寄存器a中的动作，@@，重复最后一次的记录动作 
31. <leader>键，默认为\,可以用let mapleader = ","  或let g:mapleader = "," 

32. buffer, :ls 查看buffer，:b num ,切换到某个buffer,:bn bp ,上下buffer ,bdelete num ,删除buffer,bd! n ,强制删除某个buffer, bd! n m ,删除nm 两个buffer.
33. zb ,光标至于窗口底部，zt,至于顶部 
34. :/search ,搜索字符，可以用 n <n>, 或者n<N>两键组合搜寻第几个，上下等 
35. *，搜寻与当前光标字符一样的下一个字符，#,相反， 
36. 当使用gg后，``可以回到原来的位置，ma，标记改行为a,`a,跳回a行，:marks,查看标签列表 如下[,表示最后一次修改光标停留的位置，  ] 表示。。。 

37.  \< ,匹配单词开始处，\>,匹配单词结束处，如:/\<the\>,则只搜索单词the



``` js
段落(PARAGRAPH)、区块(BLOCK)
{
上一段(以空白行分隔)
}
下一段(以空白行分隔)
[{
跳到目前区块开头
]}
跳到目前区块结尾
%
跳到目前对应的括号上(适用各种括号,有设定好的话连HTML tag都能跳)

H
萤幕顶端
M
萤幕中间
L
萤幕底部
:x
xG
跳到第x行(x是行号)

. 重复上一次操作

"*yy 复制内容到系统剪切板，"*p  ,复制剪切板的内容，@*,复制剪切板中的内容
daw ,在单词中间就可以删除一个单词，(以一个文本块为操作对象),
cis, 一文本块为对象，删除整个文本块并插件新的一行,insert sentens
~ ,改变当前光标处字符为大小写，
A，光标置于行尾并insert模式
```



###  进阶,比较两个文件
1. 两个窗口已经打开:分别输入diffthis,
2. $ -d vim file1 file2
3. 已经打开一个，当前输入，vert diffsplit file2;
4. 比较后 定位不同点：[c、]c 分别跳到前一个、后一个不同点；
[参照](http://www.cnblogs.com/MuyouSome/archive/2013/04/28/3049661.html)

## 配置vim
1. 主要配置会在两个文件，一个.viminfo ,用来记录前一次使用的情况，还有就是.vimrc,相当于对它的配置;
2. 直接输入命令也是可以改变vim的表现，如:set ruler ,set noruler,若仅仅是，可以测试一个命令的变现以及用来加深理解。
3. set hlsearch 对应set nohlsearch ,但如果仅仅:nohlsearch,下次搜索时候还会高亮
```
:set incrsearch //在输入/word后就开始搜索，
：set nowarpscan ,当搜索遇到文件头尾时候就停止，
：scriptnames ,找到脚本的位置,对设置有什么用?
:edit ~/.vimrc, 新增或者编辑文件，(缩写为:e);

键映射
1. :map :imap 
2. :noremap ,避免键冲突，
3. <CR>确保命令得以执行，相当于按下enter
4. ：write !date //指执行shell命令


vim脚本，
执行用:@


### 一些重要的

1. << >> 缩进
2. n<< 多行缩进
3. = 多行智能对齐
5. C+^ , 切换缓冲区

### 查找替换
vi/vim 中可以使用 :s 命令来替换字符串

:s/vivian/sky/ 替换当前行第一个 vivian 为 sky

:s/vivian/sky/g 替换当前行所有 vivian 为 sky

:n,$s/vivian/sky/ 替换第 n 行开始到最后一行中每一行的第一个 vivian 为 sky

:n,$s/vivian/sky/g 替换第 n 行开始到最后一行中每一行所有 vivian 为 sky

n 为数字，若 n 为 .，表示从当前行开始到最后一行

:%s/vivian/sky/（等同于 :g/vivian/s//sky/） 替换每一行的第一个 vivian 为 sky

:%s/vivian/sky/g（等同于 :g/vivian/s//sky/g） 替换每一行中所有 vivian 为 sky

可以使用 # 作为分隔符，此时中间出现的 / 不会作为分隔符

:s#vivian/#sky/# 替换当前行第一个 vivian/ 为 sky/

:%s+/oradata/apras/+/user01/apras1+ （使用+ 来 替换 / ）： /oradata/apras/替换成/user01/apras1/



### 插件
1. youcompleteme ,安装步骤，
    1.1 ,将youcompleteme ,添加到.vimrc bundle,中去，PluginInstall,
    1.2 安装编译软件cmake 支持，apt install cmake;
    1.3 cd ~ .mkdir ycm_build(用来编译ycm),,cd ycm_build;
    1.4 cmake -G "<generator>" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp   ,其中generator ,依据系统而定，如果不做更改，会有提示，一般Unix系统是 Unix Makefiles
    1.5 cmake --build . --target ycm_support_libs --config Release
    1.5 make;


####  vim中执行、编译其他语言代码
```
<leader>r :!python %<cr>

autocmd FileType sometype nnoremap <buffer> <F5> :w<CR>:!somecompiler % <CR>
autocmd FileType python nnoremap <buffer> <F5> :w<CR>:!python % <CR>
```


#### 大小写转换
~ 键，可以转当前光标下的字母
U 可视模式下使用，换大写
guw 当前单词转化为小写
gUw

#### vim自带的代码跳转
1. 先用ctags -R * 在当前项目主目录下生成索引
2. vim自动搜索当前的索引来实现跳转，C+[ 跳转到函数定义处，C+t跳回来

#### gvim 进入当前文件目录
!cd %:h
map <F5> :execute "cd" expand("%:h")<CR>


##### vim diff 

比较两个文件的异同。
```
vim -d file1 file2 // 打开并比较两文件
vim diffsplit file2  // 打开file1后和file2比较

// 如果之前已经打开在需比较的窗口中输入 :diffthis
// 如果修改了vim没有自动更新比较结果，用diffupdate

// 定位到不同点

[c  跳到前一个不同点
]c  跳到后一个不同点

```

当两个文件不同时，需要将A文件的不同内容覆盖在B文件中，用dp命令(diff put)
do  将差异点的另一文档的内容拷贝到当前文档（diff get）

##### vim 的强大记录器
1. qa 表示将记录存在于a记录中
2. 进行一些列可以重复的操作
3 n@a 重复n次2中的操作

