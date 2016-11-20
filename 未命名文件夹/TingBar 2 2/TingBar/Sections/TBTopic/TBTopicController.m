//
//  TBTopicController.m
//  TingBar
//
//  Created by lanouhn on 15/8/29.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBTopicController.h"
#import "TBTypeResourceListCell.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "TBBookDetailModel.h"
#import "TBBookDetailController.h"
#import "TBTypeResourceListCell1.h"
#import "GiFHUD.h"
@interface TBTopicController ()
@property (nonatomic, strong)NSMutableArray *dataArr;

@end

@implementation TBTopicController

- (void)viewDidLoad {
    [super viewDidLoad];
    [GiFHUD setGifWithImageName:@"pika.gif"];
    
    self.title = @"精彩专题";
    [self.tableView registerNib:[UINib nibWithNibName:@"TBTypeResourceListCell1" bundle:nil] forCellReuseIdentifier:@"cellTopic"];
    [self getBookData];
    
    
}
- (void)getBookData{
    [GiFHUD dismiss];
    [GiFHUD show];
    NSString *completeUrl = [NSString stringWithFormat:@"http://api.mting.info/yyting/bookclient/ClientGetBookByTopic.action?topicId=%@&pageNum=0&pageSize=500&sort=0&token=c", self.ID];
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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请检查网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
        [alert show];

        [GiFHUD dismiss];
        NSLog(@"请求网络失败");
    }];
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
    TBTypeResourceListCell1 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellTopic" forIndexPath:indexPath];
    cell.bookName.text = model.name;
    cell.announcer.text = [NSString stringWithFormat:@"播音: %@",model.announcer];
    cell.sectionsLabel.text = [NSString stringWithFormat:@"集数: %@",[model.sections stringValue]];
    if ([model.hot integerValue] > 10000) {
        CGFloat a = [model.hot integerValue] / 10000.0;
        cell.hotLabel.text = [NSString stringWithFormat:@"人气: %.2f万",a];
    }else{
        cell.hotLabel.text = [NSString stringWithFormat:@"人气: %@",[model.hot stringValue]];}
   
    cell.accessoryType = UITableViewCellStyleValue1;

        return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TBBookDetailModel *model = self.dataArr[indexPath.row];
    TBBookDetailController *detailVC = [[TBBookDetailController alloc] init];
    detailVC.ID = model.ID;
    [self.navigationController pushViewController:detailVC animated:YES];
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

- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        self.dataArr = [NSMutableArray array];
    }return _dataArr;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [GiFHUD dismiss];
    
}
@end
