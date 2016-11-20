//
//  TBGetPicture.h
//  TingBar
//
//  Created by lanouhn on 15/8/25.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TBGetPicture : NSObject
@property (nonatomic, strong)NSArray *YSSXP;
@property (nonatomic, strong)NSArray *WXMZP;
@property (nonatomic, strong)NSArray *QYXQP;
@property (nonatomic, strong)NSArray *XSPSP;
@property (nonatomic, strong)NSArray *SETDP;
@property (nonatomic, strong)NSArray *WYXXP;
@property (nonatomic, strong)NSArray *YLZYP;
@property (nonatomic, strong)NSArray *RWSKP;
@property (nonatomic, strong)NSArray *SSRDP;
@property (nonatomic, strong)NSArray *SYCJP;
@property (nonatomic, strong)NSArray *JKYSP;
@property (nonatomic, strong)NSArray *SSSHP;
@property (nonatomic, strong)NSArray *ZYJNP;
@property (nonatomic, strong)NSArray *JYSTP;
@property (nonatomic, strong)NSArray *dataPic;


+ (TBGetPicture *)sharedGetPicture;
+ (NSMutableArray *)getPictureCycle;
+ (NSMutableArray *)getPictureType;
+ (CGFloat )heightForContentText:(NSString *)text;
+ (void)sharedView:(UIViewController *)viewController withShareText:(NSString *)shareText shareImage:(UIImage *)shareImage;
@end
