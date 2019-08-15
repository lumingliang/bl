###### weex 走过的坑

1. node 版本要在6.x
2. 注意用weex platform list 查看当前安卓版本
3. 修改marven源到阿里云
4. 修改gradle 的build配置文件、所需库依赖为正确的安卓版本
5. 注意gradle的配置方法
D:\py3\Lib\site-packages\PyQt5;%SystemRoot%\system32;%SystemRoot%;%SystemRoot%\System32\Wbem;%SYSTEMROOT%\System32\WindowsPowerShell\v1.0\;%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;D:\32\Git\bin;D:\py3;D:\32\Lua\5.1;D:\32\web\php;C:\ProgramData\ComposerSetup\bin;C:\Users\Administrator\AppData\Roaming\npm;D:\32\Vim\vim74;D:\browserdriver;D:\phanthomjs\bin;D:\nodejs\;D:\backup\Android\Sdk\platform-tools;D:\backup\Android\Sdk\tools;


Unzipping C:\Users\Administrator\.gradle\wrapper\dists\gradle-2.14.1-all\8bnwg5hd3w55iofp58khbp6yv\gradle-2.14.1-all.zip to C:\Users\Administrator\.gradle\wrapper\dists\gradle-2.14.1-all\8bnwg5hd3w55iofp58khbp6yv

6. gradle 问题，如果不行，要将.gradle 删除，重新下载编译

7. weex platform add  android@6.0.0 添加指定版本，也可以输入一个不存在的查看可用

```
 compileSdkVersion=26
        buildToolsVersion="26.0.0"
        minSdkVersion=14
        appMinSdkVersion=15
        targetSdkVersion=26
        supportLibVersion="23.1.0"
        fastjsonLibVersion="1.1.46.android"


        maven { url "http://maven.aliyun.com/nexus/content/groups/public/" }
        mavenLocal()
        jcenter()
        mavenCentral()
        maven {
            url 'https://maven.google.com/'
            name 'Google'
        }
```
