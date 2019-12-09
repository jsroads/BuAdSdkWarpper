//
//  BuAdSdkConnector.h
//  myysx
//
//  Created by smile on 2019/11/12.
//
#include <string>

#if defined(__cplusplus)
extern "C" {
#endif
    void initBuAdSdkWarpper();
    void initAndCacheFullscreenVideo();
    
    bool hasCachedFullscreenVideo();
    void showFullscreenVideo();
    void initAndCacheRewardVideosWithDeviceId();
    void initAndCacheInterVideosWithDeviceId();
    void initAndCacheRewardVideoWithName(const char* name);
    void initAndCacheInterVideoWithName(const char* name);
    bool hasCachedRewardVideoWithName(const char* name);
    bool hasCachedInterVideoWithName(const char* name);
    void showRewardVideoWithName(const char* name, const char* orderId);
    void showInterVideoWithName(const char* name, const char* orderId);
    
//    void showRewardVideoWithName(NSString* name, NSString* orderId);
    void showBanner();
    void hideBanner();
    void checkState();
#if defined(__cplusplus)
}
#endif
