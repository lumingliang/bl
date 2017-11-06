#### nginx 配置详解
##### 反向代理

        location /ue { # 捕获请求
            rewrite ^.+ue/(.*)$ /$1 break; # 对uri部分进行重写
proxy_pass http://apps.bdimg.com;  # 只能填主机的地址，最多可以带端口号
        }

kill -HUP pid 从容的重启nginx进程，即不关掉情况下重新启动

文件及目录匹配，其中：
-f和!-f用来判断是否存在文件
-d和!-d用来判断是否存在目录
-e和!-e用来判断是否存在文件或目录
-x和!-x用来判断文件是否可执行
正则表达式全部符号解释
~ 为区分大小写匹配
~* 为不区分大小写匹配
!~和!~* 分别为区分大小写不匹配及不区分大小写不匹配
(pattern) 匹配 pattern 并获取这一匹配。所获取的匹配可以从产生的 Matches 集合得到，在VBScript. 中使用 SubMatches 集合，在JScript. 中则使用 $0…$9 属性。要匹配圆括号字符，请使用 ‘\(' 或 ‘\)'。
^ 匹配输入字符串的开始位置。
$ 匹配输入字符串的结束位置。

指令名称：rewrite
语    法: rewrite regex replacement flag
标志flag用于结束rewrite指令，它的可取值有：
last - 在搜索到相应的URI和location之后完成rewrite指令；
break - 完成 rewrite指令处理
redirect - 返回302临时重定向，如果replacement替换部分是由http://开始，它将被应用。
permanent - 返回30代码永久重定向
