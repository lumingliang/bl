#### webpack的 用法
----

##### 基本概念
webpack是一个处理打包js,jade,img,css 等静态资源的工具，可以分析依赖将项目下所有模块化（并且相互依赖的文件）打包成一块一块的文件，并且在浏览器端只需要一句话就可以按需使用所有的资源！

原理是: 像require(commonjs), AMD和import(es6)等形式的依赖管理在浏览器端使用都有问题，如浏览器端因为打开文件都是异步，有时需要一次性全部异步下载需要文件，有时候又要保持文件下载的先后顺序，而且浏览器端一次性打开多个用不着的文件又会浪费带宽和增加资源消耗，因此webpack将所有代码封装成一个异步按需下载代码块的终极bundle.js,可以在网页运行中按需下载用到的js，img等资源

Webpack 会分析入口文件，解析包含依赖关系的各个文件。这些文件（模块）都打包到 bundle.js 。Webpack 会给每个模块分配一个唯一的 id 并通过这个 id 索引和访问模块。在页面启动时，会先执行 entry.js 中的代码，其它模块会在运行 require 的时候再执行。

webpack思想，它将所有的浏览器内容理解为资源，不管是js，图片，还是css等，对于下载来说，都是资源，资源有一个入口文件，它处理了所有资源的相互依赖关系，保证在每个时刻下载到的资源都是最小化和保证完整性。

##### 安装
```
npm install webpack -g 

或者可以仅仅在package.json下声明，在当前project下运行指定版本;w
```

##### use 
```
webpack ./entry.js bundle.js //将目的文件在当前目录转化为bundle.js，index.html只需要引入bundle.js
```

entry.js通常是一第一个主文件，想象整个网站是一个单页面，js是一个树形依赖树，entry.js会平行依赖多个js文件，然后这些平行依赖又依赖其他文件，而这都是由webpack完成依赖按需加载

同时，如果浏览器页面需要用到css文件，也可以用webpack来依赖按需加载，方法是要安装一个特定的css加载器, 需要在命令行或者entry.js显示声明所使用的加载器处理css文件，不然就要写在配置文件中
```
npm install css-loader style-loader --save-dev //不能装在全局

require("!style!css!./style.css");
document.write(require("./content.js"));
```

配置文件webpack.config.js , 里面配置了特定文件的加载器，等，使用时只需要运行webpack,然后它会自动寻找这个文件

有颜色控制台信息输出
```
webpack --progress --colors
或者
webpack --progress --colors --watch //这样它会自动监控文件的改变，并且编译成最终的bundle.js,而且网页端打开的bundle.js也会接收到通知，及时更新！ 这需要安装npm install webpack-dev-server -g
然后
webpack-dev-server --progress --colors
```


配置文件例子
```
var webpack = require('webpack');
var commonsPlugin = new webpack.optimize.CommonsChunkPlugin('common.js');
module.exports = {
    //插件项
    plugins: [commonsPlugin],
    //页面入口文件配置
    entry: {
        index : './src/js/page/index.js'
    },
    //入口文件输出配置
    output: {
        path: 'dist/js/page',
        filename: '[name].js'
    },
    module: {
        //加载器配置
        loaders: [
            { test: /\.css$/, loader: 'style-loader!css-loader' },
            { test: /\.js$/, loader: 'jsx-loader?harmony' },
            { test: /\.scss$/, loader: 'style!css!sass?sourceMap'}, // style和css加载器级联
            { test: /\.(png|jpg)$/, loader: 'url-loader?limit=8192'}
        ]
    },
    //其它解决方案配置
    resolve: {
        root: 'E:/github/flux-example/src', //绝对路径
        extensions: ['', '.js', '.json', '.scss'], //可以自动补全的文件，如require('s') 则寻找 s.js等
        alias: {
            AppStore : 'js/stores/AppStores.js',
            ActionType : 'js/actions/ActionType.js',
            AppAction : 'js/actions/AppAction.js'
        }
    }
};
```

```
{
    entry: {
        page1: "./page1",
        page2: ["./entry1", "./entry2"] // 如果entry的内容是数组，则数组内的文件会同时打开，如果作为obj,那么代表着不同的chunk(页面),the key is the chunk name;
    },
    output: {
        // Make sure to use [name] or [id] in output.filename
        //  when using multiple entry points
        filename: "[name].bundle.js",
        chunkFilename: "[id].bundle.js" //muti input but only one ouput
    }
}


{
    test: /\.png$/,
    loader: "url-loader",
    query: { mimetype: "image/png" } // 一些加载器接收query参数，用来对加载进行特殊操作
}

// cli 版本

webpack --module-bind "png=url-loader?mimetype=image/png"


// 使用插件
var ComponentPlugin = require("component-webpack-plugin");
module.exports = {
    plugins: [
        new ComponentPlugin()
    ]
}


{ test: /\.(png|jpg)$/,loader: 'url-loader?limit=10000'} //小于10k
```
