title: 讲述解读yii源码的一些重要信息

-----

##### php auto load 机制

php中有个函数 spl_autoload_register([ 'className', 'funcName' ]) ; 当实例化不存在的类时，会自动调用这个方法，里面的类的某个函数，从而达到自动加载，composer的autoload应该就是用这个实现的。

##### php namespace use

php 中不允许两个类名相同，即如果/path1/class /path2/class 类名即文件名(好处是一个文件就是一个类，利于识别) , 如果两个同时加载，就会出现致命错误，因此有了利用前缀的机制，如/path/p_class 
/path/p2_class 这样就不会类名重复，但是这样会增加代码书写量，因此php引入了namespace, 利用namespace达到了与运用前缀异曲同工之妙的更加简洁的方法，有了namespace后允许使用相同类名，并且有了use的自动识别加载
```
inc.php

namespace Zend\Http\PhpEnvironment;
class Bar {}//定义了一个类


// 访问Bar的第一种方法，用全称
require 'inc.php';
$foo = new \Zend\Http\PhpEnvironment\Bar();


// 访问Bar的第二种方法
namespace Foo; // 调整当前脚本到Foo这个ns域，而且namespace申明必须在第一句
require 'inc.php';
$foo = new Bar();
```

use 关键词可以实现别名


yii 启动，component为核心要按需加载的类，这些类会在第一次使用的时候注入到依赖容器Yii::$container 中, yii中的核心类不需要指定类的位置，因为内部有代码指定了'class' 位置，非核心类和自己定义的全局类都要指定'class' 和一些config yii在这些类被取出时，自动调用某个方法来实例化这些类，这些类的引用都放在了Yii::$app全局静态中。

启动时会首先调用某个类，比如调用url管理类，然后调用某类，实例化controller，执行view方法等等。

php abstact 方法是个类，必须实例化才能使用，但是里面的方法可以是真正的和抽象的，抽象方法必须实现，真正方法在继承它的类中可以直接使用, 抽象类用来继承使用


为什么Yii是全局类，因为Yii有自动加载，在整个程序中都在使用它，所以就变成全局的了。。所有的组件等都绑定在了Yii::$app变量中，所以就使得Yii真的变成了全局类

为什么用Yii::$app可以使用，因为Yii在一开始就加载了，在任何命名空间下只要用 \Yii都能引用到了, 或者use Yii关键词，可以使用到全局类

yii中app类先将所有config数组内的内容进行解析，一方面用来对app类自身进行配置，一方面直接存在compoent变量中。当程序需要用到db组件类时，就是往IOC实例中通过特定方法取出，该方法会分析是否当前存在该类，如果不存在就往这个compoent变量中通过对应id找到配置信息并实例化,或者换一种思维，实际上就是将所有compoent组件类的配置注册到IOC容器中，以便备用，之后所有的组件类操作都是从这里取出
