//
//  TBAudioDownLoadController.m
//  TingBar
//
//  Created by lanouhn on 15/9/2.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBAudioDownLoadController.h"
#import "TBAudioCell.h"
#import "TBDownModel.h"
#import "SectionsController.h"
#import "TBsingleton.h"
#import "AppDelegate.h"
@interface TBAudioDownLoadController ()< SectionsDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, AppDelegateDelegate>
@property (nonatomic, strong)UIAlertView *alert;
//
@property (retain,nonatomic)NSArray *arrData;
@property (retain,nonatomic)NSMutableArray *arrCell;
//
@end

@implementation TBAudioDownLoadController
-(NSMutableArray *)arrCell{
    if (_arrCell == nil) {
        self.arrCell = [NSMutableArray array];
    }
    return _arrCell;
}

-(NSArray *)arrData{
    if (_arrData == nil) {
        self.arrData = [NSArray array];
    }
    return _arrData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self readNSUserDefaults];
     self.tableView.tag = 300;
    //[self setUpaLert];
    self.title = @"下载中";
    NSArray *s = [[NSUserDefaults standardUserDefaults] arrayForKey:@"downName"];
    //NSLog(@"--------------------%ld",s.count);
   // [AudioDownLoadHelper sharedHelper].delegate = self;
     [self.tableView registerNib:[UINib nibWithNibName:@"TBAudioCell" bundle:nil] forCellReuseIdentifier:@"audio"];
    [TBsingleton sharedSingleton].sectionsvc.delegate = self;
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    delegate.delegate = self;
    
}


- (void)method{
    for (int i = 0; i < self.arrCell.count; i++) {
        TBAudioCell *cell = self.arrCell[i];
        cell.progress.progress = [[[NSUserDefaults standardUserDefaults] objectForKey:self.arrData[i]] floatValue];
    }
}
-(void)readNSUserDefaults
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSArray *myArray = [userDefaultes arrayForKey:@"downName"];
    NSLog(@"%ld", myArray.count);
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
    NSLog(@"%ld", self.arrData.count);
    return self.arrData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TBAudioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"audio" forIndexPath:indexPath];
    cell.nameLabel.text = self.arrData[indexPath.row];
    [self.arrCell addObject:cell];
    cell.progress.progress = [[[NSUserDefaults standardUserDefaults] objectForKey:self.arrData[indexPath.row]] floatValue];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AFHTTPRequestOperation *op = [TBsingleton sharedSingleton].manager.operationQueue.operations[indexPath.row];
    [op cancel];
    op = nil;
    [self remove];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"该任务已经移除" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
   
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"点击,移除任务";
}

- (void)remove{
    UITableView *tab = (UITableView *)[self.view viewWithTag:300];
    [self.arrCell removeAllObjects];
    [self readNSUserDefaults];
    [tab reloadData];

}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    switch (buttonIndex) {
//        case 0:
//        {
//            UITableView *tab = (UITableView *)[self.view viewWithTag:300];
//            [self.arrCell removeAllObjects];
//            [self readNSUserDefaults];
//            [tab reloadData];
//        }
//            break;
//        case 1:
//            break;
//            
//        default:
//            break;
//    }
//    
//}
//
- (void)downWin{
    UITableView *tab = (UITableView *)[self.view viewWithTag:300];
    [self.arrCell removeAllObjects];
    [self readNSUserDefaults];
    [tab reloadData];
}

- (unsigned long long)fileSizeAtPath:(NSString *)fileAbsolutePath {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new];
    if ([fileManager fileExistsAtPath:fileAbsolutePath]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:fileAbsolutePath error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
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
