//
//  AppDelegate.m
//  XY2Player
//
//  Created by zxs on 16/3/21.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "AppDelegate.h"

#define um_ios_appkey @"570b095a67e58e25d4000833"
#define um_ios_channel @"lingdingliameng"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    XYZTabbar *xy2 = [[XYZTabbar alloc] init];
    self.window.rootViewController = xy2;
    [self.window makeKeyAndVisible];
    [NSThread sleepForTimeInterval:3];
//    UMConfigInstance.appKey = um_ios_appkey;
//    UMConfigInstance.channelId = um_ios_channel;
    // 友盟
    // 友盟
    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [MobClick updateOnlineConfig];
    // reportPolicy:BATCH 启动时发送策略包
    // channelId:推广渠道为nil时默认@"App Store"
    [MobClick startWithAppkey:um_ios_appkey reportPolicy:(ReportPolicy) REALTIME channelId:um_ios_channel];
#warning 2016年04月04日15:26:39 加入appkey
    
    [WXApi registerApp:@"wx9f5a98afe3a3b701"];
    
    
    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    return [WXApi handleOpenURL:url delegate:self];
}
// onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
-(void)onReq:(BaseReq *)req{
    
}
- (void)onResp:(BaseResp *)resp {
    
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                [MobClick event:@"wx_pay_result_success"];
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [self data];
                break;
                
            default:
                
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                [MobClick event:@"wx_pay_result_fail"];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    
    
}

- (void)data { // 添加会员
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    XYZ_HZVipModel *item = [[XYZ_HZVipModel alloc]init];
    item.uuid = [NSString stringWithFormat:@"%@%@",@"video",identifierForVendor];
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    [fmt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *date = [fmt stringFromDate:[NSDate date]];
    item.vipDate = date;
    item.money = @"52";
    if (![XYZ_HZVipDao checkVipWithUUID:identifierForVendor]) {
        [XYZ_HZVipDao asyncInsertVipToDbWithItem:item];
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
