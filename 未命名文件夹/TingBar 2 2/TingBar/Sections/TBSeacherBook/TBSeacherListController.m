//
//  TBSeacherListController.m
//  TingBar
//
//  Created by lanouhn on 15/8/29.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBSeacherListController.h"
#import "TBTypeResourceListCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "TBBookDetailModel.h"
#import "TBBookDetailController.h"
#import "GiFHUD.h"
@interface TBSeacherListController ()<UIAlertViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UIImage *img;
@property (nonatomic, strong)UIAlertView *netAlert;
@property (nonatomic, strong)UIImage *stateImg;
@property (nonatomic, strong)UIImage *stateImg1;
@end

@implementation TBSeacherListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.name;
    [GiFHUD setGifWithImageName:@"pika.gif"];
   
      [self.tableView registerNib:[UINib nibWithNibName:@"TBTypeResourceListCell" bundle:nil] forCellReuseIdentifier:@"cellssss"];
    [self getBookData];
    
  
}
- (void)getBookData{
    [GiFHUD dismiss];
     [GiFHUD show];
    NSString *strB = [self.name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *completeUrl = [NSString stringWithFormat:@"http://api.mting.info/yyting/bookclient/BookSearch.action?keyWord=%@&pageNum=1&pageSize=25&type=0&token=c", strB];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:completeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *arr = dic[@"list"];
        for (NSDictionary *tempDic in arr) {
            TBBookDetailModel *TBbookModel = [[TBBookDetailModel alloc] initWithDic:tempDic];
            [self.dataArr addObject:TBbookModel];
            
        }
        [GiFHUD dismiss];
        [self.tableView reloadData];
        if ( self.dataArr.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无该关键词相关的书籍" message:@"请重新输入" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求网络失败");
        [GiFHUD dismiss];
        [self setUpaLert];
    }];
}
- (void)removeFromView{
    [self.netAlert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)setUpaLert{
    self.netAlert = [[UIAlertView alloc] initWithTitle:@"请检查网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(removeFromView) userInfo:nil repeats:NO];
    [_netAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 120;
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
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
        self.stateImg1 = [UIImage imageNamed:@"finish.png"];
    }return _stateImg1;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     TBBookDetailModel *model = self.dataArr[indexPath.row];
    TBBookDetailController *detailVC = [[TBBookDetailController alloc] init];
    detailVC.ID = model.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [GiFHUD dismiss];
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
-(UIImage *)img{
    if (_img == nil) {
        self.img = [UIImage imageNamed:@"7.00.jpg"];
    }return _img;
}

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        self.dataArr = [NSMutableArray array];
    }return _dataArr;
    
}

@end
