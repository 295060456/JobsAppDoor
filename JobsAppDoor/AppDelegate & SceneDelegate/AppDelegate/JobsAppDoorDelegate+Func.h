//
//  JobsAppDoorDelegate+Func.h
//  JobsAppDoor
//
//  Created by Jobs on 2021/1/25.
//

#import "JobsAppDoorDelegate.h"

#if __has_include(<TABAnimated/TABAnimated.h>)
#import <TABAnimated/TABAnimated.h>
#else
#import "TABAnimated.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface JobsAppDoorDelegate (Func)

#pragma mark —— 全局配置 TABAnimated
-(void)makeTABAnimatedConfigure;

@end

NS_ASSUME_NONNULL_END
