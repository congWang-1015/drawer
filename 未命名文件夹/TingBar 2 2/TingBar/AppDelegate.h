//
//  AppDelegate.h
//  TingBar
//
//  Created by lanouhn on 15/8/24.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@protocol AppDelegateDelegate <NSObject>

- (void)method;

- (void)downWin;
- (void)getMainData;
- (void)getCacheData;

@end
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@property (assign,nonatomic) id<AppDelegateDelegate> delegate;
- (void)recoverDwon;
@end

