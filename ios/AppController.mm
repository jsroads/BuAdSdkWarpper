/****************************************************************************
 Copyright (c) 2010-2013 cocos2d-x.org
 Copyright (c) 2013-2016 Chukong Technologies Inc.
 Copyright (c) 2017-2018 Xiamen Yaji Software Co., Ltd.
 
 http://www.cocos2d-x.org
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 ****************************************************************************/

#import "AppController.h"
#import "cocos2d.h"
#import "AppDelegate.h"
#import "RootViewController.h"
#import "SDKWrapper.h"
#import "platform/ios/CCEAGLView-ios.h"

//#include <BUAdSDK/BUAdSDKManager.h>
//#import <BUAdSDK/BURewardedVideoModel.h>
//#import <BUAdSDK/BURewardedVideoAd.h>
#include "ChannelSDK.h"
#import "Tracking.h"
#import "ALAlertView.h"
//#import "ReYunGame.h"

using namespace cocos2d;

@implementation AppController

Application* app = nullptr;
@synthesize window;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[SDKWrapper getInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    // Add the view controller's view to the window and display.
    float scale = [[UIScreen mainScreen] scale];
    CGRect bounds = [[UIScreen mainScreen] bounds];
    window = [[UIWindow alloc] initWithFrame: bounds];
    
    // cocos2d application instance
    app = new AppDelegate(bounds.size.width * scale, bounds.size.height * scale);
    app->setMultitouch(true);
    
    // Use RootViewController to manage CCEAGLView
    _viewController = [[RootViewController alloc]init];
#ifdef NSFoundationVersionNumber_iOS_7_0
    _viewController.automaticallyAdjustsScrollViewInsets = NO;
    _viewController.extendedLayoutIncludesOpaqueBars = NO;
    _viewController.edgesForExtendedLayout = UIRectEdgeAll;
#else
    _viewController.wantsFullScreenLayout = YES;
#endif
    // Set RootViewController to window
    if ( [[UIDevice currentDevice].systemVersion floatValue] < 6.0)
    {
        // warning: addSubView doesn't work on iOS6
        [window addSubview: _viewController.view];
    }
    else
    {
        // use this method on ios6
        [window setRootViewController:_viewController];
    }
    
    [window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
    [Tracking initWithAppKey: @"xxxxxxxxxxxxxxxxxxxx" withChannelId : @"_default_"];//  自己的热云AppKey
    NSLog(@"Tracking initWithAppKey");
    [self checkVersion];
    
//     [reyun initWithAppId:@"efe3d4cd7c7e8f0d42cae2d87d3fb99d" channelID:@"ios"];
    
    //run the cocos2d-x game scene
    app->start();
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
    [[SDKWrapper getInstance] applicationWillResignActive:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    [[SDKWrapper getInstance] applicationDidBecomeActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
    [[SDKWrapper getInstance] applicationDidEnterBackground:application];
    app->applicationDidEnterBackground();
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
    [[SDKWrapper getInstance] applicationWillEnterForeground:application];
    app->applicationWillEnterForeground();
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[SDKWrapper getInstance] applicationWillTerminate:application];
    delete app;
    app = nil;
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


/**
 初始化视频
有参数，有返回值
*/
+(NSString *)initRewardVideo:(NSString*)videoId{
    NSLog(@"OC收到：有参数，有返回值 %@：hello",videoId);
    ChannelSDK *sdk = ChannelSDK::Singleton();
    sdk->initRewardVideo("powerDialog");
    return @"initRewardVideo";
}

+(NSString *)updateGames:(NSString*)userId{
    NSLog(@"OC收到：有参数，有返回值 %@：userId",userId);
//    [[ALAlertView alertView] showAlertViewWithTitle:@"标题" message:@"消息" dismissCallBack:^{
//        NSLog(@"用户点击了确定");
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/cn/app/id12345678?mt=8"]];
//    }];
    [[ALAlertView alertView] showAlertViewWithTitle:@"更新提示" message:@"游戏有新的版本可以更新" cancelButtonTitle:@"取消" cancelCallBack:^{
            NSLog(@"用户点击了取消");
     }otherCallBack:^(NSInteger buttonIndex){
         NSLog(@"用户点击了确定");
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/cn/app/id12345678?mt=8"]];
     } otherButtonTitles:@"确定", nil];
    return @"updateGames";
}
/**
 有参数，有返回值
 点击显示视频
*/
+(NSString *)createVideoAdIOS:(NSString*)videoId{
    NSLog(@"OC收到：有参数，有返回值 %@：hello",videoId);
//    NSString *myname = @"mygame";
//    const char * nameChar =[myname UTF8String];
//    const char * orderIdChar = [videoId UTF8String];
    
    ChannelSDK *sdk = ChannelSDK::Singleton();
    sdk->playRewardVideo("powerDialog","1236064441");
    return @"hello";
}


/**
   注册打点
*/
+(NSString *)registerTrack:(NSString*)user_id{
    NSLog(@"OC收到：registerTrack 有参数%@：",user_id);
    [Tracking setRegisterWithAccountID:user_id];
    return @"registerTrack";
}


/**
   登录打点
*/
+(NSString *)loginTrack:(NSString*)user_id{
    NSLog(@"OC收到：registerTrack 有参数 %@：",user_id);
    [Tracking setLoginWithAccountID:user_id];
    return @"loginTrack";
}

/**
    视频自定义事件
*/
+(NSString *)videoTrack:(NSString*)eventName{
    NSLog(@"OC收到：videoTrack 有参数 %@：",eventName);
    [Tracking setEvent:eventName];
    return @"videoTrack";
}


/// 检查版本更新
- (void)checkVersion {
//    NSURL * url = [NSURL URLWithString:@"http://itunes.apple.com/lookup?id=123456789"];
    NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/cn/lookup?id=123456789"];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary * dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *results = dataDic[@"results"];
        if (results && results.count > 0) {
            NSDictionary *response = results.firstObject;
            NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]; // 软件的当前版本
            NSString *lastestVersion = response[@"version"]; // AppStore 上软件的最新版本
//            lastestVersion = @"2.0.2";//测试 数据 线上注释
            NSLog(@"currentVersion %@：",currentVersion);
            NSLog(@"lastestVersion %@：",lastestVersion);
            if (currentVersion && lastestVersion && ![self isMustLastestVersion:currentVersion compare:lastestVersion]) {
                    NSString * releaseNotes = response[@"releaseNotes"]; // 新版本更新内容
                    NSString * alertContent = [NSString stringWithFormat:@"%@\n\n是否前往 AppStore 更新版本？",releaseNotes];
                    // 给出提示是否前往 AppStore 更新
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"检测到有版本更新" message:alertContent preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        NSString *trackViewUrl = response[@"trackViewUrl"]; // AppStore 上软件的地址
                        if (trackViewUrl) {
                            NSURL *appStoreURL = [NSURL URLWithString:trackViewUrl];
                            if ([[UIApplication sharedApplication] canOpenURL:appStoreURL]) {
                                [[UIApplication sharedApplication] openURL:appStoreURL];
                            }
                        }
                    }]];
//                    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
                }else if (currentVersion && lastestVersion && ![self isLastestVersion:currentVersion compare:lastestVersion]) {
                NSString * releaseNotes = response[@"releaseNotes"]; // 新版本更新内容
                NSString * alertContent = [NSString stringWithFormat:@"%@\n\n是否前往 AppStore 更新版本？",releaseNotes];
                // 给出提示是否前往 AppStore 更新
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"检测到有版本更新" message:alertContent preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction:[UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    NSString *trackViewUrl = response[@"trackViewUrl"]; // AppStore 上软件的地址
                    if (trackViewUrl) {
                        NSURL *appStoreURL = [NSURL URLWithString:trackViewUrl];
                        if ([[UIApplication sharedApplication] canOpenURL:appStoreURL]) {
                            [[UIApplication sharedApplication] openURL:appStoreURL];
                        }
                    }
                }]];
                [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
            }
        }else{
             NSLog(@"未知错误");
        }
    }] resume];
}

/// 判断是否最新版本号（必须更新）
- (BOOL)isMustLastestVersion:(NSString *)currentVersion compare:(NSString *)lastestVersion {
    if (currentVersion && lastestVersion) {
        // 拆分成数组
        NSMutableArray *currentItems = [[currentVersion componentsSeparatedByString:@"."] mutableCopy];
        NSMutableArray *lastestItems = [[lastestVersion componentsSeparatedByString:@"."] mutableCopy];
        // 如果数量不一样补0
        NSInteger currentCount = currentItems.count;
        NSInteger lastestCount = lastestItems.count;
        if (currentCount != lastestCount) {
            NSInteger count = labs(currentCount - lastestCount); // 取绝对值
            for (int i = 0; i < count; ++i) {
                if (currentCount > lastestCount) {
                    [lastestItems addObject:@"0"];
                } else {
                    [currentItems addObject:@"0"];
                }
            }
        }
        // 依次比较
        BOOL isLastest = YES;
        NSString *currentItem = currentItems[0];
        NSString *lastestItem = lastestItems[0];
        if (currentItem.integerValue != lastestItem.integerValue) {
            isLastest = currentItem.integerValue > lastestItem.integerValue;
        }
        return isLastest;
    }
    return NO;
}


/// 判断是否最新版本号（大于或等于为最新）
- (BOOL)isLastestVersion:(NSString *)currentVersion compare:(NSString *)lastestVersion {
    if (currentVersion && lastestVersion) {
        // 拆分成数组
        NSMutableArray *currentItems = [[currentVersion componentsSeparatedByString:@"."] mutableCopy];
        NSMutableArray *lastestItems = [[lastestVersion componentsSeparatedByString:@"."] mutableCopy];
        // 如果数量不一样补0
        NSInteger currentCount = currentItems.count;
        NSInteger lastestCount = lastestItems.count;
        if (currentCount != lastestCount) {
            NSInteger count = labs(currentCount - lastestCount); // 取绝对值
            for (int i = 0; i < count; ++i) {
                if (currentCount > lastestCount) {
                    [lastestItems addObject:@"0"];
                } else {
                    [currentItems addObject:@"0"];
                }
            }
        }
        // 依次比较
        BOOL isLastest = YES;
        for (int i = 0; i < currentItems.count; ++i) {
            NSString *currentItem = currentItems[i];
            NSString *lastestItem = lastestItems[i];
            if (currentItem.integerValue != lastestItem.integerValue) {
                isLastest = currentItem.integerValue > lastestItem.integerValue;
                break;
            }
        }
        return isLastest;
    }
    return NO;
}


// ----------------------第二次热云 Game 打点  start
//
///**
//   注册打点
//*/
//+(NSString *)registerGameTrack:(NSString*)user_id{
//    NSLog(@"OC收到：registerTrack 有参数%@：",user_id);
////    [reyun setRegisterWithAccountID:user_id andGender:o andage:@"-1" andServerId:@"1" andAccountType:@"registered" andRole:user_id];
//    return @"registerGameTrack";
//}
//
//
///**
//   登录打点
//*/
//+(NSString *)loginGameTrack:(NSString*)user_id withContent:(int)rank{
//    NSLog(@"OC收到：registerTrack 有参数 %@ %d：",user_id,rank);
////    [reyun setLoginWithAccountID:user_id andGender:o andage:@"-1" andServerId:@"1" andlevel:rank andRole:user_id];
//    return @"loginGameTrack";
//}
//
///**
//   自定义事件打点
//*/
//+(NSString *)customGameTrack:(NSString*) user_id loginDay:(int)loginDay videoCount:(int)videoCount{
//    NSLog(@"OC收到：registerTrack 有参数 %@ %d %d：",user_id,loginDay,videoCount);
//    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"user_id",@"1",@"loginDay",@"1",@"videoCount",@"1",nil];
//    [reyun setEvent:@"value" andExtra:dic];
//    return @"customGameTrack";
//}
// ----------------------第二次热云 Game 打点  over
@end

