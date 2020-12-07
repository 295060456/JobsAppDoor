//
//  main.m
//  JobsAppDoor
//
//  Created by Jobs on 2020/12/7.
//

#import <UIKit/UIKit.h>
#import "JobsAppDoorDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([JobsAppDoorDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
