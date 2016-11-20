//
//  TBTypeListModel.m
//  TingBar
//
//  Created by lanouhn on 15/8/26.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBTypeListModel.h"

@implementation TBTypeListModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.name = [dic objectForKey:@"name"];
        self.ID = dic[@"id"];
    }return self;
}
@end
