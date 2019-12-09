//
//  ChannelSDK.mm
//  myysx-mobile
//
//  Created by smile on 2019/11/12.
//

#include "ChannelSDK.h"
#include "cocos2d.h"
#include "BuAdSdkConnector.h"

#ifdef  CHANNEL_MUYOUZYJ
@interface ChannelSDKCallbackHandler:UIViewController
#else
@interface ChannelSDKCallbackHandler:UIViewController
#endif
+ (ChannelSDKCallbackHandler*)sharedHandler;
@end
ChannelSDK* ChannelSDK::__instance__ = NULL;
ChannelSDK* ChannelSDK::Singleton(){
     if(ChannelSDK::__instance__ == NULL)
     {
         ChannelSDK::__instance__ = new ChannelSDK();
     }
     return ChannelSDK::__instance__;
};
 void ChannelSDK::Init(){
     CCLOG("ChannelSDK::Init");
     this->needLogin = false;
     this->ok = false;
     this->isLogin = false;
     this->user_id = 0;
 };

void ChannelSDK::Login(){
    printf("登录成功\n");
    initBuAdSdkWarpper();
};


void ChannelSDK::initRewardVideo(std::string name){
    NSString *myname = [[NSString alloc] initWithUTF8String:name.c_str()];
    const char * nameChar = [myname UTF8String];
    initAndCacheRewardVideosWithDeviceId();
}



void ChannelSDK::playRewardVideo(std::string name,std::string orderId){
    NSString *myname = [[NSString alloc] initWithUTF8String:name.c_str()];
    NSString *myorderId = [[NSString alloc] initWithUTF8String:orderId.c_str()];
    const char * nameChar =[myname UTF8String];
    const char * orderIdChar = [myorderId UTF8String];
    showRewardVideoWithName(nameChar, orderIdChar);
}



