//
//  TBTopImgModel.m
//  TingBar
//
//  Created by lanouhn on 15/8/25.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBTopImgModel.h"

@implementation TBTopImgModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.desc = [dic objectForKey:@"desc"];
        self.ID = [dic objectForKey:@"id"];
        self.name = [dic objectForKey:@"name"];
    }
    return self;
}
@end
