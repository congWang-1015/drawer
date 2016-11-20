//
//  TBsingleton.h
//  TingBar
//
//  Created by lanouhn on 15/9/1.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBBookDetailModel.h"
#import "AFNetworking.h"
#import "SectionsController.h"
#import "AFSoundManager.h"

@protocol TBsingleton <NSObject>

- (void)configurePlayer;

- (void)configureLabel;
@end


@interface TBsingleton : NSObject
+ (TBsingleton *)sharedSingleton;//单例  以shared等 + 类名
//

//@property (nonatomic,retain)VideoViewController *video;
@property (nonatomic,retain)AFHTTPRequestOperationManager *manager;
@property (nonatomic, retain)SectionsController *sectionsvc;
//


@property (nonatomic, strong)TBBookDetailModel *model;//保存第一个界面里输入框的内容
@property (nonatomic, retain)NSString *link;
@property (nonatomic, retain)NSMutableArray *arrSingle;

//

@property (nonatomic, strong)NSMutableArray *listArr;
@property (nonatomic, strong) AFSoundPlayback *playback;
@property (nonatomic, strong) AFSoundQueue *queue;
@property (nonatomic, strong)UIWindow *window;
@property (nonatomic, strong) NSMutableArray *items;

//@property (nonatomic, strong)UIImage *playIMG;
@property  (nonatomic, strong)UIImage *stopIMG;
@property (nonatomic, strong)UILabel *currentName;
@property (nonatomic, strong)UIProgressView *progress;
@property (nonatomic, strong)UIButton *playBt;
@property (nonatomic, strong)UILabel *totalLabel;
@property (nonatomic, strong)UILabel *littleLabel;
@property (nonatomic, assign)NSInteger page;


@property (nonatomic, assign)CGFloat total;
@property (nonatomic, assign)CGFloat current;
@property (nonatomic, assign) id<TBsingleton>delegate;
+ (void)setUpPlayurl:(NSString *)url;




@end
