//
//  TBTJModel.h
//  TingBar
//
//  Created by lanouhn on 15/8/28.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBTJModel : NSObject
@property (nonatomic, copy)NSString *bookList;
@property (nonatomic, copy)NSString *topicName;
@property (nonatomic, copy)NSString *announcer;
@property (nonatomic, copy)NSString *author;
@property (nonatomic, copy)NSString *cover;
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *update;
@property (nonatomic, assign)NSNumber *state;
@property (nonatomic, copy)NSString *play;
@property (nonatomic, retain)NSNumber *hot;
@property (nonatomic, copy)NSNumber *sections;
@property (nonatomic, copy)NSString *bookName;
- (id)initWithDic:(NSDictionary *)dic;
@property (nonatomic, strong)NSMutableArray *dataSource;
@end
