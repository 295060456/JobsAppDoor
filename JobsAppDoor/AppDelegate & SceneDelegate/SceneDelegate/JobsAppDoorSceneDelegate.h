//
//  JobsAppDoorSceneDelegate.h
//  JobsAppDoor
//
//  Created by Jobs on 2020/12/7.
//

#import <UIKit/UIKit.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@interface JobsAppDoorSceneDelegate : UIResponder <UIWindowSceneDelegate>

@property(nonatomic,strong)UIWindow *window;
@property(nonatomic,strong)UIWindowScene *windowScene;

+(instancetype)sharedInstance;

@end

#pragma clang diagnostic pop
