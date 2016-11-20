//
//  TBBookmodel.m
//  TingBar
//
//  Created by lanouhn on 15/9/1.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBBookmodel.h"

@implementation TBBookmodel
- (instancetype)initWithAnnouncer:(NSString *)announcer bookName:(NSString *)bookName ids:(NSString *)ids{
    if (self = [super init]) {
        _announcer = announcer;
        _bookName = bookName;
        _ids = ids;
        
    }
    return self;
}

- (instancetype)initWithAnnouncer:(NSString *)announcer bookName:(NSString *)bookName ids:(NSString *)ids modelID:(int)modelID{
    if (self = [super init]) {
        _announcer = announcer;
        _bookName = bookName;
        _ids = ids;
        _ID = modelID;
    }
    return self;
}





@end
