//
//  JobsAppDoorDelegate+Func.m
//  JobsAppDoor
//
//  Created by Jobs on 2021/1/25.
//

#import "JobsAppDoorDelegate+Func.h"

@implementation JobsAppDoorDelegate (Func)

#pragma mark —— 全局配置 TABAnimated
-(void)makeTABAnimatedConfigure{
    [[TABAnimated sharedAnimated] initWithOnlySkeleton];
    [TABAnimated sharedAnimated].openLog = YES;
}

@end
