titile: 探讨刷机的各个事项
-----
### 刷机的总工序
1. 解锁bootloader / 刷入底包
2. 刷入recovery
3. root
4. 破解电信3g
5. 刷入新rom

#### 解锁
解锁一般用的方法是，一，普通解锁，直接破解，二，高级解锁，需要moto官方数据，注册解锁。
#### 刷底包
刷底包有两种方法，一个是RSDlite法，一个是adb fastboot法
####刷底包流程
刷底包的流程是：
1. 寻找合适的底包，一般美版Us.celler可以通刷Us版的。
2. 修改flash.xml
```
//一般有以下刷写选项
fsg,有时需要删除
boot.img/system.img代表系统，需要flash
recovery.img/logo.img按需刷写
最后是删除一些用户数据
```
3. 可以用rsdlite或者adb/adb tools 刷写底包，单刷logo，re等
#### 破解3g
需要注意的是要知道解锁密码，如518518，解锁密码不对，是读取、刷写不了的
安装驱动时要注意选择另外一个选项
 root ,用re刷入supersu即可

 #### 刷入第三方rom
 第三方rom都是一些花招，结果还不如官方包好。还是少折腾
 xposed installer装个重力工具箱即可

 #### 一些基本的adb命令
 ```
 adb shell 登录到开启USB调试的手机
 adb install 一般是install 本地apk文件
 ```

