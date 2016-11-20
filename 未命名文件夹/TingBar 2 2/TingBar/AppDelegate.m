//
//  AppDelegate.m
//  TingBar
//
//  Created by lanouhn on 15/8/24.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "UMSocial.h"
#import "TBsingleton.h"
#import "GiFHUD.h"
@interface AppDelegate ()
@property (nonatomic, strong)UIAlertView *alert;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UMSocialData setAppKey:@"55e433f267e58e5e1000130f"];
    //  利用AFN判断网络
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    //根据不同的网络状态改变去做相应处理
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [defaults setObject:[NSNumber numberWithInteger:status]forKey:@"network"];
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"WAN");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(getMainData)]) {
                    [self.delegate getMainData];
                }
                break;
            case AFNetworkReachabilityStatusNotReachable:
                
                [GiFHUD dismiss];
                [self setUpaLert];
                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(getMainData)]) {
                   // [self.delegate getCacheData];
                }

                break;
                
            default:
                break;
        }
    }];
    
    //开始监控
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // Override point for customization after application launch.
    
    
    
    //
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [TBsingleton sharedSingleton].manager = manager;
    //[self recoverDwon];
    
    
    
    
    
    
    return YES;
}
/*
- (void)recoverDwon{
    NSArray *arr = [[NSUserDefaults standardUserDefaults] arrayForKey:@"downVid"];
    if (arr.count == 0) {
        return;
    }
    NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:@"downName"];
    for (int i = 0; i < arr.count; i++) {
        unsigned long long  downloadedBytes =0;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *arr = [userDefaults arrayForKey:@"downVid"];
       // NSString *url = [NSString stringWithFormat:DOWN_URL,arr[i],[userDefaults objectForKey:@"downVideo"]];
        NSURLRequest * request = [NSURLRequest  requestWithURL:[NSURL URLWithString:]];
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString * tempFilePath = [cachePath stringByAppendingPathComponent:[arr[i] stringByAppendingString:@".temp"]];
        NSString *moviePath = [cachePath stringByAppendingPathComponent:[arr[i] stringByAppendingString:@".mp4"]];
        
        NSString * txtFilePath = [cachePath stringByAppendingPathComponent:[arr[i] stringByAppendingString:@".txt"]];
        downloadedBytes = [self fileSizeAtPath:tempFilePath];
        NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
        NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
        
        [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
        request = mutableURLRequest;
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request] ;
        operation.outputStream = [[NSOutputStream alloc] initToFileAtPath:tempFilePath append:YES] ;
        __block NSString *name = array[i];
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            NSString * progress = [NSString stringWithFormat:@"%.3f",((float)totalBytesRead + downloadedBytes) / (totalBytesExpectedToRead + downloadedBytes)];
            [progress writeToFile:txtFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            [userDefaults setObject:progress forKey:name];
            [userDefaults synchronize];
            if (self.delegate && [self.delegate respondsToSelector:@selector(method)]) {
                [self.delegate method];
            }
        }];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *arr1 = [userDefaults arrayForKey:@"downWIN"];
            NSMutableArray *array1 = [NSMutableArray arrayWithArray:arr1];
            [array1 addObject:array[i]];
            NSArray *array3 = [NSArray arrayWithArray:array1];
            [userDefaults setObject:array3 forKey:@"downWIN"];
            NSArray *arr4 = [userDefaults arrayForKey:@"vid"];
            NSMutableArray *array4 = [NSMutableArray arrayWithArray:arr4];
            [array4 addObject:arr[i]];
            NSArray *arr5 = [NSArray arrayWithArray:array4];
            [userDefaults setObject:arr5 forKey:@"vid"];
            NSMutableArray *array10 = [NSMutableArray arrayWithArray:[userDefaults arrayForKey:@"downName"]];
            [array10 removeObject:name];
            NSArray *array = [NSArray arrayWithArray:array10];
            [userDefaults setObject:array forKey:@"downName"];
            [userDefaults removeObjectForKey:name];
            NSArray *arra3 = [userDefaults arrayForKey:@"downVid"];
            NSMutableArray *arra4 = [NSMutableArray arrayWithArray:arra3];
            [arra4 removeObject:arr[i]];
            NSArray *arra5 = [NSArray arrayWithArray:arra4];
            [userDefaults setObject:arra5 forKey:@"downVid"];
            [userDefaults synchronize];
            NSFileManager *  fileManager =[NSFileManager defaultManager];
            [fileManager moveItemAtPath:tempFilePath toPath:moviePath error:nil];//把下载完成的文件转移到保存的路径
            [fileManager removeItemAtPath:txtFilePath error:nil];//删除保存进度的txt文档
            if (self.delegate && [self.delegate respondsToSelector:@selector(downWin)]) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"下载完成" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
                [self.delegate downWin];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSArray *myArray = [userDefaults arrayForKey:@"downName"];
            NSMutableArray *searTXT = [NSMutableArray arrayWithArray:myArray];
            [searTXT removeObject:array[i]];
            [userDefaults removeObjectForKey:array[i]];
            NSArray *array = [NSArray arrayWithArray:searTXT];
            [userDefaults setObject:array forKey:@"downName"];
            NSArray *arra3 = [userDefaults arrayForKey:@"downVid"];
            NSMutableArray *arra4 = [NSMutableArray arrayWithArray:arra3];
            [arra4 removeObject:arr[i]];
            NSArray *arra5 = [NSArray arrayWithArray:arra4];
            [userDefaults setObject:arra5 forKey:@"downVid"];
            [userDefaults synchronize];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"下载失败" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
           
        }];
        [[TBsingleton sharedSingleton].manager.operationQueue addOperation:operation];
    }
    
}
*/
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

- (void)removeFromView{
    [self.alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)setUpaLert{
    self.alert = [[UIAlertView alloc] initWithTitle:@"请检查网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(removeFromView) userInfo:nil repeats:NO];
    [_alert show];
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.lanou.cong.TingBar" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TingBar" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TingBar.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
