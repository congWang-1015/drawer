//
//  HomePageViewController.m
//  抽屉
//
//  Created by王聪 on 15/9/16.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import "HomePageViewController.h"
#import "AppDelegate.h"
#import "DrawerViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(leftAction:)];
    self.navigationItem.leftBarButtonItem = left;
    
    self.wordLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    _wordLabel.text = @"王聪0";
    [self.view addSubview:_wordLabel];
    
    
}
- (void)leftAction:(UIBarButtonItem *)left
{
    id<UIApplicationDelegate>myApp = [UIApplication sharedApplication].delegate;
    DrawerViewController *hou = (DrawerViewController *)myApp.window.rootViewController;
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstTap"]) {
        [hou showLeftMenuController];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstTap"];
        
    }else{
        [hou closeLeftMenuController];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirstTap"];
    }
    
    
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
