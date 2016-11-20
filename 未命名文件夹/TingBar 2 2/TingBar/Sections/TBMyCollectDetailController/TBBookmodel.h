//
//  TBBookmodel.h
//  TingBar
//
//  Created by lanouhn on 15/9/1.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBBookmodel : NSObject
@property (nonatomic,assign)int ID;
@property (nonatomic, copy)NSString *announcer;
@property (nonatomic, copy)NSString *bookName;
@property (nonatomic, copy)NSString *ids;
- (instancetype)initWithAnnouncer:(NSString *)announcer   bookName:(NSString *)bookName ids:(NSString *)ids;
- (instancetype)initWithAnnouncer:(NSString *)announcer  bookName:(NSString *)bookName  ids:(NSString *)ids modelID:(int)ID;

@end
