//
//  SectionsController.m
//  TingBar
//
//  Created by lanouhn on 15/8/30.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "SectionsController.h"
#import "TBMacros.h"
#import "UIImageView+WebCache.h"
#import "TBDetailModel.h"
#import "TBSectionsViewCell.h"
#import "TBGetPicture.h"
#import "AFNetworking.h"
#import "TBMacros.h"
#import "AFSoundManager.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "TBsingleton.h"
#import "GiFHUD.h"
@interface SectionsController ()<TBsingleton>
@property (nonatomic, strong)NSMutableArray *listArr;
@property (nonatomic, strong) AFSoundPlayback *playback;
@property (nonatomic, strong) AFSoundQueue *queue;
@property (nonatomic, strong)UIWindow *window;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong)UILabel *alabel;
@property (nonatomic, strong)UIImage *playIMG;
@property  (nonatomic, strong)UIImage *stopIMG;
@property (nonatomic, strong)UILabel *currentName;
@property (nonatomic, strong)UIProgressView *progress;
@property (nonatomic, strong)UIButton *playBt;
@property (nonatomic, strong)UILabel *totalLabel;
@property (nonatomic, strong)UILabel *littleLabel;
@property (nonatomic, assign)NSInteger page;
//
@property (nonatomic, strong)UIAlertView *alert;
@property (nonatomic, strong)UIAlertView *alert1;
@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation SectionsController
- (void)viewWillAppear:(BOOL)animated{
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [TBsingleton sharedSingleton].delegate = self;
    [GiFHUD setGifWithImageName:@"pika.gif"];
    
    self.title = @"章节列表";
    self.page = 1;
    //[self setUpBarButton];
    [self getListDataID:self.ID page:_page];
    [self.tableView registerNib:[UINib nibWithNibName:@"TBSectionsViewCell" bundle:nil] forCellReuseIdentifier:@"cellsssss"];
    
}
- (UIImage *)playIMG{
    if (_playIMG == nil) {
        self.playIMG = [UIImage imageNamed:@"playcntrol_stop_new.png"];
    }return _playIMG;
    
}
- (UIImage *)stopIMG{
    if (_stopIMG == nil) {
        self.stopIMG = [UIImage imageNamed:@"playcntrol_start_new.png"];
    }return _stopIMG;
    
}

- (void)setUpRefresh{
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}
- (void)footerRefresh{
    if (self.listArr.count > [self.sections integerValue]- 1) {
        [self.tableView.footer noticeNoMoreData];
    }else{
    [self getListDataID:self.ID page:self.page+=1];
    [self.tableView.footer endRefreshing];}
}

//- (void)setUpBarButton{
//    UIButton *playBt2 = [UIButton buttonWithType:UIButtonTypeCustom];
//        [playBt2 setBackgroundImage:[UIImage imageNamed:@"button_playcntrol_share.png"] forState:UIControlStateNormal];
//        [playBt2 addTarget:self action:@selector(handleshared) forControlEvents:UIControlEventTouchUpInside];
//        playBt2.frame = CGRectMake(0, 0, 20, 20);
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:playBt2];
//    self.navigationItem.rightBarButtonItem = right;
//    
//    
//}
- (void)handlePlayAndStop:(UIButton *)sender{
    if ([self.littleLabel.text  isEqual: @"0.00"] || [self.littleLabel.text  isEqual: self.totalLabel.text]) {
        [self setUpaLert1];
        
        return;
    }
    if (sender.isSelected == NO) {
         [self.imageView stopAnimating];
        [sender setBackgroundImage:self.playIMG forState:UIControlStateNormal];
        [_queue pause];
        
        sender.selected = YES;
    }else{
        [sender setBackgroundImage:self.stopIMG forState:UIControlStateNormal];
        [_queue playCurrentItem];
        
        sender.selected = NO;
    }
    
    
}
- (void)removeFromView{
    [self.alert dismissWithClickedButtonIndex:0 animated:YES];
    [self.alert1 dismissWithClickedButtonIndex:0 animated:YES];
    
}

- (void)setUpaLert1{
    self.alert1 = [[UIAlertView alloc] initWithTitle:@"选取下面的章节进行播放" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(removeFromView) userInfo:nil repeats:NO];
    [_alert1 show];
}

- (NSMutableArray *)listArr{
    if (_listArr == nil) {
        self.listArr = [NSMutableArray array];
    }return _listArr;
}

- (void)getListDataID:(NSString *)ID page:(NSInteger )page {
    [GiFHUD dismiss];
    [GiFHUD show];
    //http://117.25.143.74/yyting/bookclient/ClientGetBookResource.action?bookId=28924&pageNum=1&pageSize=50&sortType=0&token=c-OSIyXjARZpyYxpsrvdPcMarrMcswoK-zdukwv7lbY*&q=34&imei=ODY0MzAxMDI2OTU2Nzk0
    NSString *completeUrl1 = [NSString stringWithFormat:@"http://117.25.143.74/yyting/bookclient/ClientGetBookResource.action?bookId=%@&pageNum=%ld&pageSize=50&sortType=0&token=c-OSIyXjARZpyYxpsrvdPcMarrMcswoK-zdukwv7lbY*&q=34&imei=ODY0MzAxMDI2OTU2Nzk0",ID, (long)page];
    AFHTTPRequestOperationManager *manager1 = [AFHTTPRequestOperationManager manager];
    [manager1 GET:completeUrl1 parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSLog(@"%@",responseObject);
        NSArray *arr = dic[@"list"];
        if (arr == nil || arr.count == 0) {
            self.page--;
        }
        for (NSDictionary *tempDic in arr) {
            TBDetailModel *detailModel = [[TBDetailModel alloc] initWithDic:tempDic];
            [self.listArr addObject:detailModel];
            [GiFHUD dismiss];
            [self.tableView reloadData];
            [self setUpRefresh];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求网络失败");
        [GiFHUD dismiss];
        self.page--;
        [self setUpaLert];
    }];
}

- (void)setUpaLert{
    self.alert = [[UIAlertView alloc] initWithTitle:@"请检查网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(removeFromView) userInfo:nil repeats:NO];
    [_alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 130;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBDetailModel *model = self.listArr[indexPath.row];
    TBSectionsViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellsssss" forIndexPath:indexPath];
    cell.sectionsLabel.text = model.name;
    CGFloat a = [model.size integerValue]/(1024 * 1024.0);
    cell.sizeLabel.text = [NSString stringWithFormat:@"%.2fM",a];
    cell.downLoadLabel.tag = 100 + indexPath.row;
    cell.downLoadLabel.text = nil;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [GiFHUD show];
    
    TBDetailModel *model = self.listArr[indexPath.row];
    [_playBt setBackgroundImage:self.stopIMG forState:UIControlStateNormal];
    self.currentName.text = model.name;
    
    if (self.listArr.count != 0) {
        [_items removeAllObjects];
        [_queue pause];
        _queue = nil;
       
        self.currentName.text = model.name;
         AFSoundItem *item7 = [[AFSoundItem alloc] initWithStreamingURL:[NSURL URLWithString:model.path]];
        _items = [NSMutableArray arrayWithObjects:item7 ,nil];
        _queue = [[AFSoundQueue alloc] initWithItems:_items];
        [_queue playCurrentItem];
        
        [_queue listenFeedbackUpdatesWithBlock:^(AFSoundItem *item) {
            
            if ((long)item.duration == (long)item.timePlayed) {
                [_playBt setBackgroundImage:self.playIMG forState:UIControlStateNormal];
                [_queue pause];
                 [self.imageView stopAnimating];
            }
            [GiFHUD dismiss];
            [self.imageView startAnimating];//
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"mm:ss"];
            NSDate *elapsedTimeDate = [NSDate dateWithTimeIntervalSince1970:item.timePlayed - 30 * 60];
            self.totalLabel.text = [formatter stringFromDate:elapsedTimeDate];
            
            NSDate *timeRemainingDate = [NSDate dateWithTimeIntervalSince1970:item.duration - 30 * 60];
            self.littleLabel.text = [formatter stringFromDate:timeRemainingDate];
            self.progress.progress = (float)(long)item.timePlayed / (float)(long)item.duration;
            if ([self.totalLabel.text isEqualToString:self.littleLabel.text]) {
                [self.imageView stopAnimating];
            }
        } andFinishedBlock:^(AFSoundItem *nextItem) {
        }];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

       
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u=4033326029,2163925402&fm=21&gp=0.jpg"]];
    imgV.userInteractionEnabled = YES;
    imgV.frame = CGRectMake(0, 0, TBWidth, 130);
    self.playBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [_playBt setBackgroundImage:self.playIMG forState:UIControlStateNormal];
    [_playBt addTarget:self action:@selector(handlePlayAndStop:) forControlEvents:UIControlEventTouchUpInside];
    _playBt.frame = CGRectMake(XRF(158), 50, 50, 50);
    [imgV addSubview:self.playBt];
     self.currentName = [[UILabel alloc] initWithFrame:CGRectMake(0, 95, TBWidth, 30)];
    _currentName.textAlignment = NSTextAlignmentCenter;
    _currentName.font = [UIFont boldSystemFontOfSize:15];
    [imgV addSubview:self.currentName];
    
    self.progress = [[UIProgressView alloc] initWithFrame:CGRectMake(80, 45, TBWidth - 160, 20)];
    _progress.progressTintColor = [UIColor redColor];
    _progress.trackTintColor = [UIColor greenColor];
    [imgV addSubview:self.progress];
    self.totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.progress.frame) - 65, 30, 60, 30)];
    _totalLabel.text = @"0:00";
    _totalLabel.textAlignment = NSTextAlignmentRight;
    [imgV addSubview:_totalLabel];
    
    self.littleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.progress.frame) + 5, 30, 60, 30)];
     _littleLabel.text = @"0:00";
    [imgV addSubview:_littleLabel];
    
    
    
    UILabel *AllsectionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,TBWidth  , 30)];
    AllsectionsLabel.text = [NSString stringWithFormat:@"共 %@ 章",self.sections];
    AllsectionsLabel.textAlignment = NSTextAlignmentCenter;
    AllsectionsLabel.textColor = [UIColor darkGrayColor];
    [imgV addSubview:AllsectionsLabel];
    
    
    NSMutableArray *imageArr = [NSMutableArray array];
    //2.使用for循环添加图片
    for (int i = 1; i < 30; i++) {
            //根据图片路径获取图片
            UIImage *_image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"soundwave%d", i] ofType:@"png"]];
                [imageArr addObject:_image];
        }
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(TBWidth - 50, 0, 30, 30)];
        //4.给_imageView添加一个图片数组, 用来显示
        _imageView.animationImages = imageArr;
        //5.设置该图片数组的播放时间(以秒做单位)
        _imageView.animationDuration = 3;
        //6.设置图片播放的次数 0 ----  表示无限循环播放
        _imageView.animationRepeatCount = 0;
        //7.让_imageView执行动画
    
        //[_imageView stopAnimating];//停止播放动画
        //8.
        [imgV addSubview:_imageView];
    return imgV;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [GiFHUD dismiss];
    [self.imageView stopAnimating];
    [_items removeAllObjects];
    [_queue pause];
    _queue = nil;
}
//断点下载
@end
