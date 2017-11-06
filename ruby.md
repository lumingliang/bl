title: 以下是ruby的学习过程，包括简要的语法，和ruby的核心模块
----
### 安装ruby
1. 可以从apt等包管理器安装,集成了所有和ruby有关的插件工具,省事,但会比较老版本
2. 可以用官方的	installer ,集成了所有工具并且有全新的版本可选
3. 源码编译安装
```
# 下载源码后
./configure #By default, this will install Ruby into /usr/local. To change, pass the --prefix=DIR option to the ./configure script.
	# 自定义安装路径
make 
make install

# 安装好后，打开irb，是一个ruby的终端控制台，可以自动缩进代码！
```
### ruby的基本变量结构
1. ruby 内所有结构从数字到方法，再到对象，都是一个类的对象(这里要区别于json对象，和js的对象，它与js对象很类似，不过更确切的应该是和php等类C语言的类和对象对应)
2. 以下是一些简洁的加减乘除，以及ruby的所有数据类型，以及逻辑控制的代码
```
# 计算
2+6 # 输出8
# 字符串
name = 'lumin'
name # 输出name
# 任何内容都是对象，或者说都是某一个类的实例
name.reverse # 调用name的reverse方法，reverse方法再很多变量结构中都可以使用，当然，如果是数组，就先将数组化为字符串，再使用reverse方法
name.length # 
40.to_s.reverse # 先将40变成字符串再翻转
# 还有一些类似的转换方法
to_i #变成整数
to_a #converts value to array
## 表示是上面的注释，这几个方法实践时候找不准能用的数据类型

[12,45,56].max #找有序数组中的最大值

# 强大，把字符串分割成数组
lumin = 'lu ming liang'
lumin['lu'] = 'zeng'
lumin 
	=> zeng ming liang
poem.lines.to_a.revser # 将一个段落化为行再化为数组，再翻转
poem.lines.to_a.reverse.join # 继续上面，但最终又化为字符串！
## 注意，类似poem.lines.to_a这类连续方法并不改变poem原来的值，但如果发生赋值就改变了

poem.include ?'my hand' # 查看字符串是否拥有某个词
poem.downcase # 转化大写为小写

#hash 
books = {}
books['one'] = :some string
books['one']
	=> some string
books['another'] = 'string'

# 另外一种使用hash的方法
ratings = Hash.new(0) #new,新建一个hash实例，0，隐形日后每个key对应的值的初始值是0
books.values.each { |rate| ratings[rate] += 1 } #books,是list, |rate| 管道传值每一个books.values 
# int+=4 ,是ruby中惯用

5.times { print 'olay' } # 5次打印，也可以不写print 

{} 可以用do ... end 代替

# 目录
Dir.enties '/' #列出目录/的所有
Dir['/.*txt'] # 查找是否有 */.txt文件
print File.read('/comics.txt') # 读取文件
FileUtils.cp('/comics.txt', '/Home/comics.txt') # 复制文件
File.mtime("/Home/comics.txt") # 查看文件最后修改时间


# 函数定义
def load_comics( path )
  comics = {}
  File.foreach(path) do |line|
    name, url = line.split(': ') # line.split 根据: 分割字符串为数组，并存到name,url 中
    comics[name] = url.strip #strip -- This quick method removes extra spaces around the url. Just in case.
  end
  comics
end

#包的使用 
require something 
something.method
```
