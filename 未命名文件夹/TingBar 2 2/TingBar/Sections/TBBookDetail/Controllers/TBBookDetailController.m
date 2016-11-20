//
//  TBBookDetailController.m
//  TingBar
//
//  Created by lanouhn on 15/8/25.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBBookDetailController.h"
#import "TBGetMainData.h"
#import "TBBookDetailModel.h"
#import "TBMacros.h"
#import "UIImageView+WebCache.h"
#import "TBDetailModel.h"
#import "TBSectionsViewCell.h"
#import "TBGetPicture.h"
#import "SectionsController.h"
#import "TBMyCollectDetailController.h"
#import "TBsingleton.h"
#import "DataBaseHelper.h"
#import "TBBookmodel.h"
#import "GiFHUD.h"
@interface TBBookDetailController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *listArr;
@property (nonatomic, strong)UIView *listView;
@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)UILabel *AllsectionsLabel;

@property (nonatomic,strong)UILabel *alable;
@property (nonatomic, strong)UIAlertView *alert;
@property (nonatomic, strong)UIAlertView *alert1;
@property (nonatomic,strong)DataBaseHelper *helper;

@end

@implementation TBBookDetailController
//-(UIImage *)playVideo{
//    if (_playVideoimg == nil) {
//        self.playVideoimg = [UIImage imageNamed:@"ic_live_video_play_big_normal.png"];
//    }return _playVideoimg;
//    
//    
//}
- (UILabel *)alable{
    if (_alable == nil) {
        self.alable = [[UILabel alloc] init];
    }return _alable;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [GiFHUD setGifWithImageName:@"pika.gif"];
    
    [self setUpBarButton];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //[self layoutView];
    [self getDetailData];
    
}
- (void)getDetailData{
    [GiFHUD dismiss];
    [GiFHUD show];
    NSString *completeUrl = [NSString stringWithFormat:@"http://api.mting.info/yyting/bookclient/ClientGetBookDetail.action?id=%@",self.ID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:completeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        self.model = [[TBBookDetailModel alloc] initWithDic:dic];
        [GiFHUD dismiss];
        [self configureView];
       // [self configureListView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [GiFHUD dismiss];
        NSLog(@"请求网络失败");
        [self setUpaLert];
    }];
    
}
- (void)removeFromView{
    [self.alert dismissWithClickedButtonIndex:0 animated:YES];
}
- (void)setUpaLert{
    self.alert = [[UIAlertView alloc] initWithTitle:@"请检查网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(removeFromView) userInfo:nil repeats:NO];
    [_alert show];
}

- (void)setUpBarButton{
    UIButton *playBt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBt2 setBackgroundImage:[UIImage imageNamed:@"more_donation_center.png"] forState:UIControlStateNormal];
    [playBt2 addTarget:self action:@selector(storeBook) forControlEvents:UIControlEventTouchUpInside];
    playBt2.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:playBt2];
     UIButton *playBt3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBt3 setBackgroundImage:[UIImage imageNamed:@"button_playcntrol_share.png"] forState:UIControlStateNormal];
    [playBt3 addTarget:self action:@selector(handleshared) forControlEvents:UIControlEventTouchUpInside];
    playBt3.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithCustomView:playBt3];
 self.navigationItem.rightBarButtonItems = @[right, right1];
}
//把model传到收藏界面
- (void)storeBook{
    self.helper = [DataBaseHelper shareDataBaseHelper];
   
    TBBookmodel *model1 = [[TBBookmodel alloc] initWithAnnouncer:self.model.announcer bookName:self.model.name ids:self.ID];
     [self.helper insertContact:model1];
    
     
    }



- (void)configureView{
    if ([self.model.state integerValue] == 1) {
        self.stateLabel.text = @"状态:  连载";
    }
    
    self.nameLabel.text = self.model.name;
    self.typeLabel.text = [NSString stringWithFormat:@"类别:  %@", self.model.type];
    self.authorLabel.text = [NSString stringWithFormat:@"原著:  %@", self.model.author];
    self.actorLabel.text = [NSString stringWithFormat:@"演播:  %@", self.model.announcer];
    if ([self.model.play integerValue] > 10000) {
        CGFloat a = [self.model.play integerValue] / 10000;
        self.playLabel.text = [NSString stringWithFormat:@"人气:  %.f万", a];
    }else{
        self.playLabel.text = [NSString stringWithFormat:@"人气:  %@", self.model.play];
    }
    
    self.upDate.text = [NSString stringWithFormat:@"更新日期:  %@", self.model.update];
    self.sectionsLabel.text = [NSString stringWithFormat:@"集数:  %@", self.model.sections];
    self.title = @"书籍详情";
    CGFloat height = [TBGetPicture heightForContentText:self.model.desc];
    self.alable.frame = self.introLabel.frame;
    self.introLabel.frame = CGRectMake(_alable.frame.origin.x, _alable.frame.origin.y, _alable.frame.size.width, height);
    self.introLabel.text = self.model.desc;
    self.introLabel.numberOfLines = 0;
    self.scrollView.contentSize = CGSizeMake(TBWidth, self.introLabel.frame.origin.x + self.introLabel.frame.size.height + 200);
    NSURL *url = [NSURL URLWithString:self.model.cover];
    [self.imagView sd_setImageWithURL:url placeholderImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"7.00.jpg" ofType:nil]]];
    UITapGestureRecognizer *tapGrsture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePush)];
    [self.imagView addGestureRecognizer:tapGrsture];
    self.imagView.userInteractionEnabled = YES;
    self.playVideo.image = [UIImage imageNamed:@"ic_live_video_play_big_normal.png"];
    self.introScrool.contentSize = CGSizeMake(TBWidth - 20, self.introLabel.frame.origin.y + height);
    if ([self.model.state integerValue] == 2) {
        self.stateLabel.text = @"状态:  完结";
    }else{
        self.stateLabel.text = @"状态:  连载";
    }
    
}
- (void)handlePush{
    SectionsController *sectionVC = [[SectionsController alloc] init];
    sectionVC.ID = self.ID;
    sectionVC.sections = [self.model.sections stringValue];
    sectionVC.name = self.model.name;
    sectionVC.cover = self.model.cover;
    [self.navigationController pushViewController:sectionVC animated:YES];
    
}

//fenxiang
- (void)handleshared{
    NSURL *url = [NSURL URLWithString:self.model.cover];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        [TBGetPicture sharedView:self withShareText:[NSString stringWithFormat:@"%@", self.model.name] shareImage:[UIImage imageWithData:data]];
    }];
}






/*
- (void)layoutView{
    self.scrollView.delegate =self;
    self.scrollView.contentSize = CGSizeMake(TBWidth * 2, TBHight - 94);
    self.listView = [[UIView alloc] initWithFrame:CGRectMake(TBWidth, 0 , TBWidth, CGRectGetHeight(self.scrollView.frame))];
    // _listView.backgroundColor = [UIColor greenColor];
    [self.scrollView addSubview:_listView];
    self.introScrool.frame = CGRectMake(0, 0, TBWidth, CGRectGetHeight(self.scrollView.frame));
}
*/
/*
- (void)configureListView{
    self.AllsectionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, CGRectGetHeight(self.bookDetailBT.frame))];
    _AllsectionsLabel.text = [NSString stringWithFormat:@"共 %@ 章",[self.model.sections stringValue]];
    _AllsectionsLabel.textColor = [UIColor darkGrayColor];
    //sectionsLabel.backgroundColor = [UIColor redColor];
    [self.listView addSubview:_AllsectionsLabel];
}
 */

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [GiFHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }


@end
