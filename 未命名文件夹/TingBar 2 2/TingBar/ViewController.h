//
//  ViewController.h
//  TingBar
//
//  Created by lanouhn on 15/8/24.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, strong)UIScrollView *BigViewScrollView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)NSMutableArray *typelistData;
@property (nonatomic, strong) UIButton *myBt;
@property (nonatomic, retain)UIView *upView;
@property (nonatomic, strong)UITapGestureRecognizer *tapg;
@end

