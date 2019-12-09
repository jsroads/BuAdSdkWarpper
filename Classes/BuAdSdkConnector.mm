//
//  BuAdSdkConnector.mm
//  myysx-mobile
//
//  Created by smile on 2019/11/12.
//

#import <Foundation/Foundation.h>
#import "BuAdSdkConnector.h"
#import "BuAdSdkWarpper.h"

#if defined(__cplusplus)
extern "C" {
#endif
    static BuAdSdkWarpper *buAdSdkWarpper;
    
    void initBuAdSdkWarpper() {
        if (buAdSdkWarpper == nil) {
            buAdSdkWarpper = [[BuAdSdkWarpper alloc] init];
        }
    }
    
    void initAndCacheFullscreenVideo() {
        [buAdSdkWarpper initAndCacheFullscreenVideo];
    }
    
    bool hasCachedFullscreenVideo() {
        return [buAdSdkWarpper hasCachedFullscreenVideo];
    }
    
    void showFullscreenVideo() {
        [buAdSdkWarpper showFullscreenVideo];
    }
    
    void initAndCacheRewardVideosWithDeviceId() {
        NSString* mGuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [buAdSdkWarpper initAndCacheRewardVideosWithDeviceId:mGuid];
    }
    
    void initAndCacheInterVideosWithDeviceId() {
        NSString* mGuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [buAdSdkWarpper initAndCacheInterVideosWithDeviceId:mGuid];
    }
    
//    void initAndCacheRewardVideoWithName(const char* name) {
//        NSString* nameString = [[NSString alloc] initWithUTF8String: name];
//        [buAdSdkWarpper initAndCacheRewardVideoWithName:nameString];
//    }
    void initAndCacheRewardVideoWithName(const char* name) {
//        NSString* nameString = @"powerDialog2";
        NSString* nameString = [[NSString alloc] initWithUTF8String: name];
        [buAdSdkWarpper initAndCacheRewardVideoWithName:nameString];
    }
    
    void initAndCacheInterVideoWithName(const char* name) {
        //        NSString* nameString = @"powerDialog2";
        NSString* nameString = [[NSString alloc] initWithUTF8String: name];
        [buAdSdkWarpper initAndCacheInterVideoWithName:nameString];
    }
    
//    bool hasCachedRewardVideoWithName(const char* name) {
//        NSString* nameString = [[NSString alloc] initWithUTF8String: name];
////        return [buAdSdkWarpper hasCachedRewardVideoWithName:nameString];
//
//    }
    bool hasCachedRewardVideoWithName(const char* name) {
        NSString* nameString = [[NSString alloc] initWithUTF8String: name];
        return [buAdSdkWarpper hasCachedRewardVideoWithName:nameString];
    }
    
    bool hasCachedInterVideoWithName(const char* name) {
        NSString* nameString = [[NSString alloc] initWithUTF8String: name];
        return [buAdSdkWarpper hasCachedInterVideoWithName:nameString];
    }
    
//    void showRewardVideoWithName(NSString* nameString, NSString* orderIdString) {
    
    void showRewardVideoWithName(const char* name, const char* orderId) {
        NSString *nameString = [[NSString alloc] initWithUTF8String: name];
        NSString *orderIdString = [[NSString alloc] initWithUTF8String: orderId];
//        NSString *str = [[NSString alloc] initWithUTF8String:strc];
//        NSString* nameString = @"Reward";
//        NSString* orderIdString = @"123";
        [buAdSdkWarpper showRewardVideoWithName:nameString orderId: orderIdString];
    }
    
    void showInterVideoWithName(const char* name, const char* orderId) {
        NSString *nameString = [[NSString alloc] initWithUTF8String: name];
        NSString *orderIdString = [[NSString alloc] initWithUTF8String: orderId];
        //        NSString *str = [[NSString alloc] initWithUTF8String:strc];
        //        NSString* nameString = @"Reward";
        //        NSString* orderIdString = @"123";
        [buAdSdkWarpper showInterVideoWithName:nameString orderId: orderIdString];
    }
    
    void showBanner() {
        [buAdSdkWarpper showBanner];
    }
    
    void hideBanner() {
        [buAdSdkWarpper hideBanner];
    }
    
    void checkState() {
        [buAdSdkWarpper checkState];
    }
#if defined(__cplusplus)
}
#endif

