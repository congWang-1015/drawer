//
//  TBDownFinnishedTableViewController.m
//  TingBar
//
//  Created by lanouhn on 15/9/2.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBDownFinnishedTableViewController.h"
#import "AFSoundManager.h"
#import "TBMacros.h"
@interface TBDownFinnishedTableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (retain,nonatomic)NSArray *arrData;
@property (nonatomic, strong) AFSoundPlayback *playback;
@property (nonatomic, strong) AFSoundQueue *queue;

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UIButton *playBt;
//

//
@property (nonatomic, strong) UIAlertView *alert1;
@property (nonatomic, strong)UIImage *playIMG;
@property  (nonatomic, strong)UIImage *stopIMG;
@property (nonatomic, strong)UILabel *currentName;
@property (nonatomic, strong)UIProgressView *progress;
@property (nonatomic, strong)UILabel *totalLabel;

@property (nonatomic, strong)UILabel *littleLabel;

@end

@implementation TBDownFinnishedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readNSUserDefaults];
    self.tableView.tag = 600;
    self.title = @"本地资源";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
     [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"downWin"];
    [self setUpbutton];
}
- (void)setUpbutton{
    UIButton *playBt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBt2 setBackgroundImage:[UIImage imageNamed:@"delete_icon.png"] forState:UIControlStateNormal];
    //[playBt2 setTitle:@"全部删除" forState:UIControlStateNormal];
    [playBt2 addTarget:self action:@selector(handleshared) forControlEvents:UIControlEventTouchUpInside];
    playBt2.frame = CGRectMake(0, 0, 20, 20);
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:playBt2];
    self.navigationItem.rightBarButtonItem = right;

}
- (void)handleshared{
    [_items removeAllObjects];
    [_queue pause];
    _queue = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"downWIN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    UITableView *tab = (UITableView *)[self.view viewWithTag:600];
    [self readNSUserDefaults];
    [tab reloadData];
}

-(void)readNSUserDefaults
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray *myArray = [userDefaultes arrayForKey:@"downWIN"];
    self.arrData = myArray;
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

    return self.arrData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"downWin" forIndexPath:indexPath];
    
    cell.textLabel.text = self.arrData[self.arrData.count - indexPath.row - 1];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_items removeAllObjects];
    [_queue pause];
    _queue = nil;
    [self.playBt setBackgroundImage:self.stopIMG forState:UIControlStateNormal];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray *myArray = [userDefaultes arrayForKey:@"vid"];
    NSString *str = [NSString stringWithFormat:@"%@.mp3",myArray[self.arrData.count - indexPath.row - 1]];
    //self.currentName.text = myArray[self.arrData.count - indexPath.row - 1];

    NSString *moviePath = [cachePath stringByAppendingPathComponent:str];
        AFSoundItem *item1 = [[AFSoundItem alloc] initWithLocalResource:nil atPath:moviePath];
     _items = [NSMutableArray arrayWithObjects:item1, nil];
    _queue = [[AFSoundQueue alloc] initWithItems:_items];
    [_queue playCurrentItem];
    
    [_queue listenFeedbackUpdatesWithBlock:^(AFSoundItem *item) {
        
        if ((long)item.duration == (long)item.timePlayed) {
            [_playBt setBackgroundImage:self.playIMG forState:UIControlStateNormal];
            [_queue pause];
        }
        self.progress.progress = (float)(long)item.timePlayed / (float)(long)item.duration;
        self.totalLabel.text = [NSString stringWithFormat:@"%.2f", (float)(long)item.timePlayed / 60];
        self.littleLabel.text = [NSString stringWithFormat:@"%.2f", (float)(long)item.duration / 60];
    } andFinishedBlock:^(AFSoundItem *nextItem) {
        NSLog(@"Finished item, next one is %@", nextItem.title);
    }];
   
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"u=4033326029,2163925402&fm=21&gp=0.jpg"]];
    //
    imgV.userInteractionEnabled = YES;

    imgV.frame = CGRectMake(0, 0, TBWidth, 130);
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TBWidth, 130)];
//    view.backgroundColor = [UIColor colorWithRed:246/256.0 green:246/256.0 blue:246/256.0 alpha:1];
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
    _totalLabel.text = @"0.00";
    _totalLabel.textAlignment = NSTextAlignmentRight;
    [imgV addSubview:_totalLabel];
    
    self.littleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.progress.frame) + 5, 30, 60, 30)];
    _littleLabel.text = @"0.00";
    [imgV addSubview:_littleLabel];
        return imgV;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 130;
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
- (void)handlePlayAndStop:(UIButton *)sender{
    if ([self.littleLabel.text  isEqual: @"0.00"] || [self.littleLabel.text  isEqual: self.totalLabel.text]) {
        [self setUpaLert1];
        return;
    }
    if (sender.isSelected == NO) {
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
    [self.alert1 dismissWithClickedButtonIndex:0 animated:YES];
    
}

- (void)setUpaLert1{
    self.alert1 = [[UIAlertView alloc] initWithTitle:@"选取下面的章节进行播放" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(removeFromView) userInfo:nil repeats:NO];
    [_alert1 show];
}

- (void)viewWillDisappear:(BOOL)animated{
    [_items removeAllObjects];
    [_queue pause];
    _queue = nil;
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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
