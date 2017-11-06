title: 记录微信接入的各种注意问题

微信公众平台是一个可以利用微信登录、微信超级appjs jdk、以及微信服务器提供的各种接口的平台。使app更加健壮，达到cordova的效果

下面讲解接入流程

1. 各个第三方的接入流程其实都是类似的，如首先需要验证你服务器地址的有效性，然后才能成为开发者。(一切后续事情才可以进行);
2. 验证服务器地址有效性的方法一般是在该平台的后台控制面板中设置一个token, url，然后你需要在自己的服务器上有一个文件响应该url，url中也包含了token配对等信息。
3. 微信中必须成为公众号才有更高的权限使用更多的接口，当然他也给没有成为公众号的人提供了一个测试功能，只要验证自己的服务器地址有效性，(token) ,以及填写安全域名即可，安全域名是指所有接口的调用，必须在该域名下才行。
4. 验证url有效性后，就是获取access-token了，access-token就是后续调用接口的唯一标识密码。一切接口的使用都需要附加该access_token的信息或者派生信息.

##### 微信开放平台涉及的内容
1. 移动应用接口，应该是移动appsdk，可与微信服务器间进行通信
2. 网站应用，普通网站应用，可以利用微信auth2.0登录。获取用户信息等。
3. 公众号，可以获取有关公众号的更多api，如分享等
4. 公众号第三方开发平台，这个平台代替微信来对多个公众号进行管理，可以对多个公众号进行定制。

##### auth2.0规范详解

1. 主要逻辑如下，用户访问我网user/profile; user/profile监测用户并没有session或者cookie, 返回重定向到微信登录，用户在微信登录界面扫码或者授权，提交到微信服务器，微信服务器向浏览器返回重定向到我网callback , 我网callback获取了向微信服务器查询用户信息的必要参数，并利用此必要参数查询微信信息，然后设定，并重定向用户到/user/profile界面

2. 在微信服务号后台接口权限中，在网页授权获取用户基本信息中修改为自己想要的域名
*注意*:域名可以为本地域名，那个监测成为开发者的url是用来监测服务器有效性，以及接收微信服务器信息的唯一url。因为回调域名只是并不需要接收微信服务器的信息，所以并不用讲它设定为可外网访问域名

3. 但是js jdk接口就不行了，必须是通过备案的域名


##### curl 用法

```

/** 
 * curl POST 
 * 
 * @param   string  url 
 * @param   array   数据 
 * @param   int     请求超时时间 
 * @param   bool    HTTPS时是否进行严格认证 
 * @return  string 
 */  
function curlPost($url, $data = array(), $timeout = 30, $CA = true){    

    $cacert = getcwd() . '/cacert.pem'; //CA根证书  
    $SSL = substr($url, 0, 8) == "https://" ? true : false;  

    $ch = curl_init();  
    curl_setopt($ch, CURLOPT_URL, $url);  
    curl_setopt($ch, CURLOPT_TIMEOUT, $timeout);  
    curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, $timeout-2);  
    if ($SSL && $CA) {  
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, true);   // 只信任CA颁布的证书  
        curl_setopt($ch, CURLOPT_CAINFO, $cacert); // CA根证书（用来验证的网站证书是否是CA颁布）  
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 2); // 检查证书中是否设置域名，并且是否与提供的主机名匹配  
    } else if ($SSL && !$CA) {  
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // 信任任何证书  
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 1); // 检查证书中是否设置域名  
    }  
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);  
    curl_setopt($ch, CURLOPT_HTTPHEADER, array('Expect:')); //避免data数据过长问题  
    curl_setopt($ch, CURLOPT_POST, true);  
    curl_setopt($ch, CURLOPT_POSTFIELDS, $data);  
    //curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data)); //data with URLEncode  

    $ret = curl_exec($ch);  
    //var_dump(curl_error($ch));  //查看报错信息  

    curl_close($ch);  
    return $ret;    
}    


curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // 信任任何证书 
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 1); // 检查证书中是否设置域名（为0也可以，就是连域名存在与否都不验证了）
```


##### 判断是否为微信浏览器
```
//js
function is_weixin(){
	var ua = navigator.userAgent.toLowerCase();
	if(ua.match(/MicroMessenger/i)=="micromessenger") {
		return true;
 	} else {
		return false;
	}
}

// php
function is_weixin(){ 
	if ( strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false ) {
			return true;
	}	
	return false;
}
```
