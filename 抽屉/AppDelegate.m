//
//  AppDelegate.m
//  抽屉
//
//  Created by 王聪 on 15/9/16.
//  Copyright (c) 2015年 王聪. All rights reserved.
//

#import "AppDelegate.h"
#import "DrawerViewController.h"
#import "HomePageViewController.h"
#import "LeftMenuTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    HomePageViewController *center = [[HomePageViewController alloc] init];
    center.view.backgroundColor = [UIColor redColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:center];
    LeftMenuTableViewController *left = [[LeftMenuTableViewController alloc] initWithStyle:UITableViewStylePlain];
    
    //  封装的DrawerViewController抽屉，其实抽屉视图，不难，假如你在视图上之后中间视图和左抽屉，其实现在window上有三个控制器，有一个总的抽屉来控制left和中间显示控制器的页面的偏移---现在我就对这个抽屉控制器进行了封装，它包含一个centerVC和leftVC
    
    //  接下来大家就好好看我的DrawerViewController的实现
    DrawerViewController *drawer = [[DrawerViewController alloc] initWithCenterViewController:nav leftViewController:left];
    self.window.rootViewController = drawer;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
