//
//  TBTypeResourceListCell.h
//  TingBar
//
//  Created by lanouhn on 15/8/27.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBTypeResourceListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bookImgV;
@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UILabel *announcer;
@property (weak, nonatomic) IBOutlet UILabel *sectionsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *stateImg;

@property (weak, nonatomic) IBOutlet UILabel *hotLabel;
@end
