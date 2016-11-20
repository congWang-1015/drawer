//
//  TBZBDTController.m
//  TingBar
//
//  Created by lanouhn on 15/9/4.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBZBDTController.h"
#import "TBZBDTCell.h"
#import "TBMacros.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "AFNetworking.h"
#import "TBBookDetailModel.h"
#import "GiFHUD.h"
#import "UIImageView+WebCache.h"
#import "TBBookDetailController.h"
#import "TBZBDTDetailController.h"
#import "TBZBDTTypeController.h"
@interface TBZBDTController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic)UIWindow *window;
@property (strong, nonatomic) NSArray* windowsArr;
@property (strong, nonatomic)UIButton *button;
@property (strong, nonatomic)UIButton *button1;
@property (strong, nonatomic)NSArray *Btarray;
@property (strong, nonatomic)NSMutableArray *datasource;
@property (strong, nonatomic)UIImage *img;
@property (strong, nonatomic)UIView *aview;
@end

@implementation TBZBDTController
-(NSMutableArray *)datasource{
    if (_datasource == nil) {
        self.datasource = [NSMutableArray array];
    }return _datasource;
}
- (NSArray *)Btarray{
    if (_Btarray == nil) {
        self.Btarray = @[@[@"娱乐", @"文艺", @"亲子", @"情感"], @[@"科技", @"生活", @"教育", @"财经"]];
    }return _Btarray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.isShowing=NO;
    self.navigationController.navigationBar.hidden = YES;
    [self setUpTopView];
    [self addTap];
    [self getData:1];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.frame = CGRectMake(0, 20, TBWidth, TBHight - 20);
    [self.tableView registerNib:[UINib nibWithNibName:@"TBZBDTCell" bundle:nil] forCellReuseIdentifier:@"TBzbdts"];
}
- (UIButton *)button{
    if (_button == nil) {
         self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setBackgroundImage:[UIImage imageNamed:@"ic_back_normal.png"] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(handlePop) forControlEvents:UIControlEventTouchUpInside];
        _button.frame = CGRectMake(15, 25, 20, 20);

    }return _button;
}
- (UIButton *)button1{
    if (_button1 == nil) {
          self.button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button1 setBackgroundImage:[UIImage imageNamed:@"ic_back_normal.png"] forState:UIControlStateNormal];
        [_button1 addTarget:self action:@selector(handlePop) forControlEvents:UIControlEventTouchUpInside];
        _button1.frame = CGRectMake(15, 15, 20, 20);
    }return _button1;
}
- (void)addTap{
    self.aview = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 50, 50)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePop)];
    [self.aview addSubview:self.button1];
    [self.aview addGestureRecognizer:tap];
}
//创建顶部视图放在window上
- (void)setUpTopView{
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TBWidth, 64)];
    self.topView.backgroundColor = [UIColor colorWithRed:38/256.0 green:185/256.0 blue:160/256.0 alpha:0.0000000000001];
    //
   
    [self.topView addSubview:self.button];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 25, TBWidth - 60, 30)];
    titleLabel.text = @"主播电台";
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.topView addSubview:titleLabel];
    self.topView.tag = 100;
    //
    self.windowsArr = [UIApplication sharedApplication].windows;
    self.window = [_windowsArr objectAtIndex:0];
    [self.window addSubview:self.topView];
    if(_window.subviews.count > 0){
        self.topView = [_window.subviews objectAtIndex:0];
    }
    
}

- (void)handlePop{
    self.navigationController.navigationBar.hidden = NO;
    for (UIView *viiew in self.window.subviews) {
        if ([viiew isKindOfClass:[UIView class]] && viiew.tag == 100) {
            viiew.hidden = YES;
        }
    }

    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TBWidth, 250)];
    aview.backgroundColor = [UIColor whiteColor];
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hot_anchor_list_top_bg.png"]];
    //
    imgV.userInteractionEnabled = YES;
    
    imgV.frame = CGRectMake(0, 0, TBWidth, 250);
    for (NSInteger i =0; i < 4; i++) {
        for (NSInteger j = 0; j < 2; j++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(XRF(13)  + i * TBWidth / 4.3, 84 + XRF(5) + j * 125/ 1.8, TBWidth/4.5, 125 / 2.0);
            button.backgroundColor = [UIColor colorWithRed:38/256.0 green:185/256.0 blue:160/256.0 alpha:0.4];
            button.alpha = 1;
            if (j == 0) {
                button.tag = 3088 + i;
            }

            if (j == 1) {
                button.tag = 3092 + i;
            }
            [button setTitle:self.Btarray[j][i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(pushTodetailList:) forControlEvents:UIControlEventTouchUpInside];
            [imgV addSubview:button];
        }
    }
    [aview addSubview:imgV];
    UILabel *alabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 270, 100, 30)];
    alabel.shadowColor = [UIColor blackColor];
    //10.设置音译ing的偏移量    CGSizeMake(1, 1)第一个参数是往x轴方向偏移的单位  第二个参数是往y轴方向的偏移单位
    alabel.shadowOffset = CGSizeMake(1.1, 1.1);
    alabel.text = @"节目推荐";
    [aview addSubview:alabel];
    NSArray *arr = @[@"热门", @"最新"];
    for (NSInteger i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(TBWidth - 150 + i * 75, 270, 70, 30);
        [button addTarget:self action:@selector(handleupdate:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        //button.backgroundColor = [UIColor redColor];
        [aview addSubview:button];
    }
     return aview;
    
}
- (void)pushTodetailList:(UIButton *)sender{
    TBZBDTTypeController *typeVC = [[TBZBDTTypeController alloc] init];
    typeVC.titlesz = sender.currentTitle;
    typeVC.type = sender.tag;
    [self.navigationController pushViewController:typeVC animated:YES];
}
- (void)handleupdate:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"热门"]) {
//        self.isShowing = YES;
        [self getData:1];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    if ([sender.currentTitle isEqualToString:@"最新"]) {
//        self.isShowing = YES;
        [self getData:2];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}
- (void)getData:(int)type{
////    if (self.isShowing) {
////         self.isShowing = NO;
//        [GiFHUD show];
//         self.isShowing = NO;
//    }else{
//        self.isShowing = NO;
//        return;
//    }
    [GiFHUD dismiss];
    [GiFHUD show];
    NSString *completeUrl = [NSString stringWithFormat:@"http://api.mting.info/yyting/snsresource/getRecommendAblumns.action?opType=H&referId=0&size=20&type=%d&needFlag=0&typeId=0&token=c-OSIyXjARZpyYxpsrvdPZWQdfZwFL7R-zdukwv7lbY*&q=5911&imei=ODY0MzAxMDI2OTU2Nzk0",type];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:completeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [GiFHUD dismiss];
        NSDictionary *dic = responseObject;
        NSArray *arr = dic[@"list"];
        [self.datasource removeAllObjects];
        for (NSDictionary *tempDic in arr) {
            TBBookDetailModel *Typemodel = [[TBBookDetailModel alloc] initWithDic:tempDic];
            [self.datasource addObject:Typemodel];
         }
         [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [GiFHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请检查网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        NSLog(@"请求网络失败");
    }];
 }

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 300;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBBookDetailModel *model = self.datasource[indexPath.row];
    TBZBDTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TBzbdts" forIndexPath:indexPath];
    cell.titleLabel.text = model.name;
    cell.updateLabel.text = model.update;
    NSURL *url = [NSURL URLWithString:model.cover];
    [cell.imgv sd_setImageWithURL:url placeholderImage:self.img];
    cell.SCLabel.text = [NSString stringWithFormat:@"上传: %@",model.nickName];
    cell.VoiceLabel.text = [NSString stringWithFormat:@"声音: %@",[model.sections stringValue]];
    NSDate *pubDate = [NSDate dateWithTimeIntervalSince1970:[model.updateTime intValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateStr = [formatter stringFromDate:pubDate];
//    cell.updateLabel.text = [NSString stringWithFormat:@"更新: %@",dateStr];
     cell.updateLabel.text = @"更新:最新";
    return cell;
}
- (UIImage *)img{
    if (_img == nil) {
        self.img = [UIImage imageNamed:@"7.00.jpg"];
    }return _img;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   if (self.tableView.contentOffset.y  >=  20) {
       for (UIView *viiew in self.window.subviews) {
           if ([viiew isKindOfClass:[UIView class]] && viiew.tag == 100) {                                                                                                                                                                                                        
               viiew.backgroundColor = [UIColor colorWithRed:38/256.0 green:185/256.0 blue:160/256.0 alpha:1] ;
             }
       }
   }
    if (self.tableView.contentOffset.y  <  20) {
        for (UIView *viiew in self.window.subviews) {
            if ([viiew isKindOfClass:[UIView class]] && viiew.tag == 100) {
                viiew.backgroundColor = [UIColor colorWithRed:38/256.0 green:185/256.0 blue:160/256.0 alpha:0.0000000001];
               
            }
        }

    }
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    for (UIView *viiew in self.window.subviews) {
        if ([viiew isKindOfClass:[UIView class]] && viiew.tag == 100) {
            viiew.hidden = YES;
            
        }
    }
    [GiFHUD dismiss];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    for (UIView *viiew in self.window.subviews) {
        if ([viiew isKindOfClass:[UIView class]] && viiew.tag == 100) {
            viiew.hidden = NO;
           // [viiew addSubview:self.button1];
            [viiew addSubview:self.aview];
        }
    }
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
    TBBookDetailModel *model = self.datasource[indexPath.row];
    TBZBDTDetailController *detailViewController = [TBZBDTDetailController alloc];
    detailViewController.ID = model.ID;
    detailViewController.sections = [model.sections stringValue];
    [self.navigationController pushViewController:detailViewController animated:YES];
    self.navigationController.navigationBarHidden = NO;
    self.button.hidden = YES ;
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
