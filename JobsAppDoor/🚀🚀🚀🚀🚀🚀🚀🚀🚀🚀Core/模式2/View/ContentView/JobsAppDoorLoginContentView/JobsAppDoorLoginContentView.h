//
//  LoginContentView.h
//  Shooting
//
//  Created by Jobs on 2020/9/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobsAppDoorInputView.h"
#import "JobsAppDoorConfig.h"
#import "BaseContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface JobsAppDoorLoginContentView : BaseContentView

-(void)richElementsInViewWithModel:(id _Nullable)contentViewModel;//外层数据渲染
-(void)actionBlockLoginContentView:(MKDataBlock)loginContentViewBlock;

@end

NS_ASSUME_NONNULL_END
