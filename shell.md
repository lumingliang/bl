() 中是命令组，新开一个进程运行， 用, 分割各个命令
$(cmd) 运行cmd后，成功则输出作为输入
(()) 运行 表达式
>> 追加
> 覆盖
[]  和test等同
if [[ $a != 1 && $a != 2 ]]    

{} 里面是变量
${var:-string},${var:+string},${var:=string},${var:?string} 用:可以对变量进行一些操作
3、四种模式匹配替换结构
模式匹配记忆方法：
# 是去掉左边(在键盘上#在$之左边)
% 是去掉右边(在键盘上%在$之右边)
#和%中的单一符号是最小匹配，两个相同符号是最大匹配。
    ```
# var=testcase    
# echo $var    
testcase    
# echo ${var%s*e}   
testca    
# echo $var    
testcase   
# echo ${var%%s*e}   
te  
# echo ${var#?e}    
stcase  
# echo ${var##?e}    
stcase  
# echo ${var##*e}    
  
# echo ${var##*s}    
e    
# echo ${var##test}    
case    

    ```

    http://blog.csdn.net/taiyang1987912/article/details/39551385

    http://blog.csdn.net/taiyang1987912/article/details/39897547
    http://www.jb51.net/article/60326.htm
