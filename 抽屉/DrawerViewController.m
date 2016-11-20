//
//  HouDrawerViewController.m
//  抽屉
//
//  Created by 王聪 on 15/9/16.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import "DrawerViewController.h"

@interface DrawerViewController ()

@end

@implementation DrawerViewController

- (id)initWithCenterViewController:(UIViewController *)centerVC leftViewController:(UIViewController *)leftVC
{
    
    if (self = [super init]) {
        
        self.centerVC = centerVC;
        self.leftVC = leftVC;
        //  给抽屉控制器添加子控制器，可以添加多个子控制器，有什么作用啊？
        //  首先大家看这一种场景，假如我们在一个控制器中添加两个tableView，这样的话，我们是不是让当前控制器都成为这两个tableView的代理，这样的话，得需要在tableView的代理方法或dataSource方法中做详细的判断，判断当前是tableView1的方法还是tableView2的方法，是不是很麻烦？我们用父子控制器就可以很轻松的解决这个问题，我们创建两个继承与tableViewController的新类，我们是不是要在该类中实现每个类的代理方法，这样我们在控制器中添加view的时候呢，我们添加tableViewController的view，而且前提呢，把这两个tableViewController设置成控制器的子控制器，这样表现视图展示都一样，而且各自的tableView的代理方法都在各自的类中执行，是不是就很轻松地分开了！
        //  综上所诉，父子控制器，可以方便父控制器对子控制器的控制，而且可以很方便的实现分层
        [self addChildViewController:_leftVC];
        [self addChildViewController:_centerVC];
    }
    return self;
    
}

- (void)showLeftMenuController
{
    
    
    CGRect centerRect = self.centerVC.view.frame;
    centerRect.origin = CGPointMake(200, 0);
    
    CGRect leftRect = self.centerVC.view.frame;
    leftRect.origin = CGPointMake(0, 0);
    
    __weak typeof(self) mySelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        mySelf.leftVC.view.frame = leftRect;
        mySelf.centerVC.view.frame = centerRect;
    }];
}

- (void)closeLeftMenuController
{
    CGRect rect = self.centerVC.view.frame;
    rect.origin = CGPointMake(0, 0);
    
    CGRect leftRect = self.centerVC.view.frame;
    leftRect.origin = CGPointMake(-200, 0);
    __weak typeof(self) mySelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        
        mySelf.centerVC.view.frame = rect;
        mySelf.leftVC.view.frame = leftRect;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.leftVC.view.frame = CGRectMake(-200, 0, 200, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:self.leftVC.view];
    [self.view addSubview:self.centerVC.view];
    
    
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
