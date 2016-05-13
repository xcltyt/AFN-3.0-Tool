//
//  HTTPDownloadManager.m
//  AFN3.0请求工具类
//
//  Created by 邓泽淼 on 16/5/12.
//  Copyright © 2016年 DZM. All rights reserved.
//

#import "HTTPDownloadManager.h"

@interface HTTPDownloadManager()

/**
 *  当前下载第几个url
 */
@property (nonatomic,assign) int currentNumber;

/**
 *  当前成功下载几个url
 */
@property (nonatomic,assign) int currentSuccessNumber;

/**
 *  urls
 */
@property (nonatomic,strong) NSArray *urls;

/**
 *  identity
 */
@property (nonatomic,copy) NSString *identity;

/**
 *  文件夹路径
 */
@property (nonatomic,copy) NSString *filePath;

/**
 *  过程中有失败是否下载依然继续 defaut: NO
 */
@property (nonatomic,assign) BOOL failureContinue;

/**
 *  回调记录
 */
@property (nonatomic,copy) HTTPProgress currentProgress;
@property (nonatomic,copy) HTTPDownLoadSuccess success;
@property (nonatomic,copy) HTTPDownLoadFailure failure;

@end

@implementation HTTPDownloadManager

/**
 *  下载文件
 *
 *  @param url
 *  @param filePath
 *  @param fileName
 *  @param currentProgress
 *  @param success
 *  @param failure
 */
+ (void)Download:(NSString *)url
        filePath:(NSString *)filePath
        fileName:(NSString *)fileName
        progress:(Progress)progress
        success:(DownLoadSuccess)success
        failure:(DownLoadFailure)failure
{
    if ([HTTPDownloadManager creatFilePath:filePath]) { // 文件夹存在
        
        filePath = [filePath stringByAppendingPathComponent:fileName];
        
        [HTTPTool DownLoad:url filePath:filePath progress:progress success:success failure:failure];
    }else { // 文件夹不存在
        
        NSError *error = [self creatErrorWithUrl:url];
        if (failure) {failure(nil,error);}
    }
}

/**
 *  下载文件 可以设置ID
 *
 *  @param url
 *  @param filePath
 *  @param fileName
 *  @param identity   标示（当多个下载的时候 ["http1","http2"] 或者 [["http1","http2"]] 这样下载的时候 可以使用） identity 进行标示下载的是哪个数组中的图片URL
 *  @param currentProgress
 *  @param success
 *  @param failure
 */
+ (void)Download:(NSString *)url
        filePath:(NSString *)filePath
        fileName:(NSString *)fileName
        identity:(NSString *)identity
        progress:(HTTPProgress)currentProgress
         success:(HTTPDownLoadSuccess)success
         failure:(HTTPDownLoadFailure)failure
{
    [HTTPDownloadManager Download:url filePath:filePath fileName:fileName progress:^(NSProgress *progress) {
        if (currentProgress) {currentProgress(progress,identity);}
    } success:^(NSURLResponse *response, NSURL *filePath) {
        if (success) {success(response,filePath,identity);}
    } failure:^(NSURLResponse *response, NSError *error) {
        if (failure) {failure(response,error,identity);}
    }];
    
}


/**
 *  下载文件 多个url 进行下载 记得 返回的 HTTPDownloadManager 有强引用
 *  该方法返回了 HTTPDownloadManager 对象 identity 属性可选是否传递
 *  @param url
 *  @param filePath
 *  @param identity 标示（当多个下载的时候 ["http1","http2"] 或者 [["http1","http2"]] 这样下载的时候 可以使用） identity 进行标示下载的是哪个数组中的图片URL
 *  @param currentProgress
 *  @param failureContinue          过程中有失败是否下载依然继续
 *  @param success
 *  @param failure
 */
+ (HTTPDownloadManager *)DownloadSerial:(NSArray *)urls
                         filePath:(NSString *)filePath
                         identity:(NSString *)identity
                        failureContinue:(BOOL)failureContinue
                         progress:(HTTPProgress)progress
                          success:(HTTPDownLoadSuccess)success
                          failure:(HTTPDownLoadFailure)failure
{
    if (urls.count <= 0) {return nil;}
    
    HTTPDownloadManager *manager = [[HTTPDownloadManager alloc] init];
    manager.currentNumber = 0;
    manager.currentSuccessNumber = 0;
    manager.urls = urls;
    manager.filePath = filePath;
    manager.identity = identity;
    manager.currentProgress = progress;
    manager.success = success;
    manager.failure = failure;
    manager.failureContinue = NO;
    if (failureContinue) {manager.failureContinue = failureContinue;}
    
    [manager startDownload];
    
    return manager;
}

/**
 *  开始下载
 */
- (void)startDownload
{
    NSString *url = self.urls[self.currentNumber];
    [self DownloadSerial:url filePath:self.filePath fileName:[url stringByDeletingPathExtension] progress:self.currentProgress success:self.success failure:self.failure];
  
}

/**
 *  下载单个url 串行下载
 */
- (void)DownloadSerial:(NSString *)url
        filePath:(NSString *)filePath
        fileName:(NSString *)fileName
        progress:(HTTPProgress)currentProgress
         success:(HTTPDownLoadSuccess)success
         failure:(HTTPDownLoadFailure)failure
{
    __weak HTTPDownloadManager *weakSelf = self;
    
    [HTTPDownloadManager Download:url filePath:filePath fileName:fileName progress:nil success:^(NSURLResponse *response, NSURL *filePath) {
        
        // 下载成功
        weakSelf.currentSuccessNumber += 1;
        
        if (weakSelf.currentNumber < weakSelf.urls.count) { // 还有url 需要下载
            
            // 回调进度
            if (currentProgress) {currentProgress([weakSelf progress],weakSelf.identity);}
            
            [weakSelf startDownload];
            
        }else{
            
            // 回调进度
            if (currentProgress) {currentProgress([weakSelf progress],weakSelf.identity);}
            
            // 回调成功
            if (success) {success(response,filePath,weakSelf.identity);}
        }
        
    } failure:^(NSURLResponse *response, NSError *error) {
        
        if (weakSelf.failureContinue) { // 失败继续
            
            // 回调进度
            if (currentProgress) {currentProgress([weakSelf progress],weakSelf.identity);}
            
            [weakSelf startDownload];
            
        }else{ // 失败不继续
            
            if (failure) {failure(response,error,weakSelf.identity);}
        }
        
    }];
    
    // 下载URL进度
    self.currentNumber += 1;
}

/**
 *  获取 progress
 *
 *  @return progress
 */
- (NSProgress *)progress
{
    NSProgress *progress = [[NSProgress alloc] init];
    
    progress.completedUnitCount = self.currentSuccessNumber;
    
    progress.totalUnitCount = self.urls.count;
    
    return progress;
}

/**
 *  创建一个提示错误
 *
 *  @param url 下载错误的url
 *
 *  @return NSError
 */
+ (NSError *)creatErrorWithUrl:(NSString *)url
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"HTTPDownloadManager.m 在下载文件URL:%@ 存储文件夹创建失败或者文件夹不存在取消当前下载",url]                                                                      forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:@"HTTPDownloadManager.m 下载错误" code:-1 userInfo:userInfo];
    
    return error;
}

/**
 *  创建文件夹  如果存在则不创建
 *
 *  @param filePath 文件夹路径
 *
 *  @return 文件是否存在
 */
+ (BOOL)creatFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 文件夹存在
    if ([fileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    
    BOOL isOK = [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    
//    NSAssert(isOK,@"创建目录失败");
    
    return isOK;
}

@end
