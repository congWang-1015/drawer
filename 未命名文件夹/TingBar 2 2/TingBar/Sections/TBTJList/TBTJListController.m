//
//  TBTJListController.m
//  TingBar
//
//  Created by lanouhn on 15/8/28.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBTJListController.h"
#import "TBMacros.h"
#import "TBTypeResourceListCell.h"
#import "UIImageView+WebCache.h"
#import "TBBookDetailController.h"
@interface TBTJListController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIImage *img;
@property (nonatomic, strong)UIImage *stateImg;
@property (nonatomic, strong)UIImage *stateImg1;
@end

@implementation TBTJListController
- (UIImage *)img{
    if (_img == nil) {
        self.img = [UIImage imageNamed:@"7.00.jpg"];
    }return _img;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.topicName;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setUpTableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"TBTypeResourceListCell" bundle:nil] forCellReuseIdentifier:@"cellssss"];
    // Do any additional setup after loading the view.
}

- (void)setUpTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, TBWidth, TBHight - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.model.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TBBookDetailModel *model = self.model.dataSource[indexPath.row];
    TBTypeResourceListCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellssss" forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:model.cover];
    [cell.bookImgV sd_setImageWithURL:url placeholderImage:self.img];
    cell.bookName.text = model.bookName;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TBBookDetailModel *model = self.model.dataSource[indexPath.row];
    TBBookDetailController *detailVC = [[TBBookDetailController alloc] init];
    detailVC.ID = model.bookID;
    [self.navigationController pushViewController:detailVC animated:YES];
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
