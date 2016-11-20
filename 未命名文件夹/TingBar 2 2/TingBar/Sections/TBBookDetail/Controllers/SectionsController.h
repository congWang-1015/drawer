//
//  SectionsController.h
//  TingBar
//
//  Created by lanouhn on 15/8/30.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionsDelegate <NSObject>

- (void)method;

- (void)downWin;

@end
@interface SectionsController : UITableViewController
@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *sections;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *cover;
@property (assign,nonatomic)id<SectionsDelegate> delegate;
@end
