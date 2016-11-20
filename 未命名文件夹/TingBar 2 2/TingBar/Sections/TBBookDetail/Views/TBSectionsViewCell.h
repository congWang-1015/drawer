//
//  TBSectionsViewCell.h
//  TingBar
//
//  Created by lanouhn on 15/8/28.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBSectionsViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sectionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@property (weak, nonatomic) IBOutlet UILabel *downLoadLabel;
@property (nonatomic, copy) NSString *vid;
@property (nonatomic, copy)NSString *path;

@end
