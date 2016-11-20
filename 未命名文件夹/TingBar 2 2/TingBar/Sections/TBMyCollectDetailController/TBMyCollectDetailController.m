//
//  TBMyCollectDetailController.m
//  TingBar
//
//  Created by lanouhn on 15/8/24.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBMyCollectDetailController.h"
#import "TBsingleton.h"
#import "DataBaseHelper.h"
#import "TBTypeResourceListCell1.h"
#import "TBBookDetailController.h"
#import "ViewController.h"
#import "TBMacros.h"
@interface TBMyCollectDetailController ()
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong)NSMutableArray *linkArr;
@property (nonatomic,strong)DataBaseHelper *helper;
@property (nonatomic, strong)UIImage *deleteImg;

@end

@implementation TBMyCollectDetailController
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    }return _dataSource;
}
- (NSMutableArray *)linkArr{
    if (_linkArr == nil) {
        self.linkArr = [NSMutableArray array];
    }return _linkArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tableView.frame = CGRectMake(0, 64,TBWidth, TBHight);

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"我的收藏";
    [self setUpAdd];
    [self.tableView registerNib:[UINib nibWithNibName:@"TBTypeResourceListCell1" bundle:nil] forCellReuseIdentifier:@"cellTopic"];
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}
- (void)setUpAdd{
    self.helper = [DataBaseHelper shareDataBaseHelper];
    self.dataSource = [self.helper queryContact];

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
   
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *aview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TBWidth, 50)];
//    aview.backgroundColor = [UIColor whiteColor];
//    UILabel *alabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, TBWidth - 50, 50)];
//    alabel.text = @"点击删除全部";
//    UIButton *abutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [abutton setBackgroundImage:self.deleteImg forState:UIControlStateNormal];
//    abutton.frame = CGRectMake(0, 15, 25, 25);
//    [aview addSubview:alabel];
//    [aview addSubview:abutton];
//    return aview;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 50;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBTypeResourceListCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTopic" forIndexPath:indexPath];
    TBBookmodel *model = self.dataSource[indexPath.row];
    cell.bookName.text = model.bookName;
    cell.announcer.text = [NSString stringWithFormat:@"播音: %@",model.announcer];
    cell.sectionsLabel.text = nil;
    cell.hotLabel.text = nil;
    
    return cell;
}
- (UIImage *)deleteImg{
    if (_deleteImg == nil) {
        self.deleteImg = [UIImage imageNamed:@"delete_icon.png"];
    }return _deleteImg;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        TBBookmodel *model = self.dataSource[indexPath.row];
        [self.helper deleteContact:model];
        [self.dataSource removeObject:model];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
                
        // Delete the row from the data source
       
    } }
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton *buton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [buton setTitle:@"点击清空收藏" forState:UIControlStateNormal];
    
    [buton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    return buton;
}

- (void)delete{
    for (TBBookmodel *model in self.dataSource) {
        [self.helper deleteContact:model];
    }
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
 }
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
//    NSString *string = [TBsingleton sharedSingleton].arrSingle[indexPath.row];
    TBBookmodel *model = self.dataSource[indexPath.row];
    TBBookDetailController *detailViewController = [[TBBookDetailController alloc] init];
    NSLog(@"momomomo%@", model.ids);
    detailViewController.ID = model.ids;
    [self.navigationController pushViewController:detailViewController animated:YES];
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
