//
//  JobsAppDoorDelegate.h
//  JobsAppDoor
//
//  Created by Jobs on 2020/12/7.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface JobsAppDoorDelegate : UIResponder <UIApplicationDelegate>

@property(readonly,strong)NSPersistentCloudKitContainer *persistentContainer;
@property(nonatomic,strong)UIWindow *window;//仅仅为了iOS 13 版本向下兼容而存在

- (void)saveContext;
+(instancetype)sharedInstance;

@end

