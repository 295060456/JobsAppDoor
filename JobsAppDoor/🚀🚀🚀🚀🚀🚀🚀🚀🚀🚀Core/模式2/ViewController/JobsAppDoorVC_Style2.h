//
//  JobsAppDoorVC_Style2.h
//  JobsAppDoor
//
//  Created by Jobs on 2020/12/7.
//

#import "BaseViewController.h"
#import "JobsAppDoorConfig.h"
#import "JobsAppDoorLogoContentView.h"
#import "JobsAppDoorLoginContentView.h"
#import "JobsAppDoorRegisterContentView.h"

#pragma mark —— ZFPlayer 播放器相关
//Core
#import "ZFPlayer.h"
//AVPlayer
#import <ZFPlayer/ZFAVPlayerManager.h>
//ijkplayer
#import <ZFPlayer/ZFIJKPlayerManager.h>
//ControlView
#import <ZFPlayer/UIImageView+ZFCache.h>
#import <ZFPlayer/UIView+ZFFrame.h>
#import <ZFPlayer/ZFLandScapeControlView.h>
#import <ZFPlayer/ZFLoadingView.h>
#import <ZFPlayer/ZFNetworkSpeedMonitor.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFPortraitControlView.h>
#import <ZFPlayer/ZFSliderView.h>
#import <ZFPlayer/ZFSmallFloatControlView.h>
#import <ZFPlayer/ZFSpeedLoadingView.h>
#import <ZFPlayer/ZFUtilities.h>
#import <ZFPlayer/ZFVolumeBrightnessView.h>

#import "CustomZFPlayerControlView.h"//播放器的控制层

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, DoorBgType){
    doorBgType_Image = 0,//背景只是一张图
    doorBgType_video//背景是视频资源
};
//注册和登录共用一个控制器DoorVC；忘记密码单独一个控制器
@interface JobsAppDoorVC_Style2 : BaseViewController

@end

NS_ASSUME_NONNULL_END
