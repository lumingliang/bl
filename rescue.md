title: 研究递归算法的使用和原理
---

### 递归算法是为了让程序更加易读，易于思维，而且能应付复杂的问题，递归算法的本质是在一个函数内间接或者直接调用函数自身，每一次调用都是一个级别，每一个级别共享主程序代码，但是每个级别都有一份属于自己的变量环境，可以把每个级别的调用，当做独立的函数体，递归先是必须达到最终的非递归条件，然后再逐级返回，最后退出
### 递归的本质还是函数的执行，但是由于每一层的递归都有自己的私有变量[当返回到该层时，后续语句执行仍然用的该层产生时的变量，每一个递归层之间是独立的],所以非常容易增加了内存消耗，另外由于每一个层次之间的切换，创建，都花了cpu时间，所以本质上以时间空间，换思维的便捷性，不过对于大多数场合来说，都是值得的。推荐使用递归

```
 #include<stdio.h>
  void up_and_down(int);
 int main(void)
 {
    up_and_down(1);
    return 0;
 }
 void up_and_down(int n)
 {
     printf("Level %d:n location %p\n",n,&n); /* 1 */
     if(n<4)
       up_and_down(n+1);
     printf("Level %d:n location %p\n",n,&n); /* 2 */
}


输出结果
Level 1:n location 0240FF48 //后面的是变量的地址，从变量地址可以看出，每一个层都有一个自己的独立变量集合,而且执行规则是先到达最后一层，然后倒数返回，每返回一层，就执行该层未完成的后面代码，（用的是该层的独立变量）
Level 2:n location 0240FF28
Level 3:n location 0240FF08
Level 4:n location 0240FEE8
Level 4:n location 0240FEE8
Level 3:n location 0240FF08
Level 2:n location 0240FF28
Level 1:n location 0240FF48

 
```

### js中的递归不像常规一样，需要将一切的动作都放在回调函数中，然后利用回调函数传递回调函数，层层回调
可参考以下递归创建目录
```
function mkdirs(dirname, mode, callback){
    fs.exists(dirname, function (exists){
        if(exists){
            callback();
        }else{
            console.log('path.dirname'+path.dirname(dirname));
			mkdirs(path.dirname(dirname), mode, function (){
				console.log('dirname'+dirname);
				fs.mkdir(dirname, mode, callback);
			}); // 递归思维，人只需要考虑相邻两层的变化，如果不存在这个目录，那么就先创建这个目录的上层目录，再创建本目录
        }
    });
}
```

### js中的promise是为了解决层层回调问题，对于解决递归要比较强的思维，所以，不推荐用promise来简化递归的创建，后续可以试着使用generate

### 深入理解promise [参考](http://www.jb51.net/article/70101.htm)
