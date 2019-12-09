//
//  ChannelSDK.h
//  myysx-mobile
//
//  Created by smile on 2019/11/12.
//
#ifndef SanGuo_xy_ChannelSDK_h
#define SanGuo_xy_ChannelSDK_h
#include "cocos2d.h"

USING_NS_CC;
#include <string>

class ChannelSDK
{
public:
    
    
    static ChannelSDK* Singleton();
    virtual void Init();
    virtual void Login();
    virtual void initRewardVideo(std::string name);
    virtual void playRewardVideo(std::string name,std::string orderId);
    std::string channelName;
    bool        ok;
    bool        needLogin;
    bool        isLogin;
    int         user_id;
private:
    static ChannelSDK* __instance__;
};
#endif
