//
//  TBGetMainData.h
//  TingBar
//
//  Created by lanouhn on 15/8/25.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "NetWorkEngine.h"
#import "AFNetworking.h"

@implementation NetWorkEngine
//  单例方法
+ (NetWorkEngine *)shareNetWorkEngine
{
    static NetWorkEngine *netWorkEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkEngine = [[NetWorkEngine alloc] init];
    });
    return netWorkEngine;
}

- (void)GetRequestNetInfoWithURLStrViaNet:(NSString *)urlStr sucess:(void (^)(id))sucess failur:(void (^)(id))failur
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //  调用sucess block
        sucess(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //  调用error block
        failur(error);
    }];
}
//  没有网络时，调用该方法，注意该方法中，所用的get方法是自己添加的，在AFHTTPRequestOperationManager类中，添加的方法，读取缓存
- (void)GetRequestNetInfoWithURLStrViaNoNet:(NSString *)urlStr sucess:(void (^)(id))sucess failur:(void (^)(id))failur
{
    NSString * string = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    [manager GET:string parameters:nil timeoutInterval:-1 cachePolicy:NSURLRequestUseProtocolCachePolicy success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        sucess(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failur(error);
            }];
}

@end
