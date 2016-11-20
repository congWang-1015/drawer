//
//  TBZBDTTypeController.m
//  TingBar
//
//  Created by lanouhn on 15/9/5.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBZBDTTypeController.h"
#import "TBMacros.h"
#import "TBZBDTCell.h"
#import "TBBookDetailModel.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "GiFHUD.h"
#import "TBZBDTDetailController.h"
@interface TBZBDTTypeController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *datasource;
@property (nonatomic, strong)NSMutableArray *Authors;
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)UIImage *img;
@end

@implementation TBZBDTTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBarTONiTEM];
    [GiFHUD setGifWithImageName:@"pika.gif"];
    self.navigationController.navigationBar.hidden = NO;
    self.title = [NSString stringWithFormat:@"%@节目",self.titlesz];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self getData:self.type update:1];
    [self getData1:self.type];
    [self.tableView registerNib:[UINib nibWithNibName:@"TBZBDTCell" bundle:nil] forCellReuseIdentifier:@"TBzbdts"];
    // Do any additional setup after loading the view from its nib.
}
- (NSMutableArray *)datasource{
    if (_datasource == nil) {
        self.datasource = [NSMutableArray array];
    }return _datasource;
}
- (void)setBarTONiTEM{
    UIButton *PHBt = [UIButton buttonWithType:UIButtonTypeCustom];
    PHBt.frame = CGRectMake(345, 0, 20, 20);
    [PHBt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [PHBt setBackgroundImage:[UIImage imageNamed:@"ic_back_normal.png"] forState:UIControlStateNormal];
    [PHBt addTarget:self action:@selector(handle2:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:PHBt];
     self.navigationItem.leftBarButtonItem =_rightBarButtonItem ;
}
- (void)handle2:(UIButton *)sender{
    [GiFHUD dismiss];
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setUptitleLabel{
    self.scrollView.frame = CGRectMake(0, 30, TBWidth, TBWidth/4.47 + 30);
    self.scrollView.contentSize = CGSizeMake(XRF(10)  + 10 * TBWidth / 4.1, TBWidth/4.47 + 30);
    for (int i = 0; i < self.Authors.count; i++) {
        TBBookDetailModel *model = self.Authors[i];
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(XRF(10)  + i * TBWidth / 4.1, 0, TBWidth/4.47, TBWidth/4.47)];
         UILabel *alable= [[UILabel alloc] initWithFrame:CGRectMake(XRF(10)  + i * TBWidth / 4.1, CGRectGetMaxY(imgv.frame), TBWidth/4.47, 30)];
        alable.textAlignment = NSTextAlignmentCenter;
        //alable.backgroundColor = [UIColor yellowColor];
        alable.font = [UIFont systemFontOfSize:13];
        imgv.layer.masksToBounds = YES;
        //截取边角的半径
        imgv.layer.cornerRadius =(TBWidth/4.47)/2;
        //设计边框的宽度
        imgv.layer.borderWidth = 2;
        //设计边框的颜色
        imgv.layer.borderColor = [UIColor redColor].CGColor;
        alable.text = model.nickName;
        //imgv.backgroundColor = [UIColor redColor];
        NSURL *url = [NSURL URLWithString:model.cover];
        [imgv sd_setImageWithURL:url];
        [self.scrollView addSubview:imgv];
        [self.scrollView addSubview:alable];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TBWidth, 20)];
    aview.backgroundColor = [UIColor colorWithRed:38/256.0 green:185/256.0 blue:160/256.0 alpha:1];
    UILabel *alabel =[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, 20)];
    alabel.shadowColor = [UIColor blackColor];
    //10.设置音译ing的偏移量    CGSizeMake(1, 1)第一个参数是往x轴方向偏移的单位  第二个参数是往y轴方向的偏移单位
    alabel.shadowOffset = CGSizeMake(1.1, 1.1);
    alabel.text = @"节目推荐";
    [aview addSubview:alabel];
    NSArray *arr = @[@"热门", @"最新"];
    for (NSInteger i = 0; i < 2; i++) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(TBWidth - 150 + i * 75, 0, 70, 20);
        [_button addTarget:self action:@selector(handleupdate:) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitle:arr[i] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        //button.backgroundColor = [UIColor redColor];
        [aview addSubview:_button];
    }
        return aview;
    
}
- (void)handleupdate:(UIButton *)sender{
    if ([sender.currentTitle isEqualToString:@"热门"]) {
        [self getData:self.type update:1];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    }
    if ([sender.currentTitle isEqualToString:@"最新"]) {
        [self getData:self.type update:2];
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datasource.count;
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
   // cell.updateLabel.text = [NSString stringWithFormat:@"更新: %@",dateStr];
    cell.updateLabel.text = @"更新: 最新";
    return cell;
}
- (UIImage *)img{
    if (_img == nil) {
        self.img = [UIImage imageNamed:@"7.00.jpg"];
    }return _img;
    
}

- (void)getData:(NSInteger)type  update:(int)update{
    [GiFHUD dismiss];
    //[GiFHUD show];
    NSString *completeUrl = [NSString stringWithFormat:@"http://36.250.78.74/yyting/snsresource/getRecommendAblumns.action?opType=H&referId=0&size=20&type=%d&needFlag=0&typeId=%ld&token=c-OSIyXjARZpyYxpsrvdPZWQdfZwFL7R-zdukwv7lbY*&q=6866&imei=ODY0MzAxMDI2OTU2Nzk0",update, (long)type];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:completeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *arr = dic[@"list"];
        [self.datasource removeAllObjects];
        for (NSDictionary *tempDic in arr) {
            TBBookDetailModel *Typemodel = [[TBBookDetailModel alloc] initWithDic:tempDic];
            [self.datasource addObject:Typemodel];
            [self.tableView reloadData];
            [GiFHUD dismiss];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [GiFHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请检查网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        NSLog(@"请求网络失败");
    }];
}

- (void)getData1:(NSInteger)type{
    NSString *completeUrl = [NSString stringWithFormat:@"http://36.250.78.77/yyting/snsresource/getRecommendUsers.action?opType=H&referId=0&size=10&type=1&needAlbum=0&needFollow=0&typeId=%ld&token=c-OSIyXjARZpyYxpsrvdPZWQdfZwFL7R-zdukwv7lbY*&q=5746&imei=ODY0MzAxMDI2OTU2Nzk0",(long)type];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [GiFHUD dismiss];
    [GiFHUD show];
    [manager GET:completeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *arr = dic[@"list"];
        [self.Authors removeAllObjects];
        for (NSDictionary *tempDic in arr) {
            TBBookDetailModel *Typemodel = [[TBBookDetailModel alloc] initWithDic:tempDic];
            [self.Authors addObject:Typemodel];
            [GiFHUD dismiss];
            [self setUptitleLabel];

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [GiFHUD dismiss];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请检查网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        NSLog(@"请求网络失败");
    }];
}

- (NSMutableArray *)Authors{
    if (_Authors == nil) {
        self.Authors = [NSMutableArray array];
    }return _Authors;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TBBookDetailModel *model = self.datasource[indexPath.row];
    TBZBDTDetailController *detailViewController = [TBZBDTDetailController alloc];
    detailViewController.ID = model.ID;
    detailViewController.sections = [model.sections stringValue];
    [self.navigationController pushViewController:detailViewController animated:YES];
    self.navigationController.navigationBar.hidden = NO;
}

@end
