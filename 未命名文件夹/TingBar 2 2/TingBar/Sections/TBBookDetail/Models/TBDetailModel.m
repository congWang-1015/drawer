//
//  TBDetailModel.m
//  TingBar
//
//  Created by lanouhn on 15/8/28.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBDetailModel.h"

@implementation TBDetailModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.name = dic[@"name"];
        self.path = dic[@"path"];
        self.size = dic[@"size"];
        self.vid = dic[@"id"];
    }return self;
    
    
}
@end
