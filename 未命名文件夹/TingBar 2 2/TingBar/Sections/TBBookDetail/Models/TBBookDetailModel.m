//
//  TBBookDetailModel.m
//  TingBar
//
//  Created by lanouhn on 15/8/26.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBBookDetailModel.h"

@implementation TBBookDetailModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.announcer = dic[@"announcer"];
        self.author    = dic[@"author"];
        self.cover     = dic[@"cover"];
        self.desc      = dic[@"desc"];
        self.ID        = dic[@"id"];
        self.name      = dic[@"name"];
        self.type      = dic[@"type"];
        self.update    = dic[@"update"];
        self.state     = dic[@"state"];
        self.play      = dic[@"play"];
        self.sections  = dic[@"sections"];
        self.hot       = dic[@"hot"];
        self.bookName  = dic[@"bookName"];
        self.bookID    = dic[@"bookId"];
        self.nickName = dic[@"nickName"];
        self.updateTime = dic[@"updateTime"];
    }return self;
    
}





@end
