## baiduPush-ios
cordova(ionic/phonegap) plugin: "com.xishiyi7.baidupushios"
###### plugin desc(插件功能描述)
 * 在js端使用start方法，可以实现js调用object-c，实现与百度云推送服务绑定；
 * 在js端使用stop方法，可以解绑百度云推送服务；
 * 在js端使用notifyClicked方法，可以监听通知点击事件，同时回调js，在js中写相应的处理
 
## Usage
the plugin exposes the following method:

```javascript(baidu_push.js)
// start, bind baidu push 
window.baidu_push.start('key',success);
// stop, unbind baidu push 
window.baidu_push.stop(success);
// 监听通知点击事件
window.baidu_push.notifyClicked(success);
```

## File

```ios 
// src/ios
1.BaiduPushPlugin.h; 此为插件类的h文件，其中定义了与js通信的方法；
2.BaiduPushPlugin.m; 此为插件类的m文件，其中定义了具体的实现；

// libs/ios 
1.AppDelegate_rp.m 可以将此文件替换掉应用中的AppDelegate.m文件 并将其中的baidu key换成你应用的key；
2.BPush.h;
3.libBPush.a；（文件2和3是百度云推送的官方文件）

```

## Example
```use
// when you do something, like demo button click event
function demoClick(){
  window..baidu_push.start('key',success);
  window..baidu_push.stop(success);
  window..baidu_push.notifyClicked(success);
}
```
## CallBack
```
1. 在start成功之后，可以写success回调，返回参数如下：
	#json: {
	    type: 'onbind',
	    data: {
	      appId: 'xxxxxxxx',
	      userId: 'yyyyy',
	      channelId: 'zzzzzz'
	    }
	  }
2. 在stop成功之后，可以写success回调，返回参数如下：
	#json: {
		    type: 'onunbind', //对应Android Service的onUnbind方法
		    errorCode: 'xxxxxx', //对应百度的请求错误码
		    data: {
		      requestId: 'yyyyyy', //对应百度的请求ID
		    }
		  }
3. 在notifyClicked成功之后，可以写success回调，返回参数如下；
	#json: {
		    background:1	或0
		    data: {
		      key:value		此处为你自定的值类型
		    }
		  }

注意：在notifyClicked回调的data中会回传一个参数background，当应用运行在前台时，自动调用notifyClicked函数，此时background为0；
当应用在后台运行，用户点击通知时，此时的background为1，可以方便用户在此处做相应的处理；
```

## Other Desc：

在APP端可以使用以下方法区分判断此时是ios系统：
```js
if(window.cordova.platformId == 'ios') //表示iOS系统
```

