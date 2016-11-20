//
//  TBDetailModel.h
//  TingBar
//
//  Created by lanouhn on 15/8/28.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBDetailModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *path;
@property (nonatomic, strong)NSNumber *size;
@property (nonatomic, copy)NSString *vid;
- (id)initWithDic:(NSDictionary *)dic;
@end
