//
//  TBTypeResourceDetailController.m
//  TingBar
//
//  Created by lanouhn on 15/8/27.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBTypeResourceDetailController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "TBBookDetailModel.h"
#import "TBMacros.h"
#import "TBTypeResourceListCell.h"
#import "TBBookDetailController.h"
#import "TBAboutMeVC.h"
#import "GiFHUD.h"
@interface TBTypeResourceDetailController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UIScrollView *titleScrollView;


@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)NSArray *titleArr;
//@property (nonatomic, assign)NSInteger title;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)NSInteger TypeNum;
@property (nonatomic, strong)UIImage *img;
@property (nonatomic, strong)UIImage *stateImg;
@property (nonatomic, strong)UIImage *stateImg1;
@property (nonatomic, strong)UIAlertView *alert;

@end

@implementation TBTypeResourceDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
     [GiFHUD setGifWithImageName:@"pika.gif"];
    [GiFHUD show];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = self.name;
    self.view.backgroundColor = [UIColor cyanColor];
    [self setUptitleScrollView];
    [self setUpBigViewScrollView];
    [self.tableView registerNib:[UINib nibWithNibName:@"TBTypeResourceListCell" bundle:nil] forCellReuseIdentifier:@"cellssss"];
    [self getDetailData];
    self.TypeNum = 2;
    // Do any additional setup after loading the view.
}
- (void)getDetailData{
    [GiFHUD dismiss];
    //[GiFHUD show];
     NSString *completeUrl = [NSString stringWithFormat:@"http://117.25.143.74/yyting/bookclient/ClientTypeResource.action?type=%@&pageNum=0&pageSize=500&sort=%ld&token=c-OSIyXjARZpyYxpsrvdPcMarrMcswoK-zdukwv7lbY*&q=38&imei=ODY0MzAxMDI2OTU2Nzk0",self.ID,(long)self.TypeNum];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:completeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *arr = dic[@"list"];
        for (NSDictionary *tempDic in arr) {
            TBBookDetailModel *TBbookModel = [[TBBookDetailModel alloc] initWithDic:tempDic];
            [self.dataArr addObject:TBbookModel];
        }
        if (self.dataArr.count != 0) {
            [GiFHUD dismiss];
             [self.tableView reloadData];
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [GiFHUD dismiss];
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

- (void)setUptitleScrollView{
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, XRF(375), 35)];
    self.titleScrollView.backgroundColor = [UIColor colorWithRed:248/256.0 green:202/256.0 blue:239/256.0 alpha:1];
    [self.view addSubview:self.titleScrollView];
    [self setUpButton];
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(XRF(50), 32, 60, 2)];
    self.lineView.backgroundColor = [UIColor cyanColor];
    [self.titleScrollView addSubview:self.lineView];
}

- (void)setUpButton{
    self.titleArr = @[@"推荐", @"最新", @"热门"];
    for (NSInteger i = 0; i < 3; i++) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.button.frame = CGRectMake(XRF(50) + i * 95, 0, 60, 35);
        //self.button.backgroundColor = [UIColor blueColor];
        _button.tag = 100 + i;
        [self.titleScrollView addSubview:self.button];
        [self.button addTarget:self action:@selector(handleLoad:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)handleLoad:(UIButton *)sender{
    sender.selected = NO;
    
    if (sender.isSelected == NO) {
        if (self.dataArr == nil) {
            return;
        }
        [UIView animateWithDuration:0.1 animations:^{
            self.lineView.frame = CGRectMake(sender.frame.origin.x, 33, 60, 2);
            }];
        sender.selected = YES;
    }
       if (sender.tag == 100) {
        self.TypeNum = 2;
        [self.dataArr removeAllObjects];
        [self getDetailData];
     }else if (sender.tag == 101){
        self.TypeNum = 1;
        [self.dataArr removeAllObjects];
        [self getDetailData];

    }else{
        self.TypeNum = 3;
        [self.dataArr removeAllObjects];
        [self getDetailData];
    }
    
    
}
- (void)setUpBigViewScrollView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, TBWidth, self.view.frame.size.height - 35 - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TBBookDetailModel *model = self.dataArr[indexPath.row];
    TBTypeResourceListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellssss" forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:model.cover];
    [cell.bookImgV sd_setImageWithURL:url placeholderImage:self.img];
   cell.bookName.text = model.name;
    cell.announcer.text = [NSString stringWithFormat:@"播音: %@",model.announcer];
    cell.sectionsLabel.text = [NSString stringWithFormat:@"集数: %@",[model.sections stringValue]];
    if ([model.hot integerValue] > 10000) {
        CGFloat a = [model.hot integerValue] / 10000.0;
        cell.hotLabel.text = [NSString stringWithFormat:@"人气: %.2f万",a];
    }else{
        cell.hotLabel.text = [NSString stringWithFormat:@"人气: %@",[model.hot stringValue]];}
    if ([model.state intValue]== 2) {
        cell.stateImg.image = self.stateImg;
    }else{
        cell.stateImg.image = self.stateImg1;
    }
    cell.accessoryType = UITableViewCellStyleValue1;
    return cell;
    
    
}

- (UIImage *)stateImg{
    if (_stateImg == nil) {
        self.stateImg = [UIImage imageNamed:@"finish.png"];
    }return _stateImg;
    
}
- (UIImage *)stateImg1{
    if (_stateImg1 == nil) {
        self.stateImg1 = [UIImage imageNamed:@"serialize.png"];
    }return _stateImg1;
    
}




- (UIImage *)img{
    if (_img == nil) {
        self.img = [UIImage imageNamed:@"7.00.jpg"];
    }return _img;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TBBookDetailModel *model = self.dataArr[indexPath.row];
    TBBookDetailController *detailVC = [[TBBookDetailController alloc] init];
    detailVC.ID = model.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
}



- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        self.dataArr = [NSMutableArray array];
    }return _dataArr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
