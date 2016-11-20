//
//  TBAudioCell.m
//  TingBar
//
//  Created by lanouhn on 15/9/2.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBAudioCell.h"

@implementation TBAudioCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)passValue:(float)progress{
    self.progress.progress = progress;
    
}
@end
