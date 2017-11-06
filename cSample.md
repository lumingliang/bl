
for(a=1;a<4;a++) {
	//定义a的初始值为1,a<4 当a<4的时候，执行{} 里面的语句，a++每执行一次a的值就+1;
	比如这里a原来是1，a<1,执行一次，a+1后，变成2，2<4,继续执行，a再加1变为3，3<4,继续，a+1=4,4=4,停止执行
}

while(k<0) {
	//当k<0时，执行{} 里面的语句，一直到k不小于0才停止
}
switch(k) {
	case 1 : // 如果k=1,执行case 1后面的内容
	case 2 : // 如果k=2, 执行case后面的内容
	default : //如果k不等于1和2，就执行dafault后面的内容，如default : break ,表示退出switch
}

if(a>b) {
	//如果a>b ，就执行{} 里面的内容
}

void main() {  //程序入口，开始的意思

	int k = 5,n = 0; //定义k的初始值是5，n是0
	while(k>0) {  //当k大于0的时候，开始不断执行while{}里面的语句，直到k<=0为止

		switch(k) {  // switch里面的语句，只有一句是能执行的
			case 1: n+=k; //如果k的值是1，n=n+k,
			case 2:  //空表示任何事情不做，并退出switch内的语句
			case 3: n+=k; //如果k的值是3，n=n+k;
			default: break; //如果k的值不等于1,2,3，就执行
		}
		k--; // k的值减一
	}

	printf(n..) ; //打印显示n的值
}
1. k=5,n=0
2. while(k>0)  k=5 > 0成立，开始第一次执行while内的语句
	2.1 switch(k) ,k的值是5，不满足case 1,2,3, 执行default 里面的语句:break    //break指退出switch
	2.2 退出switch 后到k-- 了，k的值减一，现在变为5-1=4,即k=4
	2.3 //此时又回到while
3. while(k>0) k=4>0 成立，开始第二次执行while里面语句
	3.1 switch(k) ,k的值是4，不满足case 1,2,3, 执行default 里面的语句:break    //break指退出switch
	3.2 退出switch 后到k-- 了，k的值减一，现在变为4-1=3,即k=3
	3.3 //此时又回到while
4.  while(k>0) k=3>0 成立，开始第三次执行while里面语句
	4.1 switch(k) ,k的值是3， 满足case 3,开始执行case 3里面的n=n+k; 即n=0+3=3 //n的初始值是0,注意此时
		// case 2,1,default 不执行，因为已经满足case 3 了
	4.2 退出switch, 到k-- , 即k的值减一，变为 2
	4.3 继续回到while
5. while(k>0) k=2>0 成立，开始第四次执行while内语句
	5.1 switch(k) ,k=2, 满足case 2, 开始执行case 2里面的语句，因为没有，所有啥也没做
		//case 1,3,default 不会执行，因为已经满足case 2
	5.2 退出switch ,到k-- , k的值变为1
	5.3  回到while 
6. while (k>0) k=1>0成立，开始第五次执行while内的语句
	6.1 switch(k) , k= 1, 满足case 1 ,开始执行case 1 里的语句， n+=k ,即n = n+k; 得到n = 3+1=4; //n的值由于上面的计算已经变为3
		// case 2,3,default 不执行
	6.2 退出switch，到k-- ,即k减一后变为了0
	6.3 回到while
7. while (k>0) 此时k的值为0，k>0不成立，不执行while里面的语句
8. 退出了while到pritf() ,打印出n 的值，n=4  ,//printf()是打印n的值，具体表现是什么得看c中的说明









int x=1,y=1; //定义x=1,y=1;
while(x<3) {
	y+=x++; //这里隐藏了两句话,如下
	// y= y+x;
	// x=x+1;

	//如果是y+=++x //就是
	// x=x+1;
	//y = y+x;
}

1. x=1<3,进入while ,
	1.1  y= y+x;即y = 1+1=2;
	1.2  x=x+1; 即x = 1+1=2;
	1.3 继续回到while
2. x=2<2 ,二次进入while ,
	2.1 y = y+x; 即 y = 2+ 2=4;
	2.2 x =x+1 ;即 x=2+1 =3;
	2.3 继续回到while
3. x=3 不小于3, 不执行while, 
4. 最终值 x=3, y =4






