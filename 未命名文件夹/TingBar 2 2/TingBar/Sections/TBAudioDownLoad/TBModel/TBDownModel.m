//
//  DownModel.m
//  Downloading
//
//  Created by lanouhn on 15/8/18.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBDownModel.h"

@implementation TBDownModel
- (void)timeStart:(float)progress{
    if (self.delegate && [self.delegate respondsToSelector:@selector(passValue:)]) {
        [self.delegate passValue:progress];
    }
}
@end
