//
//  HTTPAction.m
//  AFN3.0请求工具类
//
//  Created by 邓泽淼 on 16/5/11.
//  Copyright © 2016年 DZM. All rights reserved.
//

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#import "HTTPAction.h"

@interface HTTPAction()

@end

@implementation HTTPAction

/**
 *  POST 请求
 *
 *  @param url           URL
 *  @param parameters    参数
 *  @param target        监听对象
 *  @param successAction 成功回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters target:(id)target successAction:(SEL)successAction
{
    [HTTPAction POST:url parameters:parameters target:target successAction:successAction failureAction:nil];
}

/**
 *  POST 请求
 *
 *  @param url           URL
 *  @param parameters    参数
 *  @param target        监听对象
 *  @param successAction 成功回调
 *  @param failureAction 失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters target:(id)target successAction:(SEL)successAction failureAction:(SEL)failureAction
{
    [HTTPTool POST:url parameters:parameters taskSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        [HTTPAction target:target action:successAction object:responseObject];
    } taskFailure:^(NSURLSessionDataTask *task, NSError *error) {
        [HTTPAction target:target action:failureAction object:error];
    }];
}


#pragma mark - GET

/**
 *  GET 请求
 *
 *  @param url           URL
 *  @param parameters    参数
 *  @param target        监听对象
 *  @param successAction 成功回调
 */
+ (void)GET:(NSString *)url parameters:(id)parameters target:(id)target successAction:(SEL)successAction
{
    [HTTPAction GET:url parameters:parameters target:target successAction:successAction failureAction:nil];
}

/**
 *  GET 请求
 *
 *  @param url           URL
 *  @param parameters    参数
 *  @param target        监听对象
 *  @param successAction 成功回调
 *  @param failureAction 失败回调
 */
+ (void)GET:(NSString *)url parameters:(id)parameters target:(id)target successAction:(SEL)successAction failureAction:(SEL)failureAction
{
    [HTTPTool GET:url parameters:parameters taskSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        [HTTPAction target:target action:successAction object:responseObject];
    } taskFailure:^(NSURLSessionDataTask *task, NSError *error) {
        [HTTPAction target:target action:failureAction object:error];
    }];
}


#pragma mark - POST 上传文件

/**
 *  POST 上传文件 多文件上传和单文件上传区别在于文件名称 可以设置 successAction
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param formDataArray 通过 FormData 模型 创建上传文件模型 以数组参数传入 单个文件:[formData] 多个文件:[formData1,formData2,....]
 *  @param target        监听对象
 *  @param successAction 成功回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters formDataArray:(NSArray *)formDataArray target:(id)target successAction:(SEL)successAction
{
    [HTTPAction POST:url parameters:parameters formDataArray:formDataArray target:target successAction:successAction failureAction:nil];
}

/**
 *  POST 上传文件 多文件上传和单文件上传区别在于文件名称 可以设置 successAction failureAction
 *
 *  @param url        URL
 *  @param parameters 参数
 *  @param formDataArray 通过 FormData 模型 创建上传文件模型 以数组参数传入 单个文件:[formData] 多个文件:[formData1,formData2,....]
 *  @param target        监听对象
 *  @param successAction 成功回调
 *  @param failureAction 失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters formDataArray:(NSArray *)formDataArray target:(id)target successAction:(SEL)successAction failureAction:(SEL)failureAction
{
    [HTTPTool POST:url parameters:parameters formDataArray:formDataArray taskSuccess:^(NSURLSessionDataTask *task, id responseObject) {
        [HTTPAction target:target action:successAction object:responseObject];
    } taskFailure:^(NSURLSessionDataTask *task, NSError *error) {
        [HTTPAction target:target action:failureAction object:error];
    }];
}


#pragma mark - 辅助回调

/**
 *  通过 target 调用 action
 */
+ (void)target:(id)target action:(SEL)action object:(id)object
{
    if (target && [target respondsToSelector:action]) {
        [target performSelector:action withObject:object afterDelay:0.0];
    }
}

@end
