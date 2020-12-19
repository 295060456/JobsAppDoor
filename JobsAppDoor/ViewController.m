//
//  ViewController.m
//  JobsAppDoor
//
//  Created by Jobs on 2020/12/7.
//

#import "ViewController.h"

#import "JobsAppDoorVC_Style1.h"
#import "JobsAppDoorVC_Style2.h"
#import "DDForgetCodeVC.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)viewDidLoad{
    self.view.backgroundColor = kRedColor;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches
          withEvent:(UIEvent *)event{
//    尝试高仿蜜柚 登录注册忘记密码
//    [UIViewController comingFromVC:self
//                              toVC:JobsAppDoorVC_Style1.new
//                       comingStyle:ComingStyle_PRESENT
//                 presentationStyle:UIModalPresentationFullScreen//[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
//                     requestParams:@(JobsAppDoorBgType_video)
//          hidesBottomBarWhenPushed:YES
//                          animated:YES
//                           success:^(id data) {
//
//    }];
//    //我自己写的
    [UIViewController comingFromVC:self
                              toVC:JobsAppDoorVC_Style2.new
                       comingStyle:ComingStyle_PRESENT
                 presentationStyle:UIModalPresentationFullScreen//[UIDevice currentDevice].systemVersion.doubleValue >= 13.0 ? UIModalPresentationAutomatic : UIModalPresentationFullScreen
                     requestParams:@(JobsAppDoorBgType_video)
          hidesBottomBarWhenPushed:YES
                          animated:YES
                           success:^(id data) {

    }];
}


@end
