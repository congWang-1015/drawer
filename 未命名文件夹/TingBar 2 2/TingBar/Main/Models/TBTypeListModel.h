//
//  TBTypeListModel.h
//  TingBar
//
//  Created by lanouhn on 15/8/26.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBTypeListModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *ID;
- (id)initWithDic:(NSDictionary *)dic;
@end
