//
//  TBfooterView.m
//  TingBar
//
//  Created by lanouhn on 15/8/28.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBfooterView.h"

#import "TBMacros.h"
@implementation TBfooterView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.alabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TBWidth, 40)];
        self.backgroundColor = [UIColor colorWithRed:246/256.0 green:246/256.0 blue:246/256.0 alpha:1];
        self.alabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.alabel];
     }return self;
    
}

@end
