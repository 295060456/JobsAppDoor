//
//  Manual_Add_ThirdParty.h
//  My_BaseProj
//
//  Created by 刘赓 on 2019/9/26.
//  Copyright © 2019 Corp. All rights reserved.
//

#ifndef Manual_Add_ThirdParty_h
#define Manual_Add_ThirdParty_h

// 屏幕大小、宽、高
#ifndef SCREEN_BOUNDS
#define SCREEN_BOUNDS [UIScreen mainScreen].bounds
#endif
#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif
#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#endif

#import "AABlock.h"
#import "YBNotificationManager.h"
#import "TimerManager.h"

#import "MacroDef_App.h"
#import "MacroDef_Cor.h"
#import "MacroDef_Func.h"
#import "MacroDef_Sys.h"

//BaseCustomizeUIKit
//NSObject
#import "NSObject+Extras.h"
#import "NSObject+Measure.h"
#import "NSObject+OpenURL.h"
#import "NSObject+Random.h"
#import "NSObject+RichText.h"
#import "NSObject+Time.h"
//UIButton
#import "UIButton+CountDownBtn.h"//💰VerifyCodeButton
#import "UIButton+ImageTitleSpacing.h"//高度自定义的按钮
//UITextField
#import "CJTextField.h"
#import "HQTextField.h"
#import "JobsMagicTextField.h"
#import "UITextField+Extend.h"
#import "ZYTextField.h"
//UIViewController
//BaseViewController
#import "BaseViewController.h"
//UIViewController+Category
#import "UIViewController+BaseVC.h"
#import "UIViewController+BackBtn.h"
//UIView
#import "UIView+Animation.h"
#import "UIView+Chain.h"
#import "UIView+Extras.h"
#import "UIView+Gradient.h"
#import "UIView+Measure.h"
#import "UIView+SuspendView.h"
#import "UIView+ZFPlayer.h"
//NSString
#import "NSString+Extras.h"
//UIImage
#import "LoadingImage.h"

#import "AppDelegate.h"
#import "SceneDelegate.h"

#endif /* Manual_Add_ThirdParty_h */
