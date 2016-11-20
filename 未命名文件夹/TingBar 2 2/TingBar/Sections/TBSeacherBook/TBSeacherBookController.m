//
//  TBSeacherBookController.m
//  TingBar
//
//  Created by lanouhn on 15/8/27.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBSeacherBookController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "TBBookDetailModel.h"
#import "TBMacros.h"
#import "TBTypeResourceListCell.h"
#import "TBBookDetailController.h"
#import "TBSeacherListController.h"
#import "HistoryModel.h"
#import "AppDelegate.h"
#import "HistoryController.h"
@interface TBSeacherBookController ()<UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) AppDelegate *myAppDelegate;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UIImage *img;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIButton *button;
//@property (weak, nonatomic) IBOutlet UILabel *GCDLB;
//@property (weak, nonatomic) IBOutlet UILabel *DPCQLB;
//@property (weak, nonatomic) IBOutlet UILabel *FRXXLB;
//
//@property (weak, nonatomic) IBOutlet UILabel *XNLB;
//
//@property (weak, nonatomic) IBOutlet UILabel *GDGLB;
//
//@property (weak, nonatomic) IBOutlet UILabel *MCNXSLB;
//@property (weak, nonatomic) IBOutlet UILabel *SGYY;
//@property (weak, nonatomic) IBOutlet UILabel *HLM;
@property (weak, nonatomic) IBOutlet UIButton *SGYY;
@property (weak, nonatomic) IBOutlet UIButton *HLM;
//
@property (weak, nonatomic) IBOutlet UIButton *GCD;
@property (weak, nonatomic) IBOutlet UIButton *DPCQ;
@property (weak, nonatomic) IBOutlet UIButton *FRXX;
@property (weak, nonatomic) IBOutlet UIButton *XN;
@property (weak, nonatomic) IBOutlet UIButton *GDG;
@property (weak, nonatomic) IBOutlet UIButton *MCNXS;
@property (weak, nonatomic) IBOutlet UIButton *hisBt;

@end

@implementation TBSeacherBookController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.seachTF.delegate = self;
    self.title = @"搜书";
    self.myAppDelegate = [UIApplication sharedApplication].delegate;

}

- (IBAction)seachAction:(UIButton *)sender {
    [self.seachTF resignFirstResponder];
    if (self.seachTF.text == nil || [self.seachTF.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"输入关键字为空" message:@"请重新输入" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];

        return;
    }
    else{
        TBSeacherListController *listVC = [[TBSeacherListController alloc] init];
        listVC.name = self.seachTF.text;
        [self.navigationController pushViewController:listVC animated:YES];
        NSEntityDescription *description = [NSEntityDescription entityForName:@"HistoryModel" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
        //创建模型对象
        HistoryModel *his = [[HistoryModel alloc] initWithEntity:description insertIntoManagedObjectContext:self.myAppDelegate.managedObjectContext];
        his.name = self.seachTF.text;
        [self.myAppDelegate saveContext];
    }
}

- (IBAction)GCDAC:(id)sender {
    UIButton *abutton = (UIButton *)sender;
    TBSeacherListController *listVC = [[TBSeacherListController alloc] init];;
    listVC.name = abutton.currentTitle;
    [self.navigationController pushViewController:listVC animated:YES];
}

- (IBAction)HISAction:(id)sender {
    HistoryController *hisVC = [[HistoryController alloc] init];
    [self.navigationController pushViewController:hisVC animated:YES];
    
    
}
- (IBAction)FRXX:(UIButton *)sender {
    TBSeacherListController *listVC = [[TBSeacherListController alloc] init];;
    listVC.name = sender.currentTitle;
    [self.navigationController pushViewController:listVC animated:YES];
    
}

- (IBAction)DPCQ:(id)sender {
    UIButton *abutton = (UIButton *)sender;
    TBSeacherListController *listVC = [[TBSeacherListController alloc] init];;
    listVC.name = abutton.currentTitle;
    [self.navigationController pushViewController:listVC animated:YES];

}

- (IBAction)XN:(UIButton *)sender {
    TBSeacherListController *listVC = [[TBSeacherListController alloc] init];;
    listVC.name = sender.currentTitle;
    [self.navigationController pushViewController:listVC animated:YES];
}




- (IBAction)GDG:(id)sender {
    UIButton *abutton = (UIButton *)sender;
    TBSeacherListController *listVC = [[TBSeacherListController alloc] init];;
    listVC.name = abutton.currentTitle;
    [self.navigationController pushViewController:listVC animated:YES];

}

- (IBAction)MCNXS:(id)sender {
    UIButton *abutton = (UIButton *)sender;
    TBSeacherListController *listVC = [[TBSeacherListController alloc] init];;
    listVC.name = abutton.currentTitle;
    [self.navigationController pushViewController:listVC animated:YES];

}

- (IBAction)SGYY:(id)sender {
    UIButton *abutton = (UIButton *)sender;
    TBSeacherListController *listVC = [[TBSeacherListController alloc] init];;
    listVC.name = abutton.currentTitle;
    [self.navigationController pushViewController:listVC animated:YES];

}

- (IBAction)HLM:(id)sender {
    UIButton *abutton = (UIButton *)sender;
    TBSeacherListController *listVC = [[TBSeacherListController alloc] init];;
    listVC.name = abutton.currentTitle;
    [self.navigationController pushViewController:listVC animated:YES];

}







-(void)handlePushSeacher:(UITapGestureRecognizer *)sender{
     TBSeacherListController *listVC = [[TBSeacherListController alloc] initWithNibName:@"TBSeacherListController" bundle:nil];
    UILabel *lable= (UILabel *)sender.view;
    listVC.name = lable.text;
    [self.navigationController pushViewController:listVC animated:YES];
}



















//当点击键盘上的return时, 就会里立即触发此方法 (用于回收键盘)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(UIImage *)img{
    if (_img == nil) {
        self.img = [UIImage imageNamed:@"7.00.png"];
    }return _img;
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
