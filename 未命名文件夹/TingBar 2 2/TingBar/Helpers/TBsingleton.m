//
//  TBsingleton.m
//  TingBar
//
//  Created by lanouhn on 15/9/1.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBsingleton.h"
#import "AFSoundManager.h"
#import "GiFHUD.h"
static TBsingleton *_singleton = nil;
@implementation TBsingleton
+ (TBsingleton *)sharedSingleton{
    //内部只创建一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton = [[TBsingleton alloc] init];
    });
    return _singleton;
}

//+ (void)setUpPlayurl:(NSString *)url{
//     AFSoundItem *item7 = [[AFSoundItem alloc] initWithStreamingURL:[NSURL URLWithString:url]];
//    _singleton.items = [NSMutableArray arrayWithObjects:item7 ,nil];
//   _singleton.queue = [[AFSoundQueue alloc] initWithItems:_singleton.items];
//    [_singleton.queue playCurrentItem];
//    [_singleton.queue listenFeedbackUpdatesWithBlock:^(AFSoundItem *item) {
//        if ((long)item.duration == (long)item.timePlayed) {
//             [_singleton.queue pause];
//          if (_singleton.delegate && [_singleton.delegate respondsToSelector:@selector(configurePlayer)]) {
//            [_singleton.delegate configurePlayer];
//        }
//        }
//        if (_singleton.delegate && [_singleton.delegate respondsToSelector:@selector(configureLabel)]) {
//            [_singleton.delegate configureLabel];
//        }
//     _singleton.total = (long)item.duration / 60;
//    _singleton.current = (long)item.timePlayed / 60;
//        NSLog(@"%.2f", _singleton.current/_singleton.total);
//    } andFinishedBlock:^(AFSoundItem *nextItem) {
//        
//        
//    }];
//   // [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//}
//


@end
