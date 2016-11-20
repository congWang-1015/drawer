//
//  HistoryController.m
//  TingBar
//
//  Created by lanouhn on 15/9/6.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "HistoryController.h"
#import "AppDelegate.h"
#import "TBTypeResourceListCell1.h"
#import "HistoryModel.h"
@interface HistoryController ()
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (strong, nonatomic) AppDelegate *myAppDelegate;
@end

@implementation HistoryController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.myAppDelegate = [UIApplication sharedApplication].delegate;
    self.dataSource = [NSMutableArray array];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"HistoryModel"];
    NSError *error = nil;
    NSArray *resultArray = [self.myAppDelegate.managedObjectContext executeFetchRequest:request error:&error];
    //
    [self.dataSource addObjectsFromArray:resultArray];
[self.tableView registerNib:[UINib nibWithNibName:@"TBTypeResourceListCell1" bundle:nil] forCellReuseIdentifier:@"cellTopic"];
    self.title = @"历史记录";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBTypeResourceListCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTopic" forIndexPath:indexPath];
    HistoryModel *model = self.dataSource[indexPath.row];
    cell.bookName.text = [NSString stringWithFormat:@"已搜索: %@", model.name];
    cell.hotLabel.text = nil;
    cell.announcer.text = nil;
    cell.sectionsLabel.text = nil;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        HistoryModel *clothe = self.dataSource[indexPath.row];
        //在关于布局dataSource中, 删除数据
        [self.dataSource removeObject:clothe];
        //要在真实的文件中删除 (*coreData中的删除)
        [self.myAppDelegate.managedObjectContext deleteObject:clothe];
        //对数据管理器进行改变, 保存到真实的文件当中
        [self.myAppDelegate saveContext];
        //2.再删除单元格
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton *buton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    [buton setTitle:@"点击清空历史记录" forState:UIControlStateNormal];
   
    [buton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    return buton;
 }
- (void)delete{
    for (HistoryModel *model in self.dataSource) {
        [self.myAppDelegate.managedObjectContext deleteObject:model];
    }
    [self.dataSource removeAllObjects];
     //要在真实的文件中删除 (*coreData中的删除)
        //对数据管理器进行改变, 保存到真实的文件当中
    [self.myAppDelegate saveContext];
    //2.再删除单元格
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
