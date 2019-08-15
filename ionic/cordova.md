###### 
cordova

5.1.0 可以运行在4.4 5.1 6.0
加cr2.1.0 4.4 5.1 可以 6.0不可

5.1.1 不用cr可以 直接默认会安装cr 2.20以上，这个版本装不了，强制安装到2.1.0 仅替换builders/ gradel.zip那句话 
5.1.1 调试不了，不用cr，可以6.0 5.0
结果用不了，解析包出问题

c6.0.0 cr默认装cr2.4.0可以，但是没有cr不能调试

```
 cordova platform add android@6.0.0
cordova plugin add cordova-plugin-crosswalk-webview

cordova plugin add cordova-plugin-statusbar

cordova plugin add cordova-plugin-navigationbar
 cordova plugin add cordova-plugin-file-transfer
 cordova plugin add cordova-plugin-file

 cordova plugin add cordova-plugin-device

```
5.30 发现编译不了

```
cordova create default com.sc.ads 物联互动
cordova platform add android


```

目前采用cordova 5.1.0 配crosswalk 2.1
c05.0文件夹内
# 对于开机启动，目前设置为主屏幕软件自动启动不了
