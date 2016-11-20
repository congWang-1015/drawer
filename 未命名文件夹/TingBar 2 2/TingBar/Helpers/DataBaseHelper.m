//
//  DataBaseHelper.m
//  FMDB_Share_8.25
//
//  Created by lanouhn on 15/8/24.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DataBaseHelper.h"
#import "TBBookmodel.h"
@interface DataBaseHelper ()
@property (nonatomic,strong)FMDatabase *db;
@property (nonatomic, strong)UIAlertView *alert1;
@end
static DataBaseHelper *DBHelper = nil;
@implementation DataBaseHelper
+ (DataBaseHelper *)shareDataBaseHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DBHelper = [[DataBaseHelper alloc] init];
        //调用创建数据库和表的方法
        [DBHelper createDataBase];
        [DBHelper createTable];
    });
    return DBHelper;
}
//初始化数据原数组
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
//创建数据库
- (void)createDataBase
{
    //获取数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //拼接路径
    NSString *dataBaseFilePath = [doc stringByAppendingPathComponent:@"model1"];
    //创建数据库
    FMDatabase *db = [FMDatabase databaseWithPath:dataBaseFilePath];
    self.db = db;
}
//创建表
- (void)createTable
{
    if ([self.db open]) {
    //创建表
        BOOL result = [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_model (id integer PRIMARY KEY AUTOINCREMENT, bookName text NOT NULL, announcer text NOT NULL,ids text NOT NULL);"];
        if (result) {
            NSLog(@"创建表成功");
        }else
        {
            NSLog(@"创建表失败");
        }
    }else
    {
        NSLog(@"数据库打开失败");
    }
    [self.db close];
}

//插入数据
- (void)insertContact:(TBBookmodel *)model
{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"INSERT INTO t_model (bookName, announcer, ids) VALUES (?,?,?);",model.bookName,model.announcer, model.ids];
        if (result) {
            [self setUpalerttitle:@"已收藏至我的收藏"];
        }
        else
        {
           [self setUpalerttitle:@"收藏失败,请检查网络"];
        }
    }
    [self.db close];
    
}
//删除数据
- (void)deleteContact:(TBBookDetailModel *)model
{
    
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"delete from t_model where announcer = ?",model.announcer];
        if (result) {
            NSLog(@"删除成功");
        }
        else
        {
            NSLog(@"删除失败");
        }
    }
    [self.db close];
    
}
//查询数据
- (NSMutableArray *)queryContact
{
     NSMutableArray *arr = [NSMutableArray array];
    if ([self.db open]) {
        FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_model"];
       
        while ([resultSet next]) {
          int ID  = [resultSet intForColumn:@"id"];
           NSString *bookName = [resultSet stringForColumn:@"bookName"];
            NSString *announcer = [resultSet stringForColumn:@"announcer"];
            NSString *ids = [resultSet stringForColumn:@"ids"];
            TBBookmodel *model1 = [[TBBookmodel alloc] initWithAnnouncer:announcer bookName:bookName ids:ids modelID:ID];
                [arr addObject:model1];
         }
        
    }
   // NSLog(@"%@" ,arr);
    return arr;
}

//提示框
- (void)setUpalerttitle:(NSString *)title{
    self.alert1 = [[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(removeFromView) userInfo:nil repeats:NO];
    [_alert1 show];
}

- (void)removeFromView{
       [self.alert1 dismissWithClickedButtonIndex:0 animated:YES];
}

@end
