//
//  TypeResourceModel.h
//  TingBar
//
//  Created by lanouhn on 15/8/26.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeResourceModel : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, strong)NSString *ID;
- (id)initWithDic:(NSDictionary *)dic;
@end
