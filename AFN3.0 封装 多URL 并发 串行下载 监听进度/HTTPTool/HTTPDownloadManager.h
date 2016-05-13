//
//  HTTPDownloadManager.h
//  AFN3.0请求工具类
//
//  Created by 邓泽淼 on 16/5/12.
//  Copyright © 2016年 DZM. All rights reserved.
//

#import "HTTPAction.h"
#import <Foundation/Foundation.h>

// 下载 进度回调  进度计算方式：1.0 * progress.completedUnitCount / progress.totalUnitCount
typedef void (^HTTPProgress)(NSProgress *progress, NSString *identity);

#pragma mark - 下载文件 回调
// 下载成功回调
typedef void (^HTTPDownLoadSuccess)(NSURLResponse * response , NSURL *filePath , NSString *identity);
// 下载失败回调
typedef void (^HTTPDownLoadFailure)(NSURLResponse * response , NSError *error , NSString *identity);

@interface HTTPDownloadManager : NSObject
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
         failure:(DownLoadFailure)failure;

/**
 *  下载文件 可以设置 identity
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
         failure:(HTTPDownLoadFailure)failure;

/**
 *  下载文件 多个url 进行下载 记得 返回的 HTTPDownloadManager 有强引用
 *  该方法返回了 HTTPDownloadManager 对象 identity 属性可选是否传递
 *  @param urls                     文件url数组
 *  @param filePath                 文件路径
 *  @param identity                 标示（当多个下载的时候 ["http1","http2"] 或者 [["http1","http2"]] 这样下载的时候 可以使用） identity 进行标示下载的是哪个数组中的图片URL
 *  @param currentProgress          进度监听
 *  @param failureContinue          过程中有失败是否下载依然继续 default:NO
 *  @param success
 *  @param failure
 */
+ (HTTPDownloadManager *)DownloadSerial:(NSArray *)urls
                       filePath:(NSString *)filePath
                      identity:(NSString *)identity
                    failureContinue:(BOOL)failureContinue
                       progress:(HTTPProgress)progress
                        success:(HTTPDownLoadSuccess)success
                        failure:(HTTPDownLoadFailure)failure;
@end
