//
//  TBPHListController.m
//  TingBar
//
//  Created by lanouhn on 15/8/29.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBPHListController.h"
#import "UIImageView+WebCache.h"
#import "TBBookDetailModel.h"
#import "TBMacros.h"
#import "TBTypeResourceListCell.h"
#import "UIImageView+WebCache.h"
#import "TBBookDetailController.h"
#import "TBGetMainData.h"
#import "GiFHUD.h"
@interface TBPHListController ()<UITableViewDelegate, UITableViewDataSource, tableViewRefresh>
@property (nonatomic, strong)UIScrollView *titleScrollView;


@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)NSArray *titleArr;
//@property (nonatomic, assign)NSInteger title;
@property (nonatomic, strong)UIView *lineView;

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, assign)NSInteger TypeNum;
@property (nonatomic, strong)UIImage *img;
@property (nonatomic, assign)NSInteger Btype;
@property (nonatomic, strong)UIImage *stateImg;
@property (nonatomic, strong)UIImage *stateImg1;
@end

@implementation TBPHListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.name;
    self.Btype = 1;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [TBGetMainData sharedGetMainData].delegate = self;
    self.view.backgroundColor = [UIColor yellowColor];
   [self setUpBigViewScrollView];
    [TBGetMainData getDetailDatatype:self.type withBtype:self.Btype];
    self.dataArr = [TBGetMainData sharedGetMainData].PHListArr;
    [self setUptitleScrollView];
    
    // Do any additional setup after loading the view.
}

- (void)setUptitleScrollView{
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, TBWidth, 35)];
    self.titleScrollView.backgroundColor = [UIColor colorWithRed:248/256.0 green:202/256.0 blue:239/256.0 alpha:1];
    [self.view addSubview:self.titleScrollView];
    [self setUpButton];
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(TBWidth/6 - 5, 32, 60, 2)];
    self.lineView.backgroundColor = [UIColor cyanColor];
    [self.titleScrollView addSubview:self.lineView];
}

- (void)setUpButton{
    self.titleArr = @[@"周榜", @"月榜", @"总榜"];
    for (NSInteger i = 0; i < 3; i++) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.button.frame = CGRectMake(TBWidth/6 - 5 + i * 95, 0, 60, 35);
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
    NSLog(@"%ld",(long)sender.tag);
    if (sender.tag == 100) {
        self.Btype = 1;
        [self.dataArr removeAllObjects];
         [TBGetMainData getDetailDatatype:self.type withBtype:self.Btype];
        
    }else if (sender.tag == 101){
        self.Btype = 2;
        [self.dataArr removeAllObjects];
        [TBGetMainData getDetailDatatype:self.type withBtype:self.Btype];
        
    }else{
        self.Btype= 3;
        [self.dataArr removeAllObjects];
         [TBGetMainData getDetailDatatype:self.type withBtype:self.Btype];
        }
}

- (void)setUpBigViewScrollView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, TBWidth, TBHight - 64 - 35) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"TBTypeResourceListCell" bundle:nil] forCellReuseIdentifier:@"cellssss"];
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
    if (self.dataArr != nil || self.dataArr.count !=0 ) {
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
    }else{
        TBTypeResourceListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellssss" forIndexPath:indexPath];
        return cell;
    }
}
- (UIImage *)stateImg{
    if (_stateImg == nil) {
        self.stateImg = [UIImage imageNamed:@"finish.png"];
    }return _stateImg;
    
}
- (UIImage *)stateImg1{
    if (_stateImg1 == nil) {
        self.stateImg1 = [UIImage imageNamed:@"finish.png"];
    }return _stateImg1;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TBBookDetailModel *model = self.dataArr[indexPath.row];
    TBBookDetailController *detailVC = [[TBBookDetailController alloc] init];
    detailVC.ID = model.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    self.lineView.frame = CGRectMake((scrollView.contentOffset.x/375) * 95 + 60, 33, 60, 2);
//}

//实现刷新tableView协议的方法
- (void)tableViewReloadData{
    [GiFHUD dismiss];
    [self.tableView reloadData];
}



-(UIImage *)img{
    if (_img == nil) {
        self.img = [UIImage imageNamed:@"add_photo.png"];
    }return _img;
}

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        self.dataArr = [NSMutableArray array];
    }return _dataArr;
    
}


- (void)viewWillDisappear:(BOOL)animated{
    //[self.dataArr removeAllObjects];
    [GiFHUD dismiss];
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
