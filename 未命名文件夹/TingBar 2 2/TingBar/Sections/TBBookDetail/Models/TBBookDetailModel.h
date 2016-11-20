//
//  TBBookDetailModel.h
//  TingBar
//
//  Created by lanouhn on 15/8/26.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBBookDetailModel : NSObject
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
@property (nonatomic, copy)NSString *bookID;
@property (nonatomic, retain)NSString *nickName;
@property (nonatomic, retain)NSString *updateTime;
- (id)initWithDic:(NSDictionary *)dic;
@end
