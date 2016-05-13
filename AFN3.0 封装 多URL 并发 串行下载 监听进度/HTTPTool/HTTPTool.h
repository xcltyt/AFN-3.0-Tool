//
//  HTTPTool.h
//
//  Created by 邓泽淼 on 16/5/11.
//  Copyright © 2016年 DZM. All rights reserved.
//

/**
 整个请求的BaseUrl
 例如： @"http://192.168.0.1/image" 这样的请求 可以在 HTTPTool_BaseUrl 中固定 @"http://192.168.0.1/"
 然后在外部使用的使用则可以直接传 HTTPTool_BaseUrl(@"image") 即可
 */
#define HTTPTool_BaseUrl(url) [NSString stringWithFormat:@"%@",(url)]

#import "AFNetworking.h"
#import <Foundation/Foundation.h>

#pragma mark - 上传 下载 进度监听
// 上传 下载 进度回调  进度计算方式：1.0 * progress.completedUnitCount / progress.totalUnitCount
typedef void (^Progress)(NSProgress *progress);

#pragma mark - 常用回调
// 成功回调
typedef void (^Success)(id responseObject);
// 失败回调
typedef void (^Failure)(NSError *error);


#pragma mark - 附带 NSURLSessionDataTask 回调
// 成功回调
typedef void (^TaskSuccess)(NSURLSessionDataTask * task , id responseObject);
// 失败回调
typedef void (^TaskFailure)(NSURLSessionDataTask * task , NSError *error);


#pragma mark - 下载文件 回调
// 下载成功回调
typedef void (^DownLoadSuccess)(NSURLResponse * response , NSURL *filePath);
// 下载失败回调
typedef void (^DownLoadFailure)(NSURLResponse * response , NSError *error);


/**
 *  用来封装文件数据的模型
 */
@interface FormData : NSObject

// 注意：        filePath 跟 data 选一个就好了 根据需要选择, 两个都有值会默认选择上传 data 的数据, filePath数据则不上传
// filePath:    通过文件路径上传文件
// data:        通过二进制数据上传文件

/**
 *  文件名路径
 */
@property (nonatomic, copy) NSString *filePath;

/**
 *  文件数据
 */
@property (nonatomic, strong) NSData *data;

/**
 *  参数名
 */
@property (nonatomic, copy) NSString *name;

/**
 *  文件名
 */
@property (nonatomic, copy) NSString *filename;

/**
 *  文件类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end


@interface HTTPTool : NSObject


/**
 *  获取 HTTPTool 单利 使用监听网络请求
 */
+ (HTTPTool *)sharedTool;


#pragma mark - POST

/**
 *  POST 请求    常用回调
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters success:(Success)success failure:(Failure)failure;

/**
 *  POST 请求    附带 NSURLSessionDataTask 回调
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters taskSuccess:(TaskSuccess)success taskFailure:(TaskFailure)failure;

/**
 *  POST 请求    附带 NSURLSessionDataTask 回调  进度监听回调
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param progress   进度
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters progress:(Progress)progress taskSuccess:(TaskSuccess)success taskFailure:(TaskFailure)failure;


#pragma mark - GET

/**
 *  GET 请求    常用回调
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GET:(NSString *)url parameters:(id)parameters success:(Success)success failure:(Failure)failure;

/**
 *  GET 请求    附带 NSURLSessionDataTask 回调
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GET:(NSString *)url parameters:(id)parameters taskSuccess:(TaskSuccess)success taskFailure:(TaskFailure)failure;

/**
 *  GET 请求    附带 NSURLSessionDataTask 回调  进度监听回调
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param progress   进度
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GET:(NSString *)url parameters:(id)parameters progress:(Progress)progress taskSuccess:(TaskSuccess)success taskFailure:(TaskFailure)failure;


#pragma mark - POST 上传文件

/**
 *  POST 上传文件    常用回调  多文件上传和单文件上传区别在于文件名称
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param formDataArray 通过 FormData 模型 创建上传文件模型 以数组参数传入 单个文件:[formData] 多个文件:[formData1,formData2,....]
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters formDataArray:(NSArray *)formDataArray  success:(Success)success failure:(Failure)failure;

/**
 *  POST 上传文件    附带 NSURLSessionDataTask 回调  多文件上传和单文件上传区别在于文件名称
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param formDataArray 通过 FormData 模型 创建上传文件模型 以数组参数传入 单个文件:[formData] 多个文件:[formData1,formData2,....]
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters formDataArray:(NSArray *)formDataArray taskSuccess:(TaskSuccess)success taskFailure:(TaskFailure)failure;

/**
 *  POST 上传文件    附带 NSURLSessionDataTask 回调  多文件上传和单文件上传区别在于文件名称 进度监听回调
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param formDataArray 通过 FormData 模型 创建上传文件模型 以数组参数传入 单个文件:[formData] 多个文件:[formData1,formData2,....]
 *  @param progress   进度
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters formDataArray:(NSArray *)formDataArray progress:(Progress)progress taskSuccess:(TaskSuccess)success taskFailure:(TaskFailure)failure;


#pragma mark - POST 下载文件

/**
 *  下载文件
 *  NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
 *  @param url        URL
 *  @param filePath   下载路径 (如果不传 则会下载带默认下载地址) 建议自带 并拼接文件名称
 *  @param progress   进度
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (AFHTTPSessionManager *)DownLoad:(NSString *)url filePath:(NSString *)filePath progress:(Progress)progress success:(DownLoadSuccess)success failure:(DownLoadFailure)failure;


#pragma mark - 网络检查监听

/**
 *  获取当前网络状态
 */
- (void)CurrentNetworkStatus:(void (^)(BOOL isNetwork))result;
@end
