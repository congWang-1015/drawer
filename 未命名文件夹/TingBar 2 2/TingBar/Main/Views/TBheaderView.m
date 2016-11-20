
//
//  TBheaderView.m
//  TingBar
//
//  Created by lanouhn on 15/8/28.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBheaderView.h"

@implementation TBheaderView
//初始化方法
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.headLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width, self.frame.size.height)];
        _headLabel.font = [UIFont boldSystemFontOfSize:18];
        _headLabel.shadowColor = [UIColor blackColor];
        _headLabel.shadowOffset = CGSizeMake(1, 1);
        //self.headLabel.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.headLabel];
    }return self;
}

@end
