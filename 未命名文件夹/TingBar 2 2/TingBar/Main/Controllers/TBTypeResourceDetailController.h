//
//  TBTypeResourceDetailController.h
//  TingBar
//
//  Created by lanouhn on 15/8/27.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeResourceModel.h"
@interface TBTypeResourceDetailController : UIViewController
@property (nonatomic, strong)TypeResourceModel *Typemodel;
@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *name;
@end
