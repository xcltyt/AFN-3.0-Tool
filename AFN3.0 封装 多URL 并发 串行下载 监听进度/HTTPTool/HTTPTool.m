//
//  HTTPTool.m
//
//  Created by 邓泽淼 on 16/5/11.
//  Copyright © 2016年 DZM. All rights reserved.
//

#import "HTTPTool.h"

@implementation HTTPTool

/**
 *  获取 HTTPTool 单利 使用监听网络请求
 */
+ (HTTPTool *)sharedTool {
    
    static HTTPTool *tool = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        tool = [[HTTPTool alloc] init];
        
    });
    
    return tool;
}

#pragma mark - POST

/**
 *  POST 请求    常用回调
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters success:(Success)success failure:(Failure)failure
{
    [HTTPTool POST:url parameters:parameters taskSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (success) {success(responseObject);}
        
    } taskFailure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {failure(error);}
    }];
}

/**
 *  POST 请求    附带 NSURLSessionDataTask 回调
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters taskSuccess:(TaskSuccess)success taskFailure:(TaskFailure)failure
{
    [HTTPTool POST:url parameters:parameters progress:nil taskSuccess:success taskFailure:failure];
}

/**
 *  POST 请求    附带 NSURLSessionDataTask 回调  进度监听回调
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param progress   进度
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters progress:(Progress)progress taskSuccess:(TaskSuccess)success taskFailure:(TaskFailure)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {progress(uploadProgress);}
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {success(task,responseObject);}
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {failure(task,error);}
    }];
}


#pragma mark - GET

/**
 *  GET 请求    常用回调
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GET:(NSString *)url parameters:(id)parameters success:(Success)success failure:(Failure)failure
{
    [HTTPTool GET:url parameters:parameters taskSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (success) {success(responseObject);}
        
    } taskFailure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {failure(error);}
    }];
}

/**
 *  GET 请求    附带 NSURLSessionDataTask 回调
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GET:(NSString *)url parameters:(id)parameters taskSuccess:(TaskSuccess)success taskFailure:(TaskFailure)failure
{
    [HTTPTool GET:url parameters:parameters progress:nil taskSuccess:success taskFailure:failure];
}

/**
 *  GET 请求    附带 NSURLSessionDataTask 回调  进度监听回调
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param progress   进度
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)GET:(NSString *)url parameters:(id)parameters progress:(Progress)progress taskSuccess:(TaskSuccess)success taskFailure:(TaskFailure)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {progress(downloadProgress);}
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {success(task,responseObject);}
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {failure(task,error);}
    }];
}


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
+ (void)POST:(NSString *)url parameters:(id)parameters formDataArray:(NSArray *)formDataArray  success:(Success)success failure:(Failure)failure
{
    [HTTPTool POST:url parameters:parameters formDataArray:formDataArray taskSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (success) {success(responseObject);}
        
    } taskFailure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {failure(error);}
    }];
}

/**
 *  POST 上传文件    附带 NSURLSessionDataTask 回调  多文件上传和单文件上传区别在于文件名称
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param formDataArray 通过 FormData 模型 创建上传文件模型 以数组参数传入 单个文件:[formData] 多个文件:[formData1,formData2,....]
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters formDataArray:(NSArray *)formDataArray taskSuccess:(TaskSuccess)success taskFailure:(TaskFailure)failure
{
    [HTTPTool POST:url parameters:parameters formDataArray:formDataArray progress:nil taskSuccess:success taskFailure:failure];
}

/**
 *  POST 上传文件    附带 NSURLSessionDataTask 回调  多文件上传和单文件上传区别在于文件名称
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param formDataArray 通过 FormData 模型 创建上传文件模型 以数组参数传入 单个文件:[formData] 多个文件:[formData1,formData2,....]
 *  @param progress   进度
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters formDataArray:(NSArray *)formDataArray progress:(Progress)progress taskSuccess:(TaskSuccess)success taskFailure:(TaskFailure)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (FormData *data in formDataArray) {
            
            if (data.data) {
                
                [formData appendPartWithFileData:data.data name:data.name fileName:data.filename mimeType:data.mimeType];
                
            }else{
                
                 [formData appendPartWithFileURL:[NSURL fileURLWithPath:data.filePath] name:data.name fileName:data.filename mimeType:data.mimeType error:nil];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {progress(uploadProgress);}
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {success(task,responseObject);}
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {failure(task,error);}
    }];
}

#pragma mark - POST 下载文件

/**
 *  下载文件
 *  NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
 *  @param url        URL
 *  @param filePath   下载路径
 *  @param progress   进度
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (AFHTTPSessionManager *)DownLoad:(NSString *)url filePath:(NSString *)filePath progress:(Progress)progress success:(DownLoadSuccess)success failure:(DownLoadFailure)failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    // 下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        // 打印下下载进度
//        NSLog(@"进度:%lf  完成进度：%lld  总进度：%lld",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount,downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        
        if (progress) {progress(downloadProgress);}
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        // 下载地址   targetPath 为默认下载地址
        
        if (!filePath){return targetPath;}
        
        return [NSURL fileURLWithPath:filePath];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        // 下载完成调用的方法
        if (error) {
            if (failure) {failure(response,error);}
        }else{
            if (success) {success(response,filePath);}
        }
        
    }];
    
    //开始启动任务
    [task resume];
    
    return manager;
}


#pragma mark - 网络检查监听

/**
 *  获取当前网络状态
 */
- (void)CurrentNetworkStatus:(void (^)(BOOL isNetwork))result
{
    // 创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        BOOL isReachable = NO;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                isReachable = YES;
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                isReachable = NO;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                isReachable = YES;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                isReachable = YES;
                break;
                
            default:
                break;
        }
        
        if (result) {result(isReachable);}
    }] ;
}

@end
