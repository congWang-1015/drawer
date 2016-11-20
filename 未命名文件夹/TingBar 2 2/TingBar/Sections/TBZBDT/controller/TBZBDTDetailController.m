//
//  TBZBDTDetailController.m
//  TingBar
//
//  Created by lanouhn on 15/9/5.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBZBDTDetailController.h"
#import "TBSectionsViewCell.h"
#import "AFNetworking.h"
#import "GiFHUD.h"
#import "TBDetailModel.h"
#import "AFSoundManager.h"
#import "TBMacros.h"
@interface TBZBDTDetailController ()
@property (nonatomic, strong)NSMutableArray *datasource;
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
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TBZBDTDetailController
- (NSMutableArray *)datasource{
    if (_datasource == nil) {
        self.datasource = [NSMutableArray array];
    }return _datasource;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    [self.tableView registerNib:[UINib nibWithNibName:@"TBSectionsViewCell" bundle:nil] forCellReuseIdentifier:@"cellsssss"];
    
}

- (void)getData{
    [GiFHUD dismiss];
    [GiFHUD show];
    NSString *completeUrl = [NSString stringWithFormat:@"http://api.mting.info/yyting/snsresource/getAblumnAudios.action?ablumnId=%@&sortType=1&token=c-OSIyXjARZpyYxpsrvdPZWQdfZwFL7R-zdukwv7lbY*&q=6605&imei=ODY0MzAxMDI2OTU2Nzk0",self.ID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:completeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *arr = dic[@"list"];
        [self.datasource removeAllObjects];
        for (NSDictionary *tempDic in arr) {
            TBDetailModel *Typemodel = [[TBDetailModel alloc] initWithDic:tempDic];
            [self.datasource addObject:Typemodel];
            [self.tableView reloadData];
        }
        [GiFHUD dismiss];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [GiFHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请检查网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        NSLog(@"请求网络失败");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBDetailModel *model = self.datasource[indexPath.row];
    TBSectionsViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellsssss" forIndexPath:indexPath];
    cell.sectionsLabel.text = model.name;
    CGFloat a = [model.size integerValue]/(1024 * 1024.0);
    cell.sizeLabel.text = [NSString stringWithFormat:@"%.2fM",a];
    cell.downLoadLabel.tag = 100 + indexPath.row;
    cell.downLoadLabel.text = nil;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 130;
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
    //_currentName.text = @"加载中...";
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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [GiFHUD dismiss];
   // self.navigationController.navigationBar.hidden = YES;
    
    [self.imageView startAnimating];
    [_items removeAllObjects];
    [_queue pause];
    _queue = nil;
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


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [GiFHUD show];
    
    TBDetailModel *model = self.datasource[indexPath.row];
    [_playBt setBackgroundImage:self.stopIMG forState:UIControlStateNormal];
    self.currentName.text = model.name;
    
    if (self.datasource.count != 0) {
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
            [self.imageView startAnimating];
            self.progress.progress = (float)(long)item.timePlayed / (float)(long)item.duration;
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"mm:ss"];
            
            NSDate *elapsedTimeDate = [NSDate dateWithTimeIntervalSince1970:item.timePlayed - 30 * 60];
            self.totalLabel.text = [formatter stringFromDate:elapsedTimeDate];
            
            NSDate *timeRemainingDate = [NSDate dateWithTimeIntervalSince1970:item.duration - 30 * 60];
            self.littleLabel.text = [formatter stringFromDate:timeRemainingDate];

            if ([self.totalLabel.text isEqualToString:self.littleLabel.text]) {
                [self.imageView stopAnimating];
            }
        } andFinishedBlock:^(AFSoundItem *nextItem) {
        }];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
    }
    

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [GiFHUD dismiss];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
