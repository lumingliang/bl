title : 讲述yii的架构和一些有用用法
----

#### yii 
是一个超高集成化的php框架。严格mvc架构，对于建站是紧密的前后端，并且提供了优雅的restful服务。对于建站，提供了常用的html助手模板；并且拥有比较全的ROM。

yii 中三个比较重要的内容，组件(一系列功能类), 小部件(一系列与php端生成交互view片段的助手类), 模块(拥有mvc内容的独立小模块),其实这些在laravel中都可以称为服务，还有一个比较有用的特点是，yii中的model是包含了表单和数据库交互两种类型的。业务逻辑(如验证等写在model或者全局中)

##### 入口script
每个应用都有一个入口script,在yii中

1. 该script先定义一些constants,如degbug(拥有更多的消息), err_handler(错误级别等),
2. 注册composer autoloader
3. inclue(引入) yii 类文件, 引入配置文件，引入环境配置文件。
4. 创建application实例
5. run() 方法运行

##### 请求声明周期

1. 开始的初始化，入口文件配置，run等。
2. 加载组件request.component ，并利用它处理请求url路由匹配等。
3. 到达controller ,执行mvc模式事情，其中会调用组件,widget等助手类，直接产出html片段
4. module其实就是一个包，里面包含了route, 小型mvc等
5. 途中会经过多个filter,然后最后调用response.componet

##### 表单数据
与laravel不一样的是，表单数据laravel中是直接将数据变为一个请求数组，而yii中将其数据看做是模型model,yii中有两个model，另一个是Activerecord;这个是与数据库相关的。

##### 数据库交互
请求来临时，先是接收请求，然后是根据配置连接数据库，接着引用该数据库连接，然后创建一个属于该请求的activerecord实例，controller内调用该实例的方法，并返回view。

**必须先创建好数据库和表，接着保证php安装了PDO扩展，以及相应的mysql-pdo扩展，

配置config/web.php,该文件会被config/web.php包含 

1. 查询find() 会查找所有，或者是通过多条函数拼接成一个查询语句，提高查询效率，
2. controller中的 page等方法,取得查询必要数据并返回给视图,视图接收后由weget助手打印出来

数据库交互有两种方法，一个是orm一个是db


```
Yii::$app->db // 获取yii数据库连接实例
```

#### 整体架构介绍

##### 请求来临时，先进入入口文件，入口文件中会初始化一个application实例，该实例包含了所有必要的东西。application有一些重要的属性，如id,basePath(可以被其他地方引用)

##### bootstrap 里面就像laravel的bootstrap一样，可以在里面定义一开始就要运行的类、组件、以及相应的配置。

不管是类、组件等在bootstrap中注册，(注册时可以附加配置),之后都可以根据Yii::id(id是该组件的id，或者说别名), 然后就可以在其他地方使用

controllermap 属性，默认应该在config/web.php中，这里可以指定控制器匹配，如在url中r=some 就是匹配somecontroller

module属性，配置model别名和配置

##### 事件behavior
一个请求来的太快，事件其实就是在从请求到响应中的钩子，某个运行段时会启动某些类的方法。这里面会经过好多类，各个类都有不同的功能，php全部使用数组作为配置，标记等

##### 命名规则

骆驼峰或者-

##### actions 

actions就是controller的方法，这个方法可以分为两种一种是内联的，即写在controller中，一种是单一动作，可以被大家共用，因为它附加在yii\base\action类中,实际上就是把需要重用的action写在一个大家都易于访问的地方 

定义单一action需要继承yii\base\action类，并把该action写在该方法中，然后使用时，要在当前controller中用actions()方法使用,只要在actions方法中有了应有声明，那么就可以使用该声明中的多个action

##### 模型
laravel中model直接包含了属性(对于数据库表的域),还有model从基类继承过来，会拥有很多内置的方法，这些方法直接将取得的数据放入属性中。

model中可以定义使用场景，以及生成标签，一些常用的功能，最主要的，有rules方法，会自动验证各个域(属性)

```
批量赋值,一个表单可以用一个模型来表示

$model = new \app\models\ContactForm;
$model->attributes = \Yii::$app->request->post('ContactForm');
```

还有一种情况，就是批量赋值时有些属性可以批量，有些不允许批量，yii中safe unsafe

还有一个数据输出(fields)，如laravel中方便的toJson方法，可以作为接口向外输出规则数据。数据输出可以定制输出的域，及在所有属性中你想输出哪个，不想输出哪个可以设定

model最佳实践，因为随著业务逻辑的增加，model会越来越厚，然后最好是把一些公用的model逻辑写在一个basemodel中，到时候继承即可


#### 视图

yii 视图和laravel有很大的区别，使用yii的视图和weget可以在没有或者很少js的条件下，创建一个经典bootstrap视图

视图其实就是php echo ，在控制器或者某个地方调用render方法即可得到视图，视图可以以数组形式注入一些变量，当然视图默认注入了$this,和$model变量。使操纵极为方便

##### layout yii中的布局非常好用，布局是一个application > module > controller 中会标识好layout,层层寻找，最后会寻找在application中定义的layout,在使用render方法时，如render('/main') 就是绝对路径，会直接找application中的layout

新的layout可以镶嵌base layout
```
<?php $this->beginContent('@app/views/layouts/base.php'); ?>  // 声明baselayout 

...child layout content here...

<?php $this->endContent(); ?>
```
此外，**在view中也可以使用render方法**，渲染其他小视图

** 定义block ** block也比较方便强大，yii中视图一般由两部分构成: view + layout ,在view中定义block,可以在layout中显示，极为方便

静态页面视图，静态页面可以使用传统的render方式，但是试想一个目录下有多个静态页面，那么每个文件都得定义一个render action会比较繁琐，所以，最好的办法是使用actions	

```
class SiteController extends Controller
{
    public function actions()
    {
        return [
		// page目录下的都是静态文件，yii会自动搜寻
            'page' => [
                'class' => 'yii\web\ViewAction',
            ],
        ];
    }
}
```

如在@app/views/site/pages 目录下有个about静态视图，那么可以用路由http://localhost/index.php?r=site%2Fpage&view=about 访问
```

public function actions()
{
	return [
		'error' => [
			'class' => 'yii\web\ErrorAction',
		],
		'captcha' => [
			'class' => 'yii\captcha\CaptchaAction',
			'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
		],
		// page为路由前置参数
		'page' => [
			'class' => 'yii\web\ViewAction',
		],
	];
}

```

于是所有在pages下的文件都可以访问了


#### module

 一个module就类似一个子组件(从apllication镶嵌而来),拥有自己的mvc架构;并且有自己的私有配置class，每个moudule的资源如组件，小部件等都可以被其他module访问

module只需要在application全局注册位置即可使用，内部结构和用法和application一致，另外module可以内部镶嵌，同时路由写法也是需要前置module id作为路径，最好是module id和module名一致
	
module使用di来自动启动

module视图中的layout怎么配置?


#### fiter

fiter是在application , module, controller中处理前后运行的代码(类)等，在里面配置后，可以每次运行,类似中间件

controller 的 behaviors()中定义了哪些action会使用filter

创建filter时需要定义beforeAction, afterAction两个方法，在里面就是这个filter的处理前后逻辑

其中如验证用户，监测http请求是post get等都是写在filter里面,yii中有很多有用的内置filter

#### wegets

weget是一些视图相关的插件，就是类似jquery插件，而且这些插件可以直接在服务端配置渲染，非常方便，基本无js操作

小部件的创建就是在一个适当的目录里面有个小部件类，该小部件类有两个重要的方法，一个是init用来配置属性，一个是run() ,用来渲染视图，在run()方法中也可以使用render,渲染镶嵌更多视图,默认情况下，weget中调用的view的路径是在wegetPath/views目录下

```
// 创建在app\component下
namespace app\components;

use yii\base\Widget;
use yii\helpers\Html;

class HelloWidget extends Widget
{
    public function init()
    {
        parent::init();
        ob_start();
    }

    public function run()
    {
        $content = ob_get_clean();
        return Html::encode($content);
    }
}


// 使用

<?php
use app\components\HelloWidget;
?>
<?php HelloWidget::begin(); ?>

    content that may contain <tag>'s

<?php HelloWidget::end(); ?>
```

#### web(js, css,img)资源管理

yii中有一个完善的资源管理机制，如使用DatePicker小部件时，由程序自动寻找相应的js文件等，当相应的资源有了更新后，会直接自动链接到更新的资源。

##### Asset Class
资源类，每份资源都是一个独立的文件夹，里面包含了css,js等，这些资源的位置、加载时的钩子等都写在一个配置类中。

yii中对资源做了一个分类，因为为了更好的代码管理

1. source assets (在view中  等)
2. publish assets ( 在web目录下，常常需要把source 资源复制到 web目录下，这个一般由yii自动完成 )
3. external assets ( 一些额外的资源 )

assets依赖是跟必须先打开jquery才能用jquery ui是一样的。必须先打开前面的资源，再打开现在的资源 

另外还可以通过设定$cssOptions 等来确定ie几下会使用这个资源(其实就是 创建一个html判别)

Assets 实际上就是yii调用一个类来生成读取资源的代码，该类的调用写在视图中，用来自动调用
```
use app\assets\AppAsset;
AppAsset::register($this);  // $this represents the view object
```
yii 会读取里面的配置，来对资源进行加载

如果在wiget中调用该Assets类，那么需要指定该wiget所属的视图，以便yii根据类把资源引用url代码注入到视图的head等中。

AppAsset::register($this->view);  // $this represents the view object

可以在配置中对每个assets类进行从新配置,以便适应更动态的要求
```
'components' => [
        'assetManager' => [
            'bundles' => [
                'all' => [
                    'class' => 'yii\web\AssetBundle',
                    'basePath' => '@webroot/assets',
                    'baseUrl' => '@web/assets',
                    'css' => ['all-xyz.css'],
                    'js' => ['all-xyz.js'],
                ],
                'A' => ['css' => [], 'js' => [], 'depends' => ['all']],
                'B' => ['css' => [], 'js' => [], 'depends' => ['all']],
                'C' => ['css' => [], 'js' => [], 'depends' => ['all']],
                'D' => ['css' => [], 'js' => [], 'depends' => ['all']],
            ],
        ],
    ],
```

##### urlmanager

即路由相关类，是属于一个类似数据库连接的组件类，当访问来到时，会调用该urlmanager来解析钱来的额url，得到prameters等，同时也可以利用它来产生相应的url。

可以配置多个urlmanager，然后可以利用某个特定的urlmanager rules规则来产生url，当前对于特定的app，只有一个urlmanager处理url解析。urlmanager只是个别名，需要在里面配置某个url解析类，如基类。

##### 响应流程

控制器，到afterAction，再到serialiser，再到respo josn化
