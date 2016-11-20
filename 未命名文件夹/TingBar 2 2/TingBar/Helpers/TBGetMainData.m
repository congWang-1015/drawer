//
//  TBGetMainData.m
//  TingBar
//
//  Created by lanouhn on 15/8/25.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBGetMainData.h"
#import "NetWorkEngine.h"
#import "UIImageView+WebCache.h"
#import "TBTopImgModel.h"
#import "TBBookDetailModel.h"
#import "GiFHUD.h"
static TBGetMainData *helper = nil;

@implementation TBGetMainData
+ (TBGetMainData *)sharedGetMainData{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[TBGetMainData alloc] init];
        [GiFHUD setGifWithImageName:@"pika.gif"];
    });
    return helper;
}
+ (void)getDetailDatatype:(NSInteger )type withBtype:(NSInteger )Btype{
    [GiFHUD dismiss];
    [GiFHUD show];
    NSString *completeUrl = [NSString stringWithFormat:@"http://api.mting.info/yyting/bookclient/ClientRankingsItemList.action?rankType=%ld&rangeType=%ld&pageNum=1&pageSize=25&token=c",(long)type, (long)Btype];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:completeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *arr = dic[@"list"];
        [helper.PHListArr removeAllObjects];
        for (NSDictionary *tempDic in arr) {
            TBBookDetailModel *Typemodel = [[TBBookDetailModel alloc] initWithDic:tempDic];
            [helper.PHListArr addObject:Typemodel];
            [GiFHUD dismiss];
           
        }
        if (helper.PHListArr.count != 0) {
            if (helper.delegate != nil && [helper.delegate respondsToSelector:@selector(tableViewReloadData) ]&& helper.PHListArr.count != 0) {
                 [GiFHUD dismiss];
                [helper.delegate tableViewReloadData];
            }

        }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [GiFHUD dismiss];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请检查网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
        NSLog(@"请求网络失败");
    }];
}

- (NSMutableArray *)PHListArr{
    if (_PHListArr == nil) {
        self.PHListArr = [NSMutableArray array];
    }return _PHListArr;
}













@end
