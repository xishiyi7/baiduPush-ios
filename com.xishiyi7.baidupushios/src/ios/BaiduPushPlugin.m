/*
 * Name       : BaiduPushPlugin.m
 * Author     : xishiyi7
 * CreateDate : 2015.10.12
 * LastModify : 2015.10.23
 */

#import "BaiduPushPlugin.h"
#import "BPush.h"

@implementation BaiduPushPlugin{
    
}

/*!
 @method
 @abstract 绑定
 */
- (void)startWork:(CDVInvokedUrlCommand*)command{
    
    NSLog(@"绑定");
    delegate = self.commandDelegate;
    
    [BPush bindChannelWithCompleteHandler:^(id result, NSError *error) {
        NSLog(@"绑定用户结果:%@\n%@",BPushRequestMethodBind,result);
        
        NSDictionary *jsondata = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [BPush getAppId], @"appId",
                                  [BPush getChannelId], @"channelId",
                                  [BPush getUserId], @"userId",
                                  @"4", @"deviceType",
                                  [result objectForKey:@"error_code"], @"errorCode",
                                  [result objectForKey:@"request_id"], @"requestId", nil];
        
        NSDictionary *jsonResult = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"onBind", @"type",
                                    jsondata, @"data",
                                    nil];
        
        // 绑定返回值
        if ([self returnBaiduResult:result])
        {
            self.result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonResult];
        }
        else{
            self.result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        [self.commandDelegate sendPluginResult:self.result callbackId:command.callbackId];
        [self.result setKeepCallbackAsBool:true];
    }];
}

- (void) returnNoResult:(CDVInvokedUrlCommand *)command
{
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT];
    [pluginResult setKeepCallbackAsBool:true];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)listenNotificationClicked:(CDVInvokedUrlCommand *)command
{
    //[self returnNoResult:command];
    clickCallback = command;
    delegate = self.commandDelegate;
}

/*
 * fun: 当用户点击通知进入此方法
 * arg: userInfo 通知内容； background 是否在后台运行
 */
+ (void)receiveNotification:(NSDictionary *)userInfo inBackground:(BOOL)background
{
    
    NSDictionary *jsonResult = [NSDictionary dictionaryWithObjectsAndKeys:
                                userInfo, @"data",
                                background?@"1":@"0",@"background",
                                nil];
    
    // 用户点击了消息 就会进入此 可以进行js回调
    if(clickCallback != nil && delegate != nil){
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonResult];
        [pluginResult setKeepCallbackAsBool:true];
        [delegate sendPluginResult:pluginResult callbackId:clickCallback.callbackId];
    }    
}


/*!
 @method
 @abstract 解除绑定
 */
- (void)stopWork:(CDVInvokedUrlCommand*)command{
    NSLog(@"解除绑定");
    [BPush unbindChannelWithCompleteHandler:^(id result, NSError *error) {
        // 解绑返回值
        if ([self returnBaiduResult:result])
        {
            self.result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        }
        else{
            self.result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        [self.commandDelegate sendPluginResult:self.result callbackId:command.callbackId];
    }];
}

- (BOOL)returnBaiduResult:(id)result{
    NSString *resultStr = result[@"error_code"];
    if (!resultStr || [[resultStr description] isEqualToString:@"0"]){
        return YES;
    }
    return NO;
}

@end
