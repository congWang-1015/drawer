//
//  TBBookDetailController.h
//  TingBar
//
//  Created by lanouhn on 15/8/25.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBTopImgModel.h"
#import "TBBookDetailModel.h"

@interface TBBookDetailController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *introScrool;
@property (nonatomic, strong)TBTopImgModel *Topmodel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imagView;
@property (weak, nonatomic) IBOutlet UIImageView *playVideo;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorLabel;

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *playLabel;
@property (weak, nonatomic) IBOutlet UILabel *upDate;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (nonatomic, strong)TBBookDetailModel *model;
@property (nonatomic, strong)NSString *ID;
@end
