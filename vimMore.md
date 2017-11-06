#### vim的一些升级用法

安装vdebug ,可以远程调试

:echo has('python') 看有没有改模块支持

:nmap 查看所有可用快捷键

1. :ls   列出所有缓冲区
2. :bdelete #numb     删除所要关闭的缓冲区

##### tag 的一些用法

:ts /[ reguration ] 列出匹配正则表达式的tag

ctags -R --languages=c++ --langmap=c++:+.inl -h +.inl --c++-kinds=+px--fields=+aiKSz --extra=+q --exclude=lex.yy.cc --exclude=copy_lex.yy.cc

// 告诉ctags只针对php语言生成，以及.json后缀也是php的
ctags -R --languages=php --langmap=php:+.json+.md
