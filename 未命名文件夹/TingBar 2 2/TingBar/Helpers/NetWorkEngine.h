//
//  TBGetMainData.h
//  TingBar
//
//  Created by lanouhn on 15/8/25.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NetWorkEngine : NSObject

//  单例方法
+ (NetWorkEngine *)shareNetWorkEngine;

//  有网络时的请求方法
- (void)GetRequestNetInfoWithURLStrViaNet:(NSString *)urlStr sucess:(void (^)(id)) sucess failur:(void (^)(id)) failur;
//  没有网络时调用的方法，此时读取缓存的数据
- (void)GetRequestNetInfoWithURLStrViaNoNet:(NSString *)urlStr sucess:(void (^)(id)) sucess failur:(void (^)(id)) failur;

@end
