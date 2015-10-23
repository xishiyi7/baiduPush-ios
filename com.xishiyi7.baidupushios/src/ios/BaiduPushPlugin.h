/*
 * Name       : BaiduPushPlugin.h
 * Author     : xishiyi7
 * CreateDate : 2015.10.12
 * LastModify : 2015.10.23
 */

#import <Cordova/CDV.h>
#import <CoreLocation/CoreLocation.h>

static CDVInvokedUrlCommand *clickCallback = nil;
static id delegate = nil;
static CDVPluginResult *pluginResult = nil;
@interface BaiduPushPlugin : CDVPlugin
@property (nonatomic) CDVPluginResult *result;

/*!
 @method
 @abstract 绑定
 */
- (void)startWork:(CDVInvokedUrlCommand*)command;

/*!
 @method
 @abstract 解除绑定
 */
- (void)stopWork:(CDVInvokedUrlCommand*)command;


- (void)returnNoResult:(CDVInvokedUrlCommand*)command;

+ (void)receiveNotification:(NSDictionary *)userInfo inBackground:(BOOL) background;

/*!
 @method
 @abstract 监听通知点击事件
 */
- (void)listenNotificationClicked:(CDVInvokedUrlCommand*)command;


@end