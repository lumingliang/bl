## laravel 的深入学习与创建一个完整的blog
---
### session,cookie
为何有session和cookie这两样东西，为了客户端与服务器之间保留着互相信任的东西，就像两个陌生人变成熟人，为了防止下次还认识，互相交换信物一样

*请求重定向后，session会丢失*

cookie 保留在客户端和服务器之间，因为每个客户端都有一个唯一的加密cookie ,所以不用与ip绑定即可，服务器上可以在数据库中保留，如reminde me 的字段

session 仅仅保留在服务器，因为没有保留在客户端，所以为了区别每个客户端的 session，它是与ip绑定的

在实际使用中，关键session值(如_csrf_token)不仅保留在服务器，还以cookie 形式保留在客户端,并且每次都会更新

<h3>上面的想法似乎错了， laravel的session是动态的，也就是每次请求都告诉客户端更新session，然后再次请求要提交该session，所以不用绑定ip，增加了可靠性，确保两次请求都是同一个客户端发来的，而cookie是浏览器保留服务器密码的一种方法，它可以保存并实时更新提交动态session，也可以保留 remenber token，可以与数据库里面的对应，从而达到了后期无密码登录的目的</h3>

然而仅仅绑定ip并没有达到安全的要求，如，如果客户端修改ip欺骗服务器，那就完了，所以还有一些动态的交换密码，每一次请求来临，给客户端多附加一个隐藏域即 token码，token码同时也保留在服务器上，通过多重检查，也就可以确定是这个客户的请求了，同时通过session还可以保留着客户的登录的状态，只要session值没有被销毁，说明客户端还在登录状态

总之一个客户端对应一个session,读取或者session时，基本功能是对该客户端的session操作，应该有方法可以看到当前登录的所有用户sessions数组

#### laravel的基本用法和流程
#### by lumin  25.02.2016
永远要记得查看这里日记

---------------------------------------------------

routes.php, views, controler, database/migrate

1. 数据库准备操作，如，创建表结构等.
```
php artisan make:migration 'dosomething like update_a_table'

php artisan migrate

php artisan make:model some
```
2. 定义路由
```
Route::get('/', function() {
	return view()->withTitle('');
});

Route::get('user/{id}', function($id)
{
    return 'User '.$id;
})->where('id', '[0-9]+');
```

3. 控制器 
```
// 带命名空间的controller, 在Controllers的子目录Photos目录下
Route::get('foo', 'Photos\AdminController@method');
// 带控制器中间件
Route::get('profile', [
    'middleware' => 'auth', //中间件
    'uses' => 'UserController@showProfile' //控制器
]);
// 也可以在该控制器的构造函数内指定
public function __construct()
    {
        $this->middleware('auth');

        $this->middleware('log', ['only' => ['fooAction', 'barAction']]);

        $this->middleware('subscribed', ['except' => ['fooAction', 'barAction']]);
    }

// 隐式控制器
// users是路由url前缀，所有的url规则对应控制器内的方法 ,简化定义普通路由的方法
Route::controller('users', 'UserController'); 
get: url => users/admin-profile对应
public function getAdminProfile() {}
// 此外

 public function postProfile()
    {
        //
    }

    public function anyLogin()
    {
        //
    }

// restful 资源控制器，主要处理查改增删
命令生成控制器php artisan make:controller PhotoController

路由配置: Route::resource('photo', 'PhotoController');
// 对应
get: /photo index() //获取最初列表
get: /photo/create create() // 获取一个新增photo的表单
Post: /photo store() // store() 保存新增的photo表单
get: /photo/{photo} // show() 显示固定id的photo
get: /photo/{photo}/edit edit() 获取编辑一个photo的页面
put: /photo/{photo}  update() //修改更新指定的photo ,当提交表单带有{input name="_put"}字段，会认为该表单以put方法提交(请求中含有该字段也是一样)
delete: /photo/{photo} destroy() 删除

{photo}是路由参数，可以在控制器中直接获得
// 在依赖之后获取该路由的参数
 public function update(Request $request, $id)
    {
        //
    }

```

4. 中间件,在控制器前使用
```
php artisan make:middleware myMiddleware

 public function handle($request, Closure $next)
    {
        if ($request->input('age') < 200)
        {
            return redirect('home');
        }

        return $next($request);
    }
	// 如果在中间件的构造函数继续声明中间件，那么就可以实现多层中间件
```
若所有请求都会执行中间件，那么要定义在app/Http/Kernel.php 的 $middleware 属性清单列表中。

如果部分使用，也需要在该文件中定义一个键值
```
// 使用在路由中
Route::get('admin/profile', ['middleware' => 'auth', function()
{
    //
}]);
```

#### 服务，IOC容器，Provider, facades, 以及composer加载机制
1. 每个服务可以看做是一个类，服务组合起来变成了包，是一个大的service,一个service(或者大的service,(有一个使用它的接口类))类对应一个或者多个provider,provider写出了实例化service的方法，这时只要直接在IOC中注册provider,就可以在其他类中取出该service的实例，方法是，作为参数类型声明即可，facades提供了一个通过别名取出service类实例的方法，也需要在IOC中注册

2. 使用服务，laravel中一个服务就是一个包，包由许多个类合成， 共同协作完成一个特定的功能，并且包中有一个对外的接口，这样外部就可以使用它，该对外接口就是一个入口文件，该包也对应一个provider和一个facade,这样其他类如控制器就可以直接使用他了。

3. contract的作用是低耦合，如几个类有类似的功能，可以把它做成一个接口，然后接口规定了共同的方法，在使用时就不用关注方法到底是怎样实现的。如果没有接口的定义，那么多个类似功能的类可能会出现api不一样，所以就会出现调用不同的类时需要修改api。而有了contract,只要告诉容器contrat和实现在哪，就可以轻松换装
* 整个使用流程其实就可以总结为两个步骤：
* 利用provider向容器中注册实现contract接口的对象。
	```
	public function register()
{
    $this->app->bind(
        'Illuminate\Contracts\Auth\Registrar',
        'App\Services\Registrar'
    );
}
	```
* 构造函数参数类型指定为contract接口类，框架会自动找到符合条件的对象。

包的入口文件会在内部实例化并使用该包内的其他类，因此对外只有一个入口类，依赖者只要实例化该类就可以获得该类的所有方法(功能), [一般包的内部会对应自己的配置文件//config.php，用来初始化等，也会有一个provider和facade，在laravel中使用时要注册]

2. composer包加载机制
$class = require ('path/to/class');
$obj = new $class();
可以加载一个类，并且获得该类的实例，但是在实际使用中，关注的并不是该类(包)的路径，我们更希望在用到时自动加载
$obj = new myclass('name'); //即我只需要知道我给该类绑定的别名即可
于是composer就是为了这个而生,它在每个包的composer.json文件中设定了psr-4: {"myclass\\" : "src/"} , 这时，myclass别名就对应了composer.json目录下的src目录，当 new myclass\some() 时，就是实例化src目录下的some类，类名跟文件名一致

每个包都有一个composer.json文件，和一个composer.lock文件，.lock是为了锁定版本，如果存在.lock则不加载.json,执行composer install后，composer会下载包并读取该包下psr-4，并写入全局的composer.json 文件，这样就可以了

使用，在运行开始处 ，require 'vendor/autoload.php';
就可以直接使用了

3. 使用一个包，一个类的通用方法
es5: require('./') 先加载该类（或者包入口的路径), 再new
es6: import some from './' 加载对象中的某个方法或者全部类(即function) ,再使用

php : require('/')后new 
composer : 直接利用psr-4别名加载前置路径
composer + namespace ,使用use关键字+ psr-4前置路径 ，省去require的麻烦

composer + namespace + ioc 
use , + 类型声明注入, 省去了所有的麻烦，( 如，多层依赖 )即调即用


#### laravel安装配置
0. 配置php，mysql, linux, nginx等，或者安装homestamp
1. 安装composer,修改镜像地址
```cmd

composer config repo.packagist composer http://packagist.phpcomposer.com
// 或者仅在当前应用中 使用
"repositories": {
    "packagist": {
        "type": "composer",
        "url": "http://packagist.phpcomposer.com"
    }
}
```
2. 执行安装
```
composer create-project laravel/laravel  project-name --prefer-dist
```
3. 更改文件权限,修改项目下public, storage权限，读写都要chmod -R 777 dir //递归设定目录权限
4. 增加，修改apache虚拟主机，修改httpd-vhost.conf文件
5. 配置好数据库.env文件
```

<VirtualHost *:80>
   DocumentRoot 'F:/composer/public'

</VirtualHost>

<VirtualHost *:82>
    
    #DocumentRoot "F:/l5.1/public"
     DocumentRoot "F:/xinfeng/public"
    
</VirtualHost>
[参考为一个服务器添加多个虚拟主机的方法](http://www.cnblogs.com/hi-bazinga/archive/2012/04/23/2466605.html)
```

5. 注意在跨项目复制文件时，如果已经在编辑器打开后再复制，需要save服务器才能识别


#### laravel Eloquent ORM
1. 一对多,one post has many comments
数据表结构 
table: post (id, another);
table: comments (id, postId, another);
模型定义
```
model: Post.php
protect $table = 'posts'; //设置对应的数据表名
// 注意要设定可以赋值的语句
protected $table = 'sensors';
public function comments() {
	return $this->hasMany('App\Comment', 'comment_id', post_id);
}
model : Comment.php
protect $table = 'comments'

public function post() {
	return $this->belongsTo('App\Post'[,'post_id', 'comment_id']);
}


```

```
SELECT * FROM `iot_users` WHERE created_at BETWEEN '2016-1-10 00:00:00' AND '2017-1-10 00:00:00'
select ip from research where day(`timestamp`) = day(now()) and `timestamp` < now();

select ip from research where `timestamp` >= date_sub(now(),interval 10 day) and `timestamp` < date_sub(now(),interval 10 day);

User::whereBetween('created_at', [Input::get('startTime'), Input::get('endTime')])->get();
// timestamp作为字符串传来
 "startTime" => "2015-07-08 00:00:00"
  "endTime" => "2015-07-29 11:32:48"
```

```

$data = ['userId' => $user->id, 'sensors' => $sensors]; var_dump(json_encode($data));


  $.ajaxSetup({
    headers: {
        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    }
});

// json字符串转json对象,(js对象和json对象可以混用)
var json = "{}";
//转对象
obj = eval(json);
eval("("+json+")");
//或者用
JSON.parse(string);

// 将对象转为json字符串
var string = JSON.stringify(json)

js打印变量，最好办法是将对象转化为字符串，然后就可以看到全部内容

<!-- 字符串转对象(strJSON代表json字符串) -->
  <!-- var obj = eval(strJSON); -->
  <!-- var obj = str.JSON.parseJSON(); -->
  <!-- var obj = JSON.parse(strJSON)； -->
<!-- json对象转字符串(obj代表json对象) -->
  <!-- var str = obj.toJSONString(); -->
  <!-- var str = JSON.stringify(obj) -->
<!-- 运用时候需要除了eval()以外需要json.js包（切记哦） -->

jQuery.ajax({ 
url: full_url, 
dataType: "json", 
success: function(results) { 
alert(result.name); 
} }); 


// 历遍map
var map = {  
             "name" : "华仔",  
         "realname":"刘德华"  
        };  
  
for (var key in map) {  
            console.log("map["+key+"]"+map[key]);  
        }  
```


Js 键值对实现

function Map() {
this.keys = new Array();
this.data = new Array();
//添加键值对
this.set = function (key, value) {
if (this.data[key] == null) {//如键不存在则身【键】数组添加键名
this.keys.push(value);
}
this.data[key] = value;//给键赋值
};
//获取键对应的值
this.get = function (key) {
return this.data[key];
};
//去除键值，(去除键数据中的键名及对应的值)
this.remove = function (key) {
this.keys.remove(key);
this.data[key] = null;
};
//判断键值元素是否为空
this.isEmpty = function () {
return this.keys.length == 0;
};
//获取键值元素大小
this.size = function () {
return this.keys.length;
};
}


###js 动态添加属性
function objMerger(obj1, obj2)
{
for(var r in obj2){
eval("obj1."+r+"=obj2."+r);
}
return obj1;
}
obj = objMerger(obj, shuxing);

obj = {} ;
var t = 'jj';
obj[t] = 'kk'; // 如果直接obj.t则会得到键是t
obj = { 'jj': 'kk' };

### 字符串分割
var array = "200，400，300".split(",");
var nums = [ ];
for (var i=0 ; i< array.length ; i++)
{
nums.push(parseInt(array[i]));
}

### jquery内部头部加入
$("#a").prepend("#b");或者$("#b").prependTo("#a");
了jQuery使用before()和after()在元素前后添加内容的方法。


#### laravel session便捷方法
session(['key' => 'val']);
### php检查变量
 isset— 检测变量是否设置, empty — 检查一个变量是否为空(是否存在也检测了,不存在或为空返回true)
 laravel 中
 @if( $f !== null )
 @endif


return redirect()->back()->withInput();
return redirect('user/login')->with('message', 'Login Failed');

### ***数据存于session中，并在模板中用表达式输出
重置session
Session::forget('sensors');
$sensors = User::find(session('userId'))->sensors;


#### js判断对象值是否属性为空或者变量是否存在等（js对声明但未初始化的变量都认为是undefined
```
1、if   (typeOf(x)   ==   "undefined")

2、if   (typeOf(x)   !=   "object")

3、if(!x)

var t = {};
t == null ; //false

var p = {};
typeof p // undefined
// null 和 {} 区别
p.name = 't'; //sucess
p.name = 'p' ; //error

function isOwnEmpty(obj)
{
    for(var name in obj)
    {
	// 如果不检测原型继承来的属性，则去掉这行
        if(obj.hasOwnProperty(name))
        {
            return false;
        }
    }
    return true;
};
```


### node js 服务端向另一个服务器发送restful请求
```
var https = require('https');
// 如果是http就require('http');
var optionsget = {
    host : 'graph.facebook.com', // here only the domain name
    // (no http/https !)
    port : 443,
    path : '/youscada', // the rest of the url with parameters if needed
    method : 'GET' // do GET//or 'POST'
};
 
console.info('Options prepared:');
console.info(optionsget);
console.info('Do the GET call');
 
// do the GET request
var reqGet = https.request(optionsget, function(res) {
    console.log("statusCode: ", res.statusCode);
    // uncomment it for header details
//  console.log("headers: ", res.headers);
    res.on('data', function(d) {
        console.info('GET result:\n');
        process.stdout.write(d);
        console.info('\n\nCall completed');
    });
 
});
reqGet.end();
reqGet.on('error', function(e) {
    console.error(e);
});
```

//php 时间格式
```
<?php  
echo "时间格式1：".date("Y-m-d H:i:s ")."<br>";// 2010-06-12 10:26:31   
echo "时间格式2：".date("y-M-D h:i:S ")."<br>";// 10-Jun-Sat 10:43:th   
echo "月份，英文全名：".date("F")."<br>";// June   
echo "月份，二位数字，补零：".date("m")."<br>";//  06  
echo "月份，二位数字，不补零：".date("n")."<br>";//  6  
echo "月份，三个英文：".date("M")."<br>";// Jun  
echo "星期几，英文全名：".date("l")."<br>";// Saturday  
echo "星期几，三个英文：".date("D")."<br>";// Sat  
echo "星期几，数字型：".date("w")."<br>";// 6  
?> 
```


#### 事件委派
```

	$("#sensor-info").on("click", "button.edit", function(event) {
		var targetId = $(event.target).parent(".edit").data('id');//.css("background-color", "red");
		console.log(targetId);
		//$("#my-prompt").modal();
		var modal = $("#prompt-"+targetId);
		console.log(modal);
		modal.modal();
	});


@section('js')
<script>

	$('document').ready(function() {
		$("button.edit").click(function() {
			var id = $(this).data('id');

			var target = $("#prompt"+id);
			console.log(target);
			var editForm = target.find(".am-form");
			console.log(editForm.serialize());
			//console.log(id);
			var modal = target.modal({closeOnConfirm: 0, onConfirm: submitEdit});
			function submitEdit() {
				console.log('jj');
				var val = target.find(".submit").removeClass("am-modal-btn submit").html('提交中...');
				//console.log(val);

			}
		});
	});
</script>

@endsection



				<div class="am-cf">
                  <div class="am-fr">
					  <button type="button" data-id="{{ $sensor->id }}" class="edit am-btn am-btn-default am-btn-xs"><span class="am-icon-pencil"></span></button>
                    <button type="button" class="am-btn am-btn-default am-btn-xs delete">删除</button>

                  </div>
                </div>
```
