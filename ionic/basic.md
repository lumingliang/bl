##### 基本环境的设定和配置
1. nodejs 安装好
2. 安装阿里的源
3. cnpm install -g ionic cordova
4. ionic start --v2 projectName tabs
5. 如果4 遇到问题，切断后，cnpm install
6. ionic serve试试问题
7. 安装java
```
Java_Home  D:\Java\jdk1.8.0_111
CLASSPATH .;%Java_Home%\bin;%Java_Home%\lib\dt.jar;%Java_Home%\lib\tools.jar
Path ;%Java_Home%\bin;%Java_Home%\jre\bin;
Path C:\Users\Administrator\AppData\Local\Android\Sdk\tools;C:\Users\Administrator\AppData\Local\Android\Sdk\platform-tools
ANDROID_HOME C:\Users\Administrator\AppData\Local\Android\Sdk
adb path要配置在android sdk 里面
```
8. 安装andoid studio ，安装后会自动整合Java_Home，选择common，安装好各种需要的东西
9. 打开android studio，可以点击类似下载的箭头图标来安装相关android sdk包，skd里面有很多包，都是要安装的
10. 关键点，应付墙等 ，也可以直接开启vpn解决
    *下载grandle-all.zip包，把该包放到upload下，并修改F:\mye\platforms\android\cordova\lib\builders\GradleBuilder.js的 var distributionUrl = process.env['CORDOVA_ANDROID_GRADLE_DISTRIBUTION_URL'] || 'http://upload.local.jiliha.com/gradle-2.14.1-all.zip';
    *修改F:\mye\platforms\android\CordovaLib\build.gradle
    ```
    repositories {
      jcenter {url "http://jcenter.bintray.com/"}
      //  mavenCentral()
    }
    ```
    *修改
    ```
    repositories {
      jcenter {url "http://jcenter.bintray.com/"}
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:2.2.0'
    }

    repositories {
      jcenter {url "http://jcenter.bintray.com/"}
    }
    ```
11. 模拟器使用
；
12. 添加crosswalk 支持
```
cordova plugin add cordova-plugin-crosswalk-webview
cordova build android
```
13. 安装的插件有
```
whiteList 用于访问http，如果没有这个插件将无法访问http的
```

#####
安装gradle : 到https://gradle.org/install/#with-a-package-manager，下载后放到某一个目录，最后再环境变量里面配置到bin
##### 谷歌联调
1. 打开开发者模式
2. 手机打开app，电脑谷歌进入chrome://inspect/#devices
3. 等待稍稍，点击某个页面即可


