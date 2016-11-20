//
//  TBTopImgModel.h
//  TingBar
//
//  Created by lanouhn on 15/8/25.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBTopImgModel : NSObject
@property (nonatomic, copy)NSString *desc;
@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *name;


- (id)initWithDic:(NSDictionary *)dic;



@end
