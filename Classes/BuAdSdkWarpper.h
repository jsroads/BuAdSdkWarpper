//
//  BuAdSdkWarpper.h
//  myysx
//
//  Created by smile on 2019/11/12.
//

#import <Foundation/Foundation.h>
#include <functional>
#include <string>
#import <BUAdSDK/BUFullscreenVideoAd.h>
#import <BUAdSDK/BURewardedVideoAd.h>
#import <BUAdSDK/BUBannerAdView.h>

using namespace std;

@interface BuAdSdkWarpper : NSObject <BUFullscreenVideoAdDelegate, BURewardedVideoAdDelegate, BUBannerAdViewDelegate> {
    NSString* rewardedVideoUserId;
    NSString* interVideoUserId;
    bool isRewardedVideoPlayFinish;
    bool isInterVideoPlayFinish;
    bool isFullscreenVideoPlayFinish;
}

@property(nonatomic, strong) BUFullscreenVideoAd *fullscreenVideo;
@property(nonatomic, strong) NSMutableDictionary *rewardedVideos;
@property(nonatomic, strong) NSMutableDictionary *interVideos;
@property(nonatomic, strong) BUBannerAdView *bannerView;

- (id)init;

- (void)initAndCacheFullscreenVideo;

- (bool)hasCachedFullscreenVideo;

- (void)showFullscreenVideo;

- (void)initAndCacheInterVideosWithDeviceId:(NSString*)deviceId;

- (void)initAndCacheRewardVideosWithDeviceId:(NSString*)deviceId;

- (void)initAndCacheRewardVideoWithName:(NSString*)name;

- (void)initAndCacheInterVideoWithName:(NSString*)name;

- (bool)hasCachedRewardVideoWithName:(NSString*)name;

- (bool)hasCachedInterVideoWithName:(NSString*)name;

- (void)showRewardVideoWithName:(NSString*)name orderId:(NSString*)orderId;

- (void)showInterVideoWithName:(NSString*)name orderId:(NSString*)orderId;

- (void)showBanner;

- (void)hideBanner;

- (void)checkState;

@end
