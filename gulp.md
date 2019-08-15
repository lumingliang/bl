#### 这里是前端工具gulp和webpack的基础用法学习
----

##### gulp ,automate and enhance my wokflow!
* 安装：npm install gulp-cli -g //全局安装cli
* npm install gulp --save-dev //install gulp in current project, and save detail in package.json
* 创建gulpfile.js , 里面配置了所有gulp的工作，当前gulp会调用gulp自身和它的一些有用插件来自动完成所有工作

##### all api for gulp , gulp.src,gulp.dest, gulp.task, gulp.watch

下面一一讲解这些api的用法

先看代码
```
gulp.src('client/templates/*.jade') // 获取源文件(待处理文件)
  .pipe(jade()) //通过pipe使文件作为输出，并输入给jade()处理后继续输出,这里实现了预编译jade语法的文件
  .pipe(minify()) // 继续用minify处理,即压缩
  .pipe(gulp.dest('build/minified_templates')); // gulp.dest输出到目的地
```
上面代码jade,minify方法需要npm install plugin,然后参照plugin使用它，gulp只起到输入，输出，和整合调用其他插件的作用

gulp.src原型为
```
gulp.src(globs[, options]) 
globs 一般是strings，或者strings 数组(即多个), 后面的options是附加设置

// 如下目录
client/
  a.js
  bob.js
  bad.js

gulp.src(['client/*.js', '!client/b*.js', 'client/bad.js']) // 只会匹配a.js, bad.js

// options = {
	buffe: defualt(false) // 当为true时，读取文件将会以流steam形式，而不是全部读进缓冲区,这对读取大文件有用，但不是每个插件支持stream形式
	read: true // 设置为flase会返回null,而且不会读取文件
	base: 'string' // 设置输出和输入 的路径问题，参考以下代码
}

gulp.src('client/js/**/*.js') // 
  .pipe(minify())
  .pipe(gulp.dest('build'));  // Writes 'build/somedir/somefile.js'

gulp.src('client/js/**/*.js', { base: 'client' })
  .pipe(minify())
  .pipe(gulp.dest('build'));  // Writes 'build/js/somedir/somefile.js'
```

gulp.dest(path, [, options]) , path是在gulpfile目录基础下的子目录，如果没有就创建它,options取值
```
options = {
	cwd: ?,
	mode: 0777(默认),设定目录权限
}
```

gulp.task(name, [, deps, fn]), name是task的名字，deps是一个其他任务名数组，因为各个task之间是并发运行的，要保证当前task 在其他task之后运行就要把它写入数组中

```
gulp.task('mytask', ['array', 'of', 'task', 'names'], function() {
  // Do stuff
}); // 数组内的所有都会同时运行，mytask要在数组task后运行，需要数组内的任务正确使用promise等。

以上所有的任务内容都是写在task回调中。
```

异步task的写法
```
// 使用回调
// run a command in a shell
var exec = require('child_process').exec;
gulp.task('jekyll', function(cb) {
  // build Jekyll
  exec('jekyll build', function(err) {
    if (err) return cb(err); // return error
    cb(); // finished task
  });
});

// 返回一个stream
gulp.task('somename', function() {
  var stream = gulp.src('client/**/*.js')
    .pipe(minify())
    .pipe(gulp.dest('build'));
  return stream;
});

// 返回一个promise
var Q = require('q');

gulp.task('somename', function() {
  var deferred = Q.defer();

  // do async stuff
  setTimeout(function() {
    deferred.resolve();
  }, 1);

  return deferred.promise;
});

```

##### 任务互相依赖，如b依赖a的先完成，那么应该按照上面的异步写法写a,返回promise，等让gulp知道它什么时候完成，然后在b的options中声明依赖数组，gulp就自动知道了

```
var gulp = require('gulp');

// takes in a callback so the engine knows when it'll be done
gulp.task('one', function(cb) {
    // do stuff -- async or otherwise
    cb(err); // if err is not null and not undefined, the run will stop, and note that it failed
});

// identifies a dependent task must be complete before this one begins
gulp.task('two', ['one'], function() {
    // task 'one' is done now
});

gulp.task('default', ['one', 'two']);
```

##### gulp.watch(glob [, opts], tasks) or gulp.watch(glob [, opts, cb])

glob是要监测的文件(or file数组),opts是监测的行为，如'reload', tasks当发生这些监测行为时要运行的任务，或者使用cb,当行为发生时要运行的cb

```
cb(event) //cb中附带有event参数，可以读取发生该事件的上下文，如path, type

gulp.watch('js/**/*.js', function(event) {
  console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
});

var watcher = gulp.watch('js/**/*.js', ['uglify','reload']);
watcher.on('change', function(event) {
  console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
});
```

##### gulp插件，所有的自动化行为大多依赖插件完成

以下说明主要有用插件
编译Sass (gulp-ruby-sass)
Autoprefixer (gulp-autoprefixer)
缩小化(minify)CSS (gulp-minify-css)
JSHint (gulp-jshint)
拼接 (gulp-concat)
丑化(Uglify) (gulp-uglify)
图片压缩 (gulp-imagemin)
即时重整(LiveReload) (gulp-livereload)
清理档案 (gulp-clean)
图片快取，只有更改过得图片会进行压缩 (gulp-cache)
更动通知 (gulp-notify)

// 安装插件命令
```
npm install gulp-ruby-sass gulp-autoprefixer gulp-minify-css gulp-jshint gulp-concat gulp-uglify gulp-imagemin gulp-clean gulp-notify gulp-rename gulp-livereload gulp-cache --save-dev
```

// 使用插件
```
var gulp = require('gulp'),  
    sass = require('gulp-ruby-sass'),
    autoprefixer = require('gulp-autoprefixer'),
    minifycss = require('gulp-minify-css'),
    jshint = require('gulp-jshint'),
    uglify = require('gulp-uglify'),
    imagemin = require('gulp-imagemin'),
    rename = require('gulp-rename'),
    clean = require('gulp-clean'),
    concat = require('gulp-concat'),
    notify = require('gulp-notify'),
    cache = require('gulp-cache'),
    livereload = require('gulp-livereload');
```

简单任务: 编译sass, 自动加入浏览器前缀，重命名，最小化压缩， ```
gulp.task('styles', function() {  
  return gulp.src('src/styles/main.scss')
    .pipe(sass({ style: 'expanded' }))
    .pipe(autoprefixer('last 2 version', 'safari 5', 'ie 8', 'ie 9', 'opera 12.1', 'ios 6', 'android 4'))
    .pipe(gulp.dest('dist/assets/css'))
    .pipe(rename({suffix: '.min'}))
    .pipe(minifycss())
    .pipe(gulp.dest('dist/assets/css'))
    .pipe(notify({ message: 'Styles task complete' }));
});
```

jshint, 检查后压缩
```
gulp.task('scripts', function() {  
return gulp.src('src/scripts/**/*.js')
 .pipe(jshint('.jshintrc'))
 .pipe(jshint.reporter('default'))
 .pipe(concat('main.js'))
 .pipe(gulp.dest('dist/assets/js'))
 .pipe(rename({suffix: '.min'}))
 .pipe(uglify())
 .pipe(gulp.dest('dist/assets/js'))
 .pipe(notify({ message: 'Scripts task complete' }));
});
```
[参考](http://www.jianshu.com/p/3f2e13442555)


##### 加入版本号
```
cnpm -g install gulp gulp-minify-css  gulp-rev gulp-rev-collector gulp-clean gulp-uglify  gulp-imagemin gulp-base64 gulp-concat
cnpm  install gulp gulp-minify-css  gulp-rev gulp-rev-collector gulp-clean gulp-uglify  gulp-imagemin gulp-base64 gulp-concat --save-dev 



var gulp = require('gulp');
var concat = require('gulp-concat');                //- 多个文件合并为一个；
var minifyCss = require('gulp-minify-css');         //- 压缩CSS文件；
var rev = require('gulp-rev');                      //- 对css、js文件名加MD5后缀
var revCollector = require('gulp-rev-collector');   //- 路径替换
var clean = require('gulp-clean');                  //- 用于删除文件
var uglify = require('gulp-uglify');                //- 压缩js代码
var imagemin = require('gulp-imagemin');            //- 压缩图片
var base64 = require('gulp-base64');                //- 把小图片转成base64字符串
var q = require('q');                               //- 用于解决任务执行顺序的问题（一个任务执行完毕才执行另外一个任务）（暂时还没用到）

/*清理文件*/
gulp.task('clean',function () {                     //删除dist目录下的所有文件
    gulp.src('dist/*',{read:false})
        .pipe(clean());
});

/*压缩js文件，并生成md5后缀的js文件*/
gulp.task('compress-js',function (callback) {       //- 创建一个名为compress-js的task
    gulp.src(['webContent/js/**/*.js'])             //- 需要处理的js文件，放到一个字符串数组里
        .pipe(uglify())                             //- 压缩文件
        .pipe(rev())                                //- 文件名加MD5后缀
        .pipe(gulp.dest('dist/js'))                 //- 另存压缩后的文件
        .pipe(rev.manifest())                       //- 生成一个rev-manifest.json
        .pipe(gulp.dest('rev-js'))                  //- 将rev-manifest.json保存到 rev-js 目录内
        .on('end',function () {
            console.log('compress-js has been completed');
            callback();
        });
});

/*压缩css文件，并生成md5后缀的css文件*/
gulp.task('compress-css', function(callback) {      //- 创建一个名为compress-css的task
    gulp.src(['webContent/css/**/*.css'])           //- 需要处理的css文件，放到一个字符串数组里
        // .pipe(concat('css/wap.min.css'))         //- 合并后的文件名
        .pipe(minifyCss())                          //- 压缩处理成一行
        .pipe(rev())                                //- 文件名加MD5后缀
        .pipe(gulp.dest('dist/css'))                //- 输出文件到dist/css目录下
        .pipe(rev.manifest())                       //- 生成一个rev-manifest.json
        .pipe(gulp.dest('rev-css'))                 //- 将rev-manifest.json保存到rev-css目录内
        .on('end',function () {
            console.log('compress-css has been completed');
            callback();
        });
});

/*修改html文件的link标签和script标签引用的css和js文件名，并把html文件输出到指定的位置*/
gulp.task('rev-html',['compress-css','compress-js'], function() {          //- compress-css和compress-js任务执行完毕再执行rev-index任务
    /*修改index.html文件的link标签和script标签引用的css和js文件名，并把html文件输出到指定的位置*/
    gulp.src(['rev-css/*.json','rev-js/*.json', 'webContent/index.html'])   //- 读取两个rev-manifest.json文件以及需要进行css和js名替换的html文件
        .pipe(revCollector())                                               //- 执行文件内css和js名的替换
        .pipe(gulp.dest('dist/'));                                          //- 替换后的html文件输出的目录

    /*修改其它html文件的link标签和script标签引用的css和js文件名，并把html文件输出到指定的位置*/
    gulp.src(['rev-css/*.json','rev-js/*.json', 'webContent/views/**/*.html'])     //- 读取两个rev-manifest.json文件以及需要进行css和js名替换的html文件
        .pipe(revCollector())                                                      //- 执行文件内css和js名的替换
        .pipe(gulp.dest('dist/views'));                                            //- 替换后的html文件输出的目录
});

/*压缩并复制图片*/
gulp.task('compress-img',function () {
    gulp.src('webContent/images/**/*.*')    //原图片的位置
        .pipe(imagemin())                   //执行图片压缩
        .pipe(gulp.dest('dist/images'));    //压缩后的图片输出的位置
});

/*最终执行的任务-css*/
gulp.task('rev',['rev-html','compress-img']);

```
