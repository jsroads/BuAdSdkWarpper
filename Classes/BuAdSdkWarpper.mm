//
//  BuAdSdkWarpper.m
//  myysx-mobile
//
//  Created by smile on 2019/11/12.
//

#import "BuAdSdkWarpper.h"
#import <UIKit/UIKit.h>
#import <BUAdSDK/BUAdSDKManager.h>
#import <BUAdSDK/BUSize.h>
#import <BUAdSDK/BURewardedVideoModel.h>
//#include "cocos/scripting/js-bindings/manual/ScriptingCore.h"
//#include "cocos/scripting/js-bindings/manual/ScriptingCore.h"
#include "cocos/scripting/js-bindings/jswrapper/SeApi.h"
#import "cocos2d.h"

@interface BuAdSdkWarpper () <BUBannerAdViewDelegate>
@property(nonatomic, strong) BUBannerAdView *carouselBannerView;

@end

@implementation BuAdSdkWarpper

//#define ENABLE_LOG
#ifdef ENABLE_LOG
# define DLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

- (id)init {
    if ((self = [super init]) != nil) {
//        [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
        [BUAdSDKManager setAppID:@"5036064"];
        NSLog(@"set appid success");
    }
    
    return self;
}

- (void)initAndCacheFullscreenVideo {
    self.fullscreenVideo = [[BUFullscreenVideoAd alloc] initWithSlotID:@"915798753"];
    self.fullscreenVideo.delegate = self;
    [self.fullscreenVideo loadAdData];
}

- (bool)hasCachedFullscreenVideo {
   // return self.fullscreenVideo != nil && self.fullscreenVideo.adValid;
    if (self.fullscreenVideo != nil) {
        NSLog(@"hasCachedFullscreenVideo-------");
        return [self.fullscreenVideo isAdValid];
    } else {
        NSLog(@"hasCachedFullscreenVideo-----NO--");
        return NO;
    }
}

- (void)showFullscreenVideo {
    if ([self hasCachedFullscreenVideo]) {
        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        if (rootViewController != nil) {
            isFullscreenVideoPlayFinish = false;
            [self.fullscreenVideo showAdFromRootViewController:rootViewController];
        }
    } else {
        [self initAndCacheFullscreenVideo];
    }
    
//    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
//    if (rootViewController != nil) {
//        isFullscreenVideoPlayFinish = false;
//        [self.fullscreenVideo showAdFromRootViewController:rootViewController];
//    }
}
#pragma mark BURewardedVideoAdDelegate

- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"fullscreenVideoAd data load success");
}

- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
    NSLog(@"fullscreenVideoAd data load fail");
}

//- (void)showAdFromRootViewController:(BUFullscreenVideoAd *)fullscreenVideoAd {
//    NSLog(@"fullscreenVideoAdVideoDataDidLoad");
//}

- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"fullscreenVideoAd video load success");
}

- (void)fullscreenVideoAdDidClickSkip:(BUFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"fullscreenVideoAd click skip");
}

- (void)fullscreenVideoAdWillVisible:(BUFullscreenVideoAd *)fullscreenVideoAd {
    NSLog(@"fullscreenVideoAdWillVisible");
}

- (void)fullscreenVideoAdDidClose:(BUFullscreenVideoAd *)fullscreenVideoAd {
    [self initAndCacheInterVideoWithName:@"powerDialogx"];
    [self callbackToSwiftFull:isInterVideoPlayFinish  name:@"fullsreen"];
}

- (void)fullscreenVideoAdDidClickDownload:(BUFullscreenVideoAd *)fullscreenVideoAd {
    
}


- (void)fullscreenVideoAdDidPlayFinish:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error {
       isInterVideoPlayFinish = !error;
}

#pragma RewardVideo

- (void)initAndCacheRewardVideosWithDeviceId:(NSString*)deviceId {
    if (self.rewardedVideos == nil) {
        self.rewardedVideos = [NSMutableDictionary dictionary];
    }
    
    rewardedVideoUserId = deviceId;
    
    [self initAndCacheRewardVideoWithName:@"powerDialog"];
}

- (void)initAndCacheInterVideosWithDeviceId:(NSString*)deviceId {
    if (self.interVideos == nil) {
        self.interVideos = [NSMutableDictionary dictionary];
    }
    interVideoUserId = deviceId;
    [self initAndCacheInterVideoWithName:@"powerDialogx"];
}


- (void)initAndCacheInterVideoWithName:(NSString*)name {
    
    NSString* slotID = @"";
    //    if ([name isEqual:@"powerDialog"]) {
    //        slotID = @"914039050";
    //    }
    slotID = @"915798753";
    
    BUFullscreenVideoAd *interstitialVideo =  [[BUFullscreenVideoAd alloc] initWithSlotID:slotID];
    interstitialVideo.delegate = self;
    [self.interVideos setValue:interstitialVideo forKey:name];
    [interstitialVideo loadAdData];
}


- (void)initAndCacheRewardVideoWithName:(NSString*)name {
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = rewardedVideoUserId;
    model.rewardName = name;
    
    NSString* slotID = @"";
//    if ([name isEqual:@"powerDialog"]) {
//        slotID = @"914039050";
//    }
    slotID = @"936064441";
    
    BURewardedVideoAd* rewardedVideo = [[BURewardedVideoAd alloc] initWithSlotID:slotID rewardedVideoModel:model];
    rewardedVideo.delegate = self;
    [self.rewardedVideos setValue:rewardedVideo forKey:name];
    
    if ([self hasCachedRewardVideoWithName:name]) {
        NSLog(@"hasCachedRewardVideoWithName");
    }else{
        NSLog(@"NOT in the map");
    }
    
    [rewardedVideo loadAdData];
    
}

- (bool)hasCachedRewardVideoWithName:(NSString*)name {
//    NSLog(name);
    if (self.rewardedVideos[name] != nil) {
        return [self.rewardedVideos[name] isAdValid];
    } else {
        return NO;
    }
}

- (bool)hasCachedInterVideoWithName:(NSString*)name {
    if (self.interVideos[name] != nil) {
        return [self.interVideos[name] isAdValid];
    } else {
        return NO;
    }
}

- (void)showRewardVideoWithName:(NSString*)name orderId:(NSString*) orderId{
    if ([self hasCachedRewardVideoWithName:name]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity: 1];
//        [dict setObject:orderId forKey:@"orderId"];
        [dict setObject:rewardedVideoUserId forKey:@"orderId"];

        NSError* error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
        NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

        ((BURewardedVideoAd*) self.rewardedVideos[name]).rewardedVideoModel.extra = jsonString;
        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        NSLog(@"Here");
        if (rootViewController != nil) {
            isRewardedVideoPlayFinish = false;
            NSLog(@"Here");
            [self.rewardedVideos[name] showAdFromRootViewController:rootViewController];
        }
    } else {
        [self initAndCacheRewardVideoWithName:name];
    }
}

- (void)showInterVideoWithName:(NSString*)name orderId:(NSString*) orderId{

    if ([self hasCachedInterVideoWithName:name]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity: 1];
        [dict setObject:orderId forKey:@"orderId"];
        
        //NSError* error;
        //NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
        // NSString *jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
        // ((BUInterstitialAd*) self.interVideos[name]).rewardedVideoModel.extra = jsonString;
        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        if (rootViewController != nil) {
            isInterVideoPlayFinish = false;
            [self.interVideos[name] showAdFromRootViewController:rootViewController];
        }
    } else {
        [self initAndCacheInterVideoWithName:name];
    }
}



- (void)IosNativeInitBuAdSdk:(BURewardedVideoAd *)rewardedVideoAd {
   NSLog(@"reawrded video did load");
//    UnitySendMessage("LevelManager", "Get_RewardedVideo", "");
}
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewardedVideoAd data load success");
}
- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewardedVideoAd video load success");
}

- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd {
   NSLog(@"rewardedVideoAd video will visible");
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
   NSLog(@"rewardedVideoAd video did close");
    NSString *name = [[rewardedVideoAd rewardedVideoModel] rewardName];
    [self initAndCacheRewardVideoWithName:name];
//    [self callbackToSwift:isRewardedVideoPlayFinish extra: rewardedVideoAd.rewardedVideoModel.extra name:name];
    [self callJsEngineCallBack:isRewardedVideoPlayFinish extra: rewardedVideoAd.rewardedVideoModel.extra name:name];
}

- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewardedVideoAd video did click");
}

- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    NSLog(@"rewardedVideoAd data load fail",error);
}

- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error {
    if (error) {
        NSLog(@"rewardedVideoAd play error");
    } else {
        NSLog(@"rewardedVideoAd play finish");
        isRewardedVideoPlayFinish = true;
    }
}

- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd {
    NSLog(@"rewardedVideoAd verify failed");
    
    NSLog(@"Demo RewardName == %@", rewardedVideoAd.rewardedVideoModel.rewardName);
    NSLog(@"Demo RewardAmount == %ld", (long)rewardedVideoAd.rewardedVideoModel.rewardAmount);
}

- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify{
    NSLog(@"rewardedVideoAd verify succeed");
    NSLog(@"verify result: %@", verify ? @"success" : @"fail");
    
    NSLog(@"Demo RewardName == %@", rewardedVideoAd.rewardedVideoModel.rewardName);
    NSLog(@"Demo RewardAmount == %ld", (long)rewardedVideoAd.rewardedVideoModel.rewardAmount);
}




- (void)showBanner {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;

    BUSize *size = [BUSize sizeBy:BUProposalSize_Banner600_150];
    self.bannerView = [[BUBannerAdView alloc] initWithSlotID:@"915798388" size:size rootViewController:rootViewController];
    [self.bannerView loadAdData];

    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGFloat bannerHeight = screenWidth * size.height / size.width;
    self.bannerView.frame = CGRectMake(0, screenHeight - bannerHeight, screenWidth, bannerHeight);
    self.bannerView.delegate = self;
    [rootViewController.view addSubview:self.bannerView];
}

- (void)hideBanner {
    [[self bannerView] removeFromSuperview];
    self.bannerView = nil;
}

- (void)bannerAdViewDidLoad:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd {
    NSLog(@"banner data load sucess");
}

- (void)bannerAdViewDidBecomVisible:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd {
    NSLog(@"banner becomVisible");
}

- (void)bannerAdViewDidClick:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd {
    NSLog(@"banner AdViewDidClick");
}

- (void)bannerAdView:(BUBannerAdView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {
    NSLog(@"banner data load faiule");
}

- (void)bannerAdView:(BUBannerAdView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords {
    [UIView animateWithDuration:0.25 animations:^{
        bannerAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [bannerAdView removeFromSuperview];
        if (self.bannerView == bannerAdView) {
            self.bannerView = nil;
        }
        if (self.carouselBannerView == bannerAdView) {
            self.carouselBannerView = nil;
        }
    }];
}

- (void)checkState {
    if (![self hasCachedFullscreenVideo]) {
        [self initAndCacheFullscreenVideo];
    }
    
    if (![self hasCachedRewardVideoWithName:@"powerDialog2"]) {
        [self initAndCacheRewardVideoWithName:@"powerDialog2"];
    }
}

-(void)callbackToSwiftFull:(BOOL) successful  name:(NSString*) name {
    
    NSMutableDictionary *dictRoot = [NSMutableDictionary dictionaryWithCapacity: 1];
    NSNumber* successfulNumber = [NSNumber numberWithBool:successful];
    [dictRoot setObject:successfulNumber forKey:@"successful"];


    NSMutableString *fn = [NSMutableString string];
    [fn appendString:@"cc.Ads.backHomeCallBack()"];
   
    //  const char fnChar = [fn UTF8String];
    const char * fnChar = [fn UTF8String];
    se::ScriptEngine::getInstance()->evalString(fnChar);
}

-(void)callbackToSwift:(BOOL) successful extra:(NSString*) extra name:(NSString*) name {
    NSMutableString *fn = [NSMutableString string];
    [fn appendString:@"cc.AdCallback.getAdReward('"];
    [fn appendString:name];
    [fn appendString:@"')"];
//  const char fnChar = [fn UTF8String];
    const char * fnChar = [fn UTF8String];
//    se::ScriptEngine::getInstance()->evalString(fnChar);
    se::ScriptEngine::getInstance()->evalString("cc.find('AdviceAlter').getComponent('AdviceAlter').success()", NULL);
}

-(void)callJsEngineCallBack:(BOOL) successful extra:(NSString*) extra name:(NSString*) name {
    NSLog(@"callJsEngineCallBack...");
    NSString *funcNameStr = @"finishRewardVideo";
    std::string funcName = [funcNameStr UTF8String];
    NSNumber *successfulNumber = [NSNumber numberWithBool:successful];
    std::string finish = "fail";
    if(successful == true){
        finish = "success";
    }
    std::string jsCallStr = cocos2d::StringUtils::format("%s(\"%s\");",funcName.c_str(),finish.c_str());
    NSLog(@"jsCallStr = %s", jsCallStr.c_str());
    se::ScriptEngine::getInstance()->evalString(jsCallStr.c_str());
}

@end


