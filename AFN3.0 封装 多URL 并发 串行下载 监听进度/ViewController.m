//
//  ViewController.m
//  AFN3.0 封装 多URL 并发 串行下载 监听进度
//
//  Created by 邓泽淼 on 16/5/13.
//  Copyright © 2016年 DZM. All rights reserved.
//

#import "ViewController.h"
#import "HTTP.h"
@interface ViewController ()


@property (nonatomic,strong) HTTPDownloadManager *manager;

@property (nonatomic,strong) HTTPDownloadManager *manager1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)download:(id)sender {
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"33333"];
    
    // 成功下载 测试成功
//    NSArray *urls = @[@"http://pic32.nipic.com/20130829/12906030_124355855000_2.png",
//                      @"http://pic32.nipic.com/20130829/12906030_124355855000_2.png",
//                      @"http://pic32.nipic.com/20130829/12906030_124355855000_2.png",
//                      @"http://pic32.nipic.com/20130829/12906030_124355855000_2.png",
//                      @"http://pic32.nipic.com/20130829/12906030_124355855000_2.png",];
    
    // 成功下载 第三张失败下载 测试失败
    NSArray *urls = @[@"http://pic32.nipic.com/20130829/12906030_124355855000_2.png",
                      @"http://pic32.nipic.com/20130829/12906030_124355855000_2.png",
                      @"http://pic32.nipic.com/20130829/12906030_",
                      @"http://pic32.nipic.com/20130829/12906030_124355855000_2.png",
                      @"http://pic32.nipic.com/20130829/12906030_124355855000_2.png",];
    
    // failureContinue  中间有url 失败是否继续
    self.manager = [HTTPDownloadManager DownloadSerial:urls filePath:filePath identity:@"1" failureContinue:NO progress:^(NSProgress *progress, NSString *identity) {
         NSLog(@"测试1进度:%lf  完成进度：%lld  总进度：%lld",1.0 * progress.completedUnitCount / progress.totalUnitCount,progress.completedUnitCount,progress.totalUnitCount);
    } success:^(NSURLResponse *response, NSURL *filePath, NSString *identity) {
        NSLog(@"测试1成功 %@",identity);
    } failure:^(NSURLResponse *response, NSError *error, NSString *identity) {
        NSLog(@"测试1失败 %@",identity);
    }];
    
  
    // 测试多个任务同时进行
    NSString *filePath1 = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"222222"];
    
    self.manager1 = [HTTPDownloadManager DownloadSerial:urls filePath:filePath1 identity:@"2" failureContinue:NO progress:^(NSProgress *progress, NSString *identity)  {
        NSLog(@"测试2进度:%lf  完成进度：%lld  总进度：%lld",1.0 * progress.completedUnitCount / progress.totalUnitCount,progress.completedUnitCount,progress.totalUnitCount);
    } success:^(NSURLResponse *response, NSURL *filePath, NSString *identity) {
        NSLog(@"测试2成功 %@",identity);
    } failure:^(NSURLResponse *response, NSError *error, NSString *identity) {
        NSLog(@"测试2失败 %@",identity);
    }];
}

@end
