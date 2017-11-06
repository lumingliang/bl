title: some tips for yii learn
-----

#### 架构方法
主要架构方法是利用一个数组配置一个类，一个配置文件中返回一个多维数组，数组的key是配置的项目区分，下一级key是一个要配置、要使用的类，与平级的相当于传入的init初始化值

#### migration特殊方法
migration中有一些创建数据库表字段的方便方法，这都是定义在QueryBuilder class 的$typeMap中

#### 行为behaviors
绑定行为到一个组件、类中，那么这个行为的所有属性和方法就相当于在该类本身中一样，是trait用法的一个扩展。但是它可以响应附着类的事件。

有些行为里面的方法会在绑定到类后自动运行，因为它实现了类中的某个事件。行为也是一个类的对象。

上述思维真正的姿势是，behavior类里面有个events方法，这里定义了该behavior中的那些方法会在它附着的类中的某个事件时自动触发。

##### controller中filter是behavior

filter 实际上也是一组behaviors,filter中规定了在controller,等类中什么时候使用该filter,filter默认在controller中对每个action执行,因为它有before action after action方法。

filter类似中间件，有before after方法,filter可以配置only, eccept属性，可以确定应用在哪个action，在moudle中使用filter时，对应routes属性，可以配置只在哪个路由中应用。

filter用在user验证中，会从上到下一一匹配应用规则。

#### 一些包的用法

yii 中自带了captcha组件，该组件的用法是，获取路由是在控制器中的actions 定义，然后就是视图中调用一个助手组件获取，认证是在表单对应模型的rules中


#### model中有两个model,一个是无数据库相关，即form, 一个是active record,这个是与数据库相关，一般是表单如果能直接关联数据库，那么简单的逻辑的会直接用ar,但是如果是比较复杂的会先表单关联form model,然后form model间接调用与数据库相关的逻辑，


##### ar 相关用法剪辑
```
// static 是因为为静态方法,这里直接把实例存入model中
return static::findOne($id);
//return static::findOne(['access_token' => $token]); //另外用法
return static::findOne(['access_token' => $token]);
```

##### 如果一个模型被多个场景利用，如User model可以登录，注册，而且登录注册的明显区别是， label会不一样，相关性是都是需要对User表操作，那么更好的方法是定义两个中间model,这样会比使用场景好多了。

注意：model的属性因为并没有和数据表相关，所以要自己定义，但是如user ar model所有属性会和数据表相关，因此不用显式定义数据表里面的属性

***  上面提到的，反而理解错误了，ar内不能重新定义与数据表字段一样的属性！ ，否则报错 ***

##### 对于不知名，无显示文档的用法，需要在yii页面查找一下类的帮助文档，并且结合已有模仿使用。

##### try catch 防止异常

##### yii 获取状态标识
1. 获取controller id
```
// 获取controller name
$this->getId() // controller中运行得到当前controller id
$name = Yii::app()->controller->id // 在视图中

// 获取action name
// 应该在beforeAction() 中运行
$name = $action->id;

$this->getAction->getId;

视图中获取当前模块id
$this->module->id;
```

##### filters 中间件，所有请求必然是先过application , module , controller ，filter是运行在controller中，当在application, module中定义了filter时，该filter将会在其所属的action 下全部使用

##### http 状态码
403 不准访问
401 未授权o

##### redirect ,后面的url需要用助手生成


##### filters 使用
filters应该写在behaviors 方法里面，一定要参考原始出现的方法,并且不能在一个controller内置空behaviors

##### php list方法
list ($id, $authKey, $duration) = $data;

##### $model->load()方法可以多赋值。
但是如果生明了一个属性为unsafe时，该属性就不会被load()方法赋值，如果需要对该属性赋值，需要调用$model-> 方法显性赋值
```
可以在model中使用rules对某个属性设定为非安全的，另外，非安全属性也可以将其设定为private;
```

##### model 必须自带rules方法，不然无法通过load方法多赋值

连续创建多个数据行时，要注意需要重新实例化多个实例


##### php 循环方法,数组判断是否存在 
```
// for 循环, foreach( $array as $key => $val )

或者 if( in_array( 'string', array ) ) //  判断数组中是否存在 这个string
```

##### haitou,等advanced的安装

advance  中将各个应用独立起来，各个应用有个公用的模块，以及写公用的脚本，composer.json等，还有一个vendor目录

每个应用对应不同的域名，通过在vhosts总配置不同的域名可以抵达该应用的web，index.php文件，该文件里面配置了所有的启动逻辑

1. 首先需要调用vendor下 的auto-load文件，其中vendor目录是可以随意放置的，因为只要命名空间可以抵达到即可。
2. 然后应用内部会调用enviroment 目录下的配置文件，该目录也是可以自由放置的 ，只要找到就行。
3. 然后就进入本地的配置，即config/main.php,接着就是进行一些跟basic同样的事情了。

advance 启动介绍

 advance 启动，域名定位到app  的web/index.php下：
 1.  index.php 定义当前运行环境，dev,pro ; 
 2. 加载autoload Yii.php
 3. 加载common/config/bootstrap文件，该文件主要是配一些数据库相关的配置
 4. 加载/common/config/bootstrap 主要是定义一些独立app的目录别名
 5. 加载/config/bootstrap 因为该目录是独立应用下的目录，主要加载自己定义的启动配置，可为空。
 6. 加载common目录和app目录下的main main-local配置文件，这两主要是分公共使用及非公共使用，主要定义一些组件，类的使用的路径、配置信息等. app/config/main文件还可以自己引入一些param, param-local配置参数文件。配置参数文件, 还要配置当前app使用的控制器命名空间等独立应用信息。 
 7. 引入配置文件，common/config/main 

enviroment 文件夹里面存着所有app的文件，作用是保存着所有app的配置文件， 当开始使用php init时，就是yii中的一个初始化，即把enviroment文件下的内容复制到相应的app的config目录下。

compenent 一般在启动时会开启一些组件类，如db, url, mail等类，主要用来全局使用，另外还可以配置多个类似的db类，在ar中重写getDb() 方法来使用。


##### 类的使用，其实在所有代码中，都是一种对类的使用。

类的配置可以在compenent 中，写在compenent的config中时，是和__contruct函数写是一个道理，当然所有配置都可以在拿到该类的实例后重新配置。

##### component

yii 中自带了一个yii\base\Object, 提供了一个适用于yii的最基本的类（php中类就当对象来用吧）中类就当对象来用吧。

还有一个组件原始类，yii\base\component ,从base 类中继承而来的。

这些类内置了很多方便的有用的内容，如event,behavior;yii有个创建类的实例的方法，也就是类似laravel中的容器，yii::createObj([class, params]);

yii中实现了setter , getter方法，方便监听在取值，赋值时的行为，是php内置来实现的。类似魔法方法之类。

yii scenarios 场景，最初作用是，可以定义场景，当选择某一个场景时，只选择有限个可用的property, 以及这些property可以直接同时多个赋值。

yii 中用behaviors作为扩展类的一个类似trait的东西， filters是传统的过滤器。

##### 区别rules和behaviors 

rules 是一组中间件，每次经过继承了base/model基类的类中时，都会自动调用rules内定义的验证规则（这些规则是由相应的验证类的方法实现的）。通过调用validate方法使用里面的验证方法，验证是否通过决定了能否进一步进入更深的逻辑。

validate 方法调用时的执行流程：按数组最外边的key决定是哪个属性，然后对该属性应用相应的验证器，是否成功，如果成功继续下一步。

```
// rules 的内容是一个多级数组，决定了model内每个属性的验证规则，以及可以决定在某个场景下的属性的验证规则。

public function rules()
{
    return [
        // username, email and password are all required in "register" scenario
        [['username', 'email', 'password'], 'required', 'on' => self::SCENARIO_REGISTER],

        // username and password are required in "login" scenario
        [['username', 'password'], 'required', 'on' => self::SCENARIO_LOGIN], //self::SCENARIO_LOGIN 是本身的静态属性。
    ];
}

// 在rules中定义验证规则的格式如下
[ ['attribute1', attribute2], 'validator'(是一个内置验证器别名，或者一个类名), 'on' => ['scenario1', scenario2](场景名), 'property1' => 'value1', (定制对眼实例化的验证类的属性值) ];

每个属性的rule不仅仅是验证功能，还可以对表单值预处理.

```

做自己的验证器,继承验证基类，并重写对应的方法。

##### 使用gii生成代码

gii是yii下的一个模块，配置引用在$config变量下的modules属性中

gii可以针对每一个表来生成crud代码，自带分页、查询，非常方便强大

注意在advance中，命名空间是以app名起头，如frontend

php url： urlencode, urldecode

##### 多表单，批量赋值 

批量赋值指：同时像同一张表中插入多条数据，每条数据对应一个model，还有每个model都可以动态添加，验证，save等. 

还有一种多表单，就是一个页面有多个表单，每个表单对应不同的model,这不同的model来自不同的表.视图方面，考虑一个表单，多个表单域。然后可以通过$app->request->post('fieldName', []); 或者直接$app->request->load()就可以自动把特定的域装进特定的模型中了。

##### 数据库数据获取到展示过程

1. 由请求参数决定后续操作
2. 利用$query封装查询语句
3. 把query装载入dataprovider,dataprovider其实就是进一步构建查询语句
4. 接下来就是排序，sort对象用来对上面的结果来排序. dataprovider的sort属性封装了该对象
5. 最后装入datawiget

##### yii中的interface, trait, class

interface是接口，定义了一些主要的公共方法，接口就会有多个类实现它，类实现接口是包容关系，即实现它的类可以有比接口声明更多的方法，因此，php中可以用基类来实现一部分公共的方法，然后用继承来继承它，从而拥有更多的功能，但是php中有个trait，trait可以更容易的共享代码，省去了继承的麻烦。

##### yii统一命名规则

数据库：骆驼峰
表：_下划线
表的字段：_
中间表：tbl_user_market market_id, user_id
控制器、model：首字母大写骆驼峰
视图：首字母小写骆驼峰
controller, model, view 的id，用-联结


##### yii,一对一，多对对，一对多关系声明

必须首先理解查询的本质
一对一: user: id name ; profile id content userId
那么查询的时候，在user中查profile, 需要select profile * where userId = id
yii中User model声明: getProfile() hasOne(Profile, ['userId' => 'id']);

需要在profile中找user， select user * where id = userId
yii中getUser() hasOne( User, [ 'id' => 'userId' ] );

一对多：user: id name ; posts: id content userId
user中查询多个文章: select posts * where userId = id
yii中 User model hasMany( Post, [ 'userId' => id ] );
逆向， select user * where id = userId
yii中getUser() hasOne( User, [ 'id' => 'userId' ] );

多对多

user: id name ; market : id name ; tbl_user_market : id userId marketId

user中查询多个market: 
select tabel tbl_user_market market_id where user_id = id
select tabel market where id = market_id

yii的User model : hasMany( Market, [ 'id' => 'market_id' ] )-viaTable('tbl_user_market', ['user_id' => 'id']);

实际上就是构造了两条查询语句，简化操作而已。。。

插入跟新时，先在user表插入，再在market表插入，然后再在tbl_user_market中插入user_id , market_id; yii中也提供了简洁方法，即$user-save(), $market->save() ,
$user->link('markets', $market) ;自动对junction表进行更新
即取出两个关联的模型，(可以用find方法取出，不管有没有运行save);


**本质**就是根据表的结构构建一个查询语句而已, 如
一对多: user: id name postId ; post: id content

仍然是一对多，但是表的结构变化了，user中查post: select post * where id = postId; 因此yii中的hasMany('Post', [ 'id' => 'postId' ]);

反过来， select user * where postId = id , yii中hasOne也同样构造

hasMany 方法就是当前记录集中findOne(1) 中的数据是多个，然后需要在另一表中对着多个都进行查询


##### routes 路由

yii 中路由非常方便，因为有了默认的路由组件来管理，默认的路由组件负责把url解析，并按照默认的规则寻找controller和view，同时可以自己指定自己的url解析规则，来覆盖掉默认的解析规则。

路由配置方法
```
// 同时配置多个路由，特定路由有特定的规则
[
    // <name: RegExp> 架构,如果不指定正则，如<name> 就是指url?name='string',只要是没有下划线的都可以,(这里其实不完全是/ 规则，在没有/规则时，用?开始实现参数)
    'posts/<year:\d{4}>/<category>' => 'post/index',
    'posts' => 'post/index',
    'post/<id:\d+>' => 'post/view',
    // 或者
    [
    'pattern' => 'posts/<page:\d+>/<tag>',
    'route' => 'post/index',
    'defaults' => ['page' => 1, 'tag' => ''],
],
]

当然，还可以集成controller, view 参数在里面，更方便
```
// 集成
[
    '<controller:(post|comment)>/<id:\d+>/<action:(create|update|delete)>' => '<controller>/<action>',
    '<controller:(post|comment)>/<id:\d+>' => '<controller>/view',
    '<controller:(post|comment)>s' => '<controller>/index',
]

// 还有更高端的，链接前缀匹配


[
// 该路由前缀直接匹配到后面的实际位置
    'http://admin.example.com/login' => 'admin/user/login',
    'http://www.example.com/login' => 'site/login',
]
```
每个路由都是一个UrlRoute类的实例，该类用来解析路由，而UrlManager是用来管理路由类的。UrlRoute中有个重要的属性$host ;用来配置虚拟主机，也就是如果项目部署在/wwwroot/app/web 下，又不想改虚拟主机配置，就可以修改路由配置，配置每个路由的虚拟主机为www.com/app/web ，这样就可以啦！


Yii中通用配置，数组，第一个参数是类名，后面的参数是配置，如果第一个参数不是类名，就是默认的类


##### Yii中重要的东西:components object 

object是yii扩展普通类的的东西，有_get,_set等方法，而components是更高级的类，有事件event 和 behavior ,事件可以用来在类的使用时自动化某个方法的调用，而behavior就像是对类的扩展一样，使该类就像拥有该behavior里面的属性和方法一样

object基类有属性特点，属性特点就是说，比如getLabel这些方法，会在取值时自动运行，达到更好的自定义取值


##### php 接口
接口和其他的一样，只有方法，但是可有静态常量，实现接口的类必须实现接口的所有方法，实现接口的类的属性可以各不相同，如果类并没有实现接口的全部方法，必须将此类定义为抽象类。

一个类可以实现多个接口

js中，接口就看做是一个类型约定。

*抽象类*

```
abstract class AbstractClass
{
    // 我们的抽象方法仅需要定义需要的参数
    abstract protected function prefixName($name);

}

class ConcreteClass extends AbstractClass
{

    // 我们的子类可以定义父类签名中不存在的可选参数
    public function prefixName($name, $separator = ".") {
        if ($name == "Pacman") {
            $prefix = "Mr";
        } elseif ($name == "Pacwoman") {
            $prefix = "Mrs";
        } else {
            $prefix = "";
        }
        return "{$prefix}{$separator} {$name}";
    }
}
```

抽象类和接口一样，实际上都只是优化代码作用，接口和抽象类都是无法实例化的，抽象类是被子类extend的，抽象类里面声明的protectd 方法是必须被子类实现的，并且子类实现 abstract protected方法时，可以增加一些可选参数; public方法可以随意

##### yii依赖注入机制 

ioc容器：用来装所有的实例的东西，可以在该容器里面注册类A，该类如果依赖其他类B，就在该类构造器中用类型声明，然后就可以从ioc 中直接取出A,并且这个A是拿到了B的实例了。这个ioc容器就是一个yii\di\container实例

Yii的全局配置，如配置各种组件，参数，其实就是往全局Yii(ioc容器实例)里面注册类，和该类的别名，然后使用Yii:$app方法就可以取出，所有这些注册了的类都是单一的,因为yii这个全局的ioc容器，有点特殊，它是yii\di\Servilocator的实例,不知道有没有依赖注入功能？

Yii中的全局组件的配置，可以在代码运行后重新配置，如在modlue中的init方法，一般需要巧妙设置， 配置越前越早越好

可以自定义全局组件，但是要注意的是事件处理器应该提前注册,注册方法是自定义的使用直接$ob->on来注册(如果是行为),如果是组件绑定行为可能可以用on enventName 来注册，注意直接返回了一个实例,因此没有

```
//如在程序某个地方

\Yii::$container->set('yii\widgets\LinkPager', ['maxButtonCount' => 5]);
可以对全局类进行重新配置
```

注册ioc时，并不需要同时声明该类的实例化方法，因为有默认的实例化方法，至于特殊的实例化方法是需要声明的。应该是在?

##### yii 中的user组件

user组件是利用依赖注入来实现类的实例化的

使用user组件可以实现登录，验证, 一个user, 只需要配置好验证逻辑，给定一个要登录的用户实例就可以验证了,其他的事，如验证cookie，设定cookie等都有yii自动执行

密码验证层在自己上，其他cookie、后续权限控制层是在yii手上

一般流程如下

1. 用户登录页面，传递账号密码，我方代码认证成功，yii根据配置配好session、cookie等，用户2次登录，可以先判断是否存在登录用户，即isGuest;

2. 查找登录用户是否存在，在认证后，往往需要知道登录用户信息，所以需要实现findIntendify逻辑，用来找到并session全局存一个用户身份，如果是手机需要实现手机的

3.如果是手机验证，使用base auth用户身份不会存在session中，而是每次都会findIndentityByAsseToeken

4. 在需要用到验证的地方，加入behaviors即类似中间件。即可控制


##### yii中各种函数、各种类的用法

一个基类会被很多高级类继承，基类中的方法常常被重写，但是实现的功能是一样的，即输入和输出是大同小异的。看底层代码时，应追求快的节奏，即知道怎么用，是用来干嘛的。至于深层的实现则不需要深究。因为同一个函数常常有太多实现了

##### yii 中的user模块，仅在session中缓存必要的数据，并不对整个对象就像缓存，还是从数据库里面读的

只有绝对不变的少量值才在session中做缓存

##### foxmail
pass cushlogphcobxvlm


###### yii 进阶
1. url/per-page=&page=&expand=token= 可自定义查询参数获得信息
2. yii config必要配置参数：vendorPath(会涉及到插件包的使用) basePath
3. 跨域配置用cors 的beha
4. 自定义createController 可以调用yii全局方法创一个controller，不能直接new是因为还要一些其他参数 
5. provider 可以提供extarfileds 加载其他的信息，对于ar中要实现加载数据库中运算得来的字段，可以定义一下即可。

###### php 正则匹配
$new = preg_replace('//', '$1$2', $str);
yii 防注入 where('id=:id', ['id' => 'xx'])
$query->where('status=:status', [':status' => $status]);
去重，是对一行数据的去重，所以为了精确到字段的去重，需要select更少的字段

###### 调用yii的controller
$a = \Yii::$app->createController('site/bank');
list($controller, $actionID) = $a;
$action = $controller->createAction($actionID);
$controller->aa();

在beforeSave 等方法里面，千万不要搞太多事，只要有一处用不到，你就会很麻烦，要解耦
**解耦很重要，不然会很危险**
