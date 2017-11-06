##### 单元测试
在yii2中利用codeception进行单元测试，可以实现减轻后面程序扩展的测试负担。减轻重复的工作
安装、配置方法
```
composer global require "codeception/codeception=2.1.*"
composer global require "codeception/specify=*"
composer global require "codeception/verify=*"

```
如果全局安装失败，会在vendor 目录下面得到codecept 
进入api/common 目录，执行../vendor/bin/codecept bootstrap
创建一个特定的suite如api，unit,等
配置逐步继承，其中codecept自带了各种测试工具、如 rest
但是要与yii2 框架融合，则需要配置下
Yii2:
    configFile: 'config/test-local.php'
以及在_bootstrap写
```
defined('YII_DEBUG') or define('YII_DEBUG', true);
defined('YII_ENV') or define('YII_ENV', 'test');
defined('YII_APP_BASE_PATH') or define('YII_APP_BASE_PATH', __DIR__.'/../../');

require_once(YII_APP_BASE_PATH . '/vendor/autoload.php');
require_once(YII_APP_BASE_PATH . '/vendor/yiisoft/yii2/Yii.php');

$rootPath = dirname(dirname(__DIR__));

//加载env方法
require($rootPath . '/env_helper.php');

//加载环境变量
$dotenv = new \Dotenv\Dotenv($rootPath);
//正式环境中，会在服务器环境中加载.env，不需要通过程序加载
if (env('APP_ENV') != 'prod') {
    $dotenv->load();
}

require_once(YII_APP_BASE_PATH . '/common/config/bootstrap.php');
require_once(__DIR__ . '/../config/bootstrap.php');
```


然后就是加入(fixtrue)模块了用来固定数据的测试了，原理是，把数据库情况，导入固定数据，当测试完毕再把数据库还原

yii-test.bat实际上就是调用测试配置在test数据库进行console动作

codecept build 创建演员，演员拥有了各种内置方法来实现测试

php codecept generate:cept acceptance(类型如api等) Signin(名字).


codecept run [api] [--step] 特定场景下的test [是否查看详细步骤]
[http://codeception.com/docs/02-GettingStarted]

全局

```
# global codeception file to run tests from all apps
include:
    - common
    - frontend
    - backend
paths:
    log: console/runtime/logs
settings:
    colors: true
```


```

codeception.yml
namespace: backend\tests
actor: Tester
paths:
    tests: tests
    log: tests/_output
    data: tests/_data
    helpers: tests/_support
settings:
    bootstrap: _bootstrap.php
    colors: true
    memory_limit: 1024M
modules:
    config:
        Yii2:
            configFile: 'config/test.php'
```

```
api.yml

class_name: ApiTester
modules:
    enabled:
        - REST:
            #url: http://api.local.shangcars.com
            depends: Yii2
            #depends: PhpBrowser
```

常用命令

```
generate:test unit Example

..\vendor\bin\codecept generate:suite api 创建一个api测试包
..\vendor\bin\codecept generate:cept api Test 创建一个api测试文件
..\vendor\bin\codecept build 生成必要文件
..\vendor\bin\codecept bootstrap --namespace frontend
..\vendor\bin\codecept run [ -- -c backend]

新建单元测试文件
..\vendor\bin\codecept generate:test unit models\aa
..\vendor\bin\codecept generate:test unit(指定使用的套件) models\aa


```
[参考](http://codeception.com/docs/08-Customization)

######  测试分为4种
api、单元(测试某一个函数)、funtional(功能测试，不用发出服务器请求，只是模拟post、session等数据)、受理测试（模拟用户和浏览器交互）
测试用例要尽量搞对错两个场景

yii2 中还加入了一个fixture类，家具类的作用是在测试前期把数据装入数据库、后期把数据清理掉，达到了给数据库设定一些一致性测试数据的效果
fixtrue 类可以放在common中，继承arfixtrue ，它的数据放在teest 文件夹的_data，当然也可以自定义它的data file位置和指定它的依赖

使用fixtrue时，需要在test类中的fixture里面声明

##### 心得
在codecept 中用yii 的话，其实就是类似一个console应用。
用原生的php browser 也有它的好处，不过无法实现本地调试

