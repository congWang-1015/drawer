//
//  TBMacros.h
//  TingBar
//
//  Created by lanouhn on 15/8/26.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TBWidth [UIScreen mainScreen].bounds.size.width
#define TBHight [UIScreen mainScreen].bounds.size.height

#define XR [UIScreen mainScreen].bounds.size.width/375.0
#define YR [UIScreen mainScreen].bounds.size.height/667.0
#define XRF(width) width*XR
#define YRF(height) height*YR