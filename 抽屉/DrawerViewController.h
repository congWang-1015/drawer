//
//  DrawerViewController.h
//  抽屉
//
//  Created by 王聪 on 15/9/16.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerViewController : UIViewController

//  中间显示内容的控制器
@property (nonatomic, strong)UIViewController *centerVC;
//  左面显示菜单的控制器
@property (nonatomic, strong)UIViewController *leftVC;

//  声明的一个初始化方法，在该方法中完成left和center的指代
- (id)initWithCenterViewController:(UIViewController *)centerVC leftViewController:(UIViewController *)leftVC;
//  显示抽屉的方法
- (void)showLeftMenuController;
//  关闭抽屉的方法
- (void)closeLeftMenuController;
@end
