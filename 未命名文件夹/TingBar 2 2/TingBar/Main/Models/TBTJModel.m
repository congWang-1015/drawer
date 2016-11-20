//
//  TBTJModel.m
//  TingBar
//
//  Created by lanouhn on 15/8/28.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBTJModel.h"
#import "TBBookDetailModel.h"
@implementation TBTJModel
- (id)initWithDic:(NSDictionary *)dic{
    if (self = [self init]) {
        self.bookList = dic[@"bookList"];
        self.topicName = dic[@"topicName"];
        if ([dic[@"bookList"] isKindOfClass:[NSArray class]]) {
            NSArray *bookArr = dic[@"bookList"];
            for (NSDictionary *bookDic in bookArr) {
                TBBookDetailModel *model = [[TBBookDetailModel alloc] initWithDic:bookDic];
                [self.dataSource addObject:model];
             }
}
      }
    return self;
    
}
-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    }return _dataSource;
    
    
}
@end
