var exec = require('cordova/exec');
var baidu_push = {
  registered: false,
  startWork: function(api_key, successCallback) {
    exec(successCallback, baidu_push.failureFn, 'BaiduPush', 'startWork', [api_key]);
  },
  stopWork: function(successCallback) {
    exec(successCallback, baidu_push.failureFn, 'BaiduPush', 'stopWork', []);
  },
  failureFn: function() {
    console.log('fail to register push');
  },
  notifyClicked: function(successCallback) {
    exec(successCallback, baidu_push.failureFn, 'BaiduPush', 'listenNotificationClicked', []);
  }
}

module.exports = baidu_push;
