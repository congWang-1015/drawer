//
//  DownModel.h
//  Downloading
//
//  Created by lanouhn on 15/8/18.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol downModelDelegate <NSObject>
- (void)passValue:(float)progress;
@end
@interface TBDownModel : NSObject
@property (nonatomic, assign)float progress;
@property (nonatomic, assign)id<downModelDelegate>delegate;
- (void)timeStart:(float)progress;
@end
