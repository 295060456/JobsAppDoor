//
//  NetworkingAPI.h
//  DouYin
//
//  Created by Jobs on 2020/9/24.
//

#import <Foundation/Foundation.h>
#import "RequestTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingAPI : NSObject
#pragma mark —— 普通的网络请求
/// 【只有Body参数、不需要错误回调】
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock;
///【只有Body参数、需要错误回调的】
+(void)requestApi:(NSString *_Nonnull)requestApi
       parameters:(id _Nullable)parameters
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock;
#pragma mark —— 特殊的上传文件的网络请求
/// 上传【图片】文件的网络请求
+(void)requestApi:(NSString *_Nonnull)requestApi
uploadImagesParamArr:(NSArray *)uploadImagesParamArr
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock;
/// 上传【视频】文件的网络请求
+(void)requestApi:(NSString *_Nonnull)requestApi
uploadVideosParamArr:(NSArray *)uploadVideosParamArr
     successBlock:(MKDataBlock)successBlock
     failureBlock:(MKDataBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END

/**
 示例代码：【一般的网络请求，只带body参数，最多也就是自定义header】
 -(void)networking_messageSecondClassListGET{
     NSLog(@"当前是否有网：%d 状态：%ld",[ZBRequestManager isNetworkReachable],(long)[ZBRequestManager networkReachability]);
     [DataManager sharedInstance].tag = [ReuseIdentifier stringByAppendingString:NSStringFromSelector(_cmd)];
     [RequestTool initConfig];//公共配置、插件机制、证书设置
     @weakify(self)
     NSDictionary *parameters = @{};
     [DDNetworkingAPI requestApi:NSObject.messageSecondClassListGET.funcName
                      parameters:parameters
                    successBlock:^(id data) {
         @strongify(self)
     }failureBlock:^(id data) {
         @strongify(self)
     }];
 }
 
 /// 邀请好友
 +(void)userInfoInviteFriendPOST:(id)parameters
                    successBlock:(MKDataBlock)successBlock{
 //    NSDictionary *parameterss = @{};
 //    NSDictionary *headers = @{};
     
     [ZBRequestManager requestWithConfig:^(ZBURLRequest * _Nullable request) {

         request.server = NSObject.BaseUrl;
         request.url = [request.server stringByAppendingString:NSObject.userInfoInviteFriendPOST.url];
         
         NSLog(@"request.URLString = %@",request.url);
         
         request.methodType = ZBMethodTypePOST;//默认为GET
         request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
         request.parameters = parameters;//与公共配置 Parameters 兼容
 //        request.headers = headers;//与公共配置 Headers 兼容
         request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
         request.timeoutInterval = 10;//默认30 //优先级 高于 公共配置,不影响其他请求设置
         if (![NSString isNullString:[DataManager sharedInstance].tag]) {
             request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
         };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
         
         {
 //            request.filtrationCacheKey = @[@""];//与公共配置 filtrationCacheKey 兼容
 //            request.requestSerializer = ZBJSONRequestSerializer; //单次请求设置 请求格式 默认JSON，优先级大于 公共配置，不影响其他请求设置
 //            request.responseSerializer = ZBJSONResponseSerializer; //单次请求设置 响应格式 默认JSON，优先级大于 公共配置,不影响其他请求设置
            
 /// 多次请求同一个接口 保留第一次或最后一次请求结果 只在请求时有用  读取缓存无效果。默认ZBResponseKeepNone 什么都不做。使用场景是在 重复点击造成的 多次请求，如发帖，评论，搜索等业务
 //            request.keepType=ZBResponseKeepNone;
         }//一些临时的其他的配置
         
     }progress:^(NSProgress * _Nullable progress){
         NSLog(@"进度 = %f",progress.fractionCompleted * 100);
     }success:^(id  _Nullable responseObject,
                ZBURLRequest * _Nullable request){
         if (successBlock) {
             successBlock(responseObject);
         }
     }failure:^(NSError * _Nullable error){
         NSLog(@"error = %@",error);
     }finished:^(id  _Nullable responseObject,
                 NSError * _Nullable error,
                 ZBURLRequest * _Nullable request){
         NSLog(@"请求完成 userInfo:%@",request.userInfo);
     }];
 }
 
 **/

/**
示例代码：【特殊的网络请求：可以body里面携带参数，也可以自定义header，并且表单模式post传输data数据】
/// 帖子图片上传 POST
-(void)networking_postUploadImagePOST{
 NSLog(@"当前是否有网：%d 状态：%ld",[ZBRequestManager isNetworkReachable],(long)[ZBRequestManager networkReachability]);
 [DataManager sharedInstance].tag = [ReuseIdentifier stringByAppendingString:NSStringFromSelector(_cmd)];

 [RequestTool initConfig];//公共配置、插件机制、证书设置
 @weakify(self)
 NSDictionary *parameters = @{};
 [DDNetworkingAPI requestApi:NSObject.postUploadImagePOST.funcName
        uploadImagesParamArr:@[parameters,
                               self.photosImageMutArr]
                successBlock:^(id data) {
     @strongify(self)
     NSLog(@"data = %@",data);
 }
                failureBlock:^(id data) {
     @strongify(self)
     NSLog(@"data = %@",data);
 }];
}
 
+(void)postUploadImagePOST:(id)parameters
       uploadImageDatas:(NSMutableArray<UIImage *> *)uploadImageDatas
           successBlock:(MKDataBlock)successBlock
           failureBlock:(MKDataBlock)failureBlock{
 
 NSMutableArray *uploadDatas = NSMutableArray.array;
 for (int i = 0; i < uploadImageDatas.count; i++) {
     UIImage *image = uploadImageDatas[i];
     NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
     NSInteger time = NSDate.date.timeIntervalSince1970 * 1000;
     NSString *fileName = [NSString stringWithFormat:@"%ld_%u.jpeg",time,arc4random() / 1000];
     ZBUploadData *zbdata = [ZBUploadData formDataWithName:@"file"
                                                  fileName:fileName
                                                  mimeType:@"image/jpeg"
                                                  fileData:imageData];
     [uploadDatas addObject:zbdata];
 }
 [ZBRequestManager requestWithConfig:^(ZBURLRequest * request) {
     request.server = NSObject.BaseUrl;
     request.url = [request.server stringByAppendingString:NSObject.postUploadImagePOST.url];
     NSLog(@"request.URLString = %@",request.url);
     request.methodType = ZBMethodTypeUpload;
     request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
//        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置Headers 兼容
     request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
     request.timeoutInterval = 120;//默认30 //优先级 高于 公共配置,不影响其他请求设置
     request.requestSerializer = ZBHTTPRequestSerializer;
     request.uploadDatas = uploadDatas;
     if (![NSString isNullString:[DataManager sharedInstance].tag]) {
         request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
     };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
 } progress:^(NSProgress * _Nullable progress) {
     NSLog(@"onProgress: %.2f", 100.f * progress.completedUnitCount/progress.totalUnitCount);
 } success:^(id  responseObject,ZBURLRequest * request) {
     NSLog(@"responseObject: %@", responseObject);
     if (successBlock) {
         successBlock(responseObject);
     }
 } failure:^(NSError * _Nullable error) {
     NSLog(@"error: %@", error);
     if (failureBlock) {
         failureBlock(error);
     }
 }];
}
 
 **/

/**
示例代码：【特殊的网络请求：可以body里面携带参数，也可以自定义header，并且表单模式post传输data数据】
/// 帖子视频上传 POST
-(void)networking_postuploadVideoPOST{
 NSLog(@"当前是否有网：%d 状态：%ld",[ZBRequestManager isNetworkReachable],(long)[ZBRequestManager networkReachability]);
 [DataManager sharedInstance].tag = [ReuseIdentifier stringByAppendingString:NSStringFromSelector(_cmd)];

 [RequestTool initConfig];//公共配置、插件机制、证书设置
 @weakify(self)
 NSDictionary *parameters = @{};
 [DDNetworkingAPI requestApi:NSObject.postuploadVideoPOST.funcName
        uploadVideosParamArr:@[parameters,
                               self.videosData]
                successBlock:^(id data) {
     @strongify(self)
     NSLog(@"data = %@",data);
 }
                failureBlock:^(id data) {
     @strongify(self)
     NSLog(@"data = %@",data);
 }];
}

+(void)postuploadVideoPOST:(id)parameters
            uploadVideo:(NSData *)videoData
           successBlock:(MKDataBlock)successBlock
           failureBlock:(MKDataBlock)failureBlock{
 
 NSInteger time = NSDate.date.timeIntervalSince1970 * 1000;
 NSString *fileName = [NSString stringWithFormat:@"%ld_%u.mp4", time, arc4random() / 1000];

 ZBUploadData *zbdata = [ZBUploadData formDataWithName:@"file"
                                              fileName:fileName
                                              mimeType:@"video/mp4"
                                              fileData:videoData];
 
//    ZBUploadData *zbdata = [ZBUploadData formDataWithName:@"file"
//                                                 fileName:fileName
//                                                 mimeType:@"video/mp4"
//                                                  fileURL:videoURL];
 
 NSMutableArray *uploadDatas = [NSMutableArray arrayWithObject:zbdata];
 
 [ZBRequestManager requestWithConfig:^(ZBURLRequest * request) {
     request.server = NSObject.BaseUrl;
     request.url = [request.server stringByAppendingString:NSObject.postuploadVideoPOST.url];
     NSLog(@"request.URLString = %@",request.url);
     request.methodType = ZBMethodTypeUpload;
     request.apiType = ZBRequestTypeRefresh;//（默认为ZBRequestTypeRefresh 不读取缓存，不存储缓存）
//        request.parameters = parameters;//与公共配置 Parameters 兼容
//        request.headers = headers;//与公共配置Headers 兼容
     request.retryCount = 1;//请求失败 单次请求 重新连接次数 优先级大于 全局设置，不影响其他请求设置
     request.timeoutInterval = 120;//默认30 //优先级 高于 公共配置,不影响其他请求设置
     request.requestSerializer = ZBHTTPRequestSerializer;
     request.uploadDatas = uploadDatas;
     if (![NSString isNullString:[DataManager sharedInstance].tag]) {
         request.userInfo = @{@"info":[DataManager sharedInstance].tag};//与公共配置 UserInfo 不兼容 优先级大于 公共配置
     };//与公共配置 UserInfo 不兼容 优先级大于 公共配置
 } progress:^(NSProgress * _Nullable progress) {
     NSLog(@"onProgress: %.2f", 100.f * progress.completedUnitCount/progress.totalUnitCount);
 } success:^(id  responseObject,ZBURLRequest * request) {
     NSLog(@"responseObject: %@", responseObject);
     if (successBlock) {
         successBlock(responseObject);
     }
 } failure:^(NSError * _Nullable error) {
     NSLog(@"error: %@", error);
     if (failureBlock) {
         failureBlock(error);
     }
 }];
}
 **/

