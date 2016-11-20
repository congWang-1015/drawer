//
//  TypeResourceModel.m
//  TingBar
//
//  Created by lanouhn on 15/8/26.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TypeResourceModel.h"

@implementation TypeResourceModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.name = dic[@"name"];
        self.ID   = dic[@"id"];
    }return self;
 }
@end
