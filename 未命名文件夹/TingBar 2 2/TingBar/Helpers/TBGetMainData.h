//
//  TBGetMainData.h
//  TingBar
//
//  Created by lanouhn on 15/8/25.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "ViewController.h"
#import "TBBookDetailModel.h"
@protocol tableViewRefresh <NSObject>

- (void)tableViewReloadData;

@end


@interface TBGetMainData : NSObject
@property (nonatomic, strong)AFHTTPRequestOperationManager *manager;
+ (TBGetMainData *)sharedGetMainData;
+ (void)getDetailDatatype:(NSInteger )type
                withBtype:(NSInteger )Btype;
//+ (void)setUpaLert;
@property (nonatomic, strong)TBBookDetailModel *model;
@property (nonatomic, strong)ViewController *ViewVC;
@property (nonatomic, strong)NSMutableArray *PHListArr;
@property (nonatomic, assign)id<tableViewRefresh>delegate;
//@property (nonatomic, strong)UIAlertView *alert;

@end
