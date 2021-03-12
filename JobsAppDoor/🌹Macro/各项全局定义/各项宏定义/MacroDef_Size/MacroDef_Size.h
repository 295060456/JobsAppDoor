//
//  MacroDef_Size.h
//  JobsAppDoor
//
//  Created by Jobs on 2020/12/16.
//

#ifndef MacroDef_Size_h
#define MacroDef_Size_h

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

//非刘海屏：状态栏高度(20.f) + 导航栏高度(44.f) = 64.f
//刘海屏系列：状态栏高度(44.f) + 导航栏高度(44.f) = 88.f
static inline CGFloat Top(){
    static CGFloat value = 0;
    static dispatch_once_t once_t = 0;
    dispatch_once(&once_t, ^{
        value = isiPhoneX_series() ? 88.0f : 64.0f;
    });return value;
}
#pragma mark —— 状态栏高度：全面屏手机的状态栏高度为44pt，非全面屏手机的状态栏高度为20pt
//方法一：状态栏高度
static inline CGFloat rectOfStatusbar(){
    SuppressWdeprecatedDeclarationsWarning(CGFloat RectOfStatusbar = 0.0f;
                                           if (@available(iOS 13.0, *)){
                                               id WINDOW = UIApplication.sharedApplication.windows.firstObject;
                                               if ([WINDOW isKindOfClass:UIWindow.class]) {
                                                   UIWindow *window = (UIWindow *)WINDOW;
                                                   UIWindowScene *windowScene = window.windowScene;
                                                   UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
                                                   if (statusBarManager.statusBarHidden == NO) {
                                                       RectOfStatusbar = statusBarManager.statusBarFrame.size.height;
                                       //                statusBarManager.statusBarFrame.mj_h
                                                   }else{}
                                               }
                                           }else{
                                               RectOfStatusbar = UIApplication.sharedApplication.statusBarFrame.size.height;
                                           }return RectOfStatusbar);
}
//方法二：状态栏高度
static inline CGFloat StatusBarHeight(){
    return [[UIApplication sharedApplication] delegate].window.safeAreaInsets.top;
}
//导航栏高度
static inline CGFloat NavigationHeight(){
    NSLog(@"%f",StatusBarHeight());
    return 44;
}
//导航栏高度 + 状态栏高度
static inline CGFloat NavigationBarAndStatusBarHeight(){
    return StatusBarHeight() + NavigationHeight();
}
//tabbar高度：全面屏手机比普通手机多34的安全区域
static inline CGFloat TabBarHeight(){
    return [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom + 50;
}
//顶部的安全距离
static inline CGFloat TopSafeAreaHeight(){
    return [[UIApplication sharedApplication] delegate].window.safeAreaInsets.top;
}
//底部的安全距离，全面屏手机为34pt，非全面屏手机为0pt
static inline CGFloat BottomSafeAreaHeight(){
    NSLog(@"%f",TabBarHeight());
    return [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
}
#endif /* MacroDef_Size_h */
