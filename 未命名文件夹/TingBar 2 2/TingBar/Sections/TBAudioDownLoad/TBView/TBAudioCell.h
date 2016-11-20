//
//  TBAudioCell.h
//  TingBar
//
//  Created by lanouhn on 15/9/2.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBDownModel.h"
@interface TBAudioCell : UITableViewCell<downModelDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;

@end
