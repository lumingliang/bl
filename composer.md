titel: basic use of composer
-----

##### 常用命令
```
composer self-update // 自我更新
composer config -g repo.packgist composer https://packgist.org //配置全局的源，一般create新文件用的是官方源，更新用的是 
composer config -g repo.packagist composer https://packagist.phpcomposer.com
composer config repo.packagist composer https://packagist.phpcomposer.com //非全局，会在composer.json 中生成

"repositories": {
    "packagist": {
        "type": "composer",
        "url": "https://packagist.phpcomposer.com"
    }
}

```

// composer 用于调用github api 的token，可以通过https://github.com/settings/tokens/new?scopes=repo 获取
composer config --global github-oauth.github.com [token]


#### php 命名空间，即相对路径，在yii中@app 代表着根目录，然后在vendor中，每个文件夹的包都有一个自己的路径别名，一般在composer.json中指定，autoload属性，其中别名代表当前composer.json所在的位置

一般由composer根据安装包的composer.json中自动创建，不能随意更改里面的代码

yii中自带可以用别名设定相对目录，然后剩下的就直接根据别名定义前缀即可


##### yii assets 

yii 中从整个页面到页面中的某一个插件，都有一个资源管理类继承于Assets

该类中标明了该页面，以及该页面某个插件用到的资源的基本情况

```
有以下重要属性
$bashPath = '该资源所在的web目录'
$baseUrl = 'url引用该资源的基本前缀'
$css =[] 'css文件所在位置，会根据$basePath自动调整,里面包含了所有该资源下的css文件位置'
$js = []'js所在目录,同上 '
$depends = [  ] '依赖的其他资源，只需要声明依赖的其他资源类即可'

$sourcePah = ' ' 如果资源不再web访问目录，则声明此属性，但是如果同时声明了$basePath,yii会自动把它复制到可访问目录, 而且$baseUrl会自动重写指向到真正的目录
```

composer中php版本欺骗
"config": {
    "platform": {
        "php": "5.5.1"
    }
}
