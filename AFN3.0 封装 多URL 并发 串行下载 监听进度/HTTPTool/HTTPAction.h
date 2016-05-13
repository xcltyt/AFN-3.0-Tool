//
//  HTTPAction.h
//  AFN3.0请求工具类
//
//  Created by 邓泽淼 on 16/5/11.
//  Copyright © 2016年 DZM. All rights reserved.
//

#import "HTTPTool.h"
#import <Foundation/Foundation.h>

@interface HTTPAction : NSObject

#pragma mark - POST

/**
 *  POST 请求 可以设置 successAction
 *
 *  @param url           URL
 *  @param parameters    参数
 *  @param target        监听对象
 *  @param successAction 成功回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters target:(id)target successAction:(SEL)successAction;

/**
 *  POST 请求 可以设置 successAction failureAction
 *
 *  @param url           URL
 *  @param parameters    参数
 *  @param target        监听对象
 *  @param successAction 成功回调
 *  @param failureAction 失败回调
 */
+ (void)POST:(NSString *)url parameters:(id)parameters target:(id)target successAction:(SEL)successAction failureAction:(SEL)failureAction;


#pragma mark - GET

/**
 *  GET 请求 可以设置 successAction
 *
 *  @param url           URL
 *  @param parameters    参数
 *  @param target        监听对象
 *  @param successAction 成功回调
 */
+ (void)GET:(NSString *)url parameters:(id)parameters target:(id)target successAction:(SEL)successAction;

/**
 *  GET 请求 可以设置 successAction failureAction
 *
 *  @param url           URL
 *  @param parameters    参数
 *  @param target        监听对象
 *  @param successAction 成功回调
 *  @param failureAction 失败回调
 */
+ (void)GET:(NSString *)url parameters:(id)parameters target:(id)target successAction:(SEL)successAction failureAction:(SEL)failureAction;


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
+ (void)POST:(NSString *)url parameters:(id)parameters formDataArray:(NSArray *)formDataArray target:(id)target successAction:(SEL)successAction;

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
+ (void)POST:(NSString *)url parameters:(id)parameters formDataArray:(NSArray *)formDataArray target:(id)target successAction:(SEL)successAction failureAction:(SEL)failureAction;
@end
