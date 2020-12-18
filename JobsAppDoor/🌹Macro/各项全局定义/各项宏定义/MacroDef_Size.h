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

#endif /* MacroDef_Size_h */
