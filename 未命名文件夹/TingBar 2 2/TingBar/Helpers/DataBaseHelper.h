//
//  DataBaseHelper.h
//  FMDB_Share_8.25
//
//  Created by lanouhn on 15/8/24.
//  Copyright (c) 2015年 段利会. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "TBBookDetailModel.h"
#import "TBBookmodel.h"
@interface DataBaseHelper : NSObject
@property (nonatomic,strong)NSMutableArray *dataSource;
+ (DataBaseHelper *)shareDataBaseHelper;
- (void)insertContact:(TBBookmodel *)model;
- (void)deleteContact:(TBBookmodel *)model;
- (void)updateContact:(TBBookmodel *)model;
- (NSMutableArray *)queryContact;
@end
