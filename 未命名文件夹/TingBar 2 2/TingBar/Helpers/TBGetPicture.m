//
//  TBGetPicture.m
//  TingBar
//
//  Created by lanouhn on 15/8/25.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBGetPicture.h"
#import "TBMacros.h"
#import "UMSocial.h"
static TBGetPicture *picHelper = nil;
@implementation TBGetPicture
+ (TBGetPicture *)sharedGetPicture{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        picHelper = [[TBGetPicture alloc] init];
    });
    return picHelper;
}
+ (void)sharedView:(UIViewController *)viewController withShareText:(NSString *)shareText shareImage:(UIImage *)shareImage {
    [UMSocialSnsService presentSnsIconSheetView:viewController
                                         appKey:@"55e433f267e58e5e1000130f"
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,nil]
                                       delegate:nil];
        
}
+ (NSMutableArray *)getPictureCycle{
    NSArray *picsName = @[@"recommended_books.png",@"recommendation_of_new_book.png",@"new_topics.png"];
    NSMutableArray *picArr = [NSMutableArray array];
    for (NSInteger i = 0; i < picsName.count; i++) {
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:picsName[i] ofType:nil]];
        [picArr addObject:image];
    }
     return picArr;
}

+ (NSMutableArray *)getPictureType{
    NSArray *picsName = @[@"__915978326.jpg",
                          @"_115834017.jpg",
                        @"_115834017.jpg",
                          @"__1947588810.jpg",
                          @"__21198066.jpg",
                          @"__169992966.jpg",
                          @"_1519496700.jpg",
                          @"_1124662830.jpg",
                          @"_447189023.jpg",
                          @"_1874577664.jpg",
                          @"__595690813.jpg",
                          @"_1970106285.jpg",
                          @"__1904710393.jpg",
                          @"__1321194685.jpg",
                          @"_1829958560.jpg",
                          @"__755268823.jpg",
                          @"__1015468931.jpg",
                          @"__14468128.jpg"];
    NSMutableArray *picArr = [NSMutableArray array];
    for (NSInteger i = 0; i < picsName.count; i++) {
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:picsName[i] ofType:nil]];
        [picArr addObject:image];
    }
    return picArr;
}

-(NSArray *)YSSXP{
    if (_YSSXP == nil) {
        self.YSSXP = @[@"1.00.jpg", @"1.01.jpg",@"1.02.jpg",@"1.03.jpg",@"1.04.jpg",@"1.05.jpg",@"1.06.jpg",@"1.07.jpg",@"1.08.jpg",@"1.10.jpg"];
    }return _YSSXP;
    
}
-(NSArray *)WXMZP{
    if (_WXMZP == nil) {
        self.WXMZP = @[@"2.00.jpg", @"2.01.jpg",@"2.02.jpg",@"2.03.jpg",@"2.04.jpg",@"2.05.jpg"];
    }return _WXMZP;
    
}

-(NSArray *)QYXQP{
    if (_QYXQP == nil) {
        self.QYXQP = @[@"3.00.jpg", @"3.01.jpg",@"3.02.jpg",@"3.03.jpg",@"3.04.jpg",@"3.05.jpg",@"3.06.jpg",@"3.07.jpg",@"3.08.jpg",@"3.09.jpg",@"3.10.jpg",@"3.11.jpg",@"3.12.jpg",@"3.13.jpg",@"3.14.jpg",@"3.15.jpg",@"3.16.jpg",@"3.17.jpg",@"3.18.jpg",@"3.19.jpg",@"3.20.jpg",@"3.21.jpg",@"3.22.jpg",@"3.23.jpg"];
    }return _QYXQP;
    
}

-(NSArray *)XSPSP{
    if (_XSPSP == nil) {
        self.XSPSP = @[@"4.00.jpg", @"4.01.jpg",@"4.02.jpg",@"4.03.jpg",@"4.04.jpg",@"4.05.jpg",@"4.06.jpg",@"4.07.jpg",@"4.08.jpg",@"4.09.jpg",@"4.10.jpg",@"4.11.jpg",@"4.12.jpg",@"4.13.jpg",@"4.14.jpg",@"4.15.jpg",@"4.16.jpg",@"4.17.jpg",@"4.18.jpg",@"4.19.jpg",@"4.20.jpg",@"4.21.jpg",@"4.22.jpg",@"4.23.jpg",@"4.24.jpg",@"4.25.jpg",@"4.26.jpg",@"4.27.jpg",@"4.28.jpg",@"4.29.jpg",@"4.30.jpg",@"4.31.jpg",];
    }return _XSPSP;
    
}
-(NSArray *)SETDP{
    if (_SETDP == nil) {
        self.SETDP = @[@"5.00.jpg", @"5.01.jpg",@"5.02.jpg",@"5.03.jpg",@"5.04.jpg",@"5.05.jpg",@"5.06.jpg"];
    }return _SETDP;
    
}
-(NSArray *)WYXXP{
    if (_WYXXP == nil) {
        self.WYXXP = @[@"6.00.jpg", @"6.01.jpg",@"6.02.jpg",@"6.03.jpg",@"6.04.jpg",@"6.05.jpg",@"6.06.jpg",@"6.07.jpg"];
    }return _WYXXP;
    
}
//
-(NSArray *)YLZYP{
    if (_YLZYP== nil) {
        self.YLZYP = @[@"7.00.jpg", @"7.01.jpg",@"7.02.jpg",@"7.03.jpg",@"7.04.jpg"];
    }return _YLZYP;
    
}
//
-(NSArray *)RWSKP{
    if (_RWSKP == nil) {
        self.RWSKP = @[@"8.00.jpg", @"8.01.jpg",@"8.02.jpg",@"8.03.jpg",@"8.04.jpg",@"8.05.jpg",@"8.06.jpg"];
    }return _RWSKP;
}

-(NSArray *)SSRDP{
    if (_SSRDP == nil) {
        self.SSRDP = @[@"9.00.jpg", @"9.01.jpg",@"9.02.jpg",@"9.03.jpg",@"9.04.jpg",@"9.05.jpg",@"9.06.jpg"];
    }return _SSRDP;
}
//

-(NSArray *)SYCJP{
    if (_SYCJP == nil) {
        self.SYCJP = @[@"10.00.jpg", @"10.01.jpg",@"10.02.jpg",@"10.03.jpg",@"10.04.jpg"];
    }return _SYCJP;
}




//
-(NSArray *)JKYSP{
    if (_JKYSP == nil) {
        self.JKYSP = @[@"12.00.jpg", @"12.01.jpg",@"12.02.jpg",@"12.03.jpg",@"12.04.jpg",@"12.05.jpg",@"12.06.jpg"];
    }return _JKYSP;
}


-(NSArray *)SSSHP{
    if (_SSSHP == nil) {
        self.SSSHP = @[@"15.00.jpg", @"15.01.jpg",@"15.02.jpg",@"15.03.jpg",@"15.04.jpg"];
    }return _SSSHP;
}

-(NSArray *)JYSTP{
    if (_JYSTP == nil) {
        self.JYSTP = @[@"14.00.jpg", @"14.01.jpg",@"14.02.jpg",@"14.03.jpg",@"14.04.jpg"];
    }return _JYSTP;
}

-(NSArray *)ZYJNP{
    if (_ZYJNP == nil) {
        self.ZYJNP = @[@"13.00.jpg", @"13.01.jpg",@"13.02.jpg",@"13.03.jpg",@"13.04.jpg",@"13.05.jpg",@"13.06.jpg"];
    }return _ZYJNP;
}

-(NSArray *)dataPic{
    if (_dataPic == nil) {
        self.dataPic = @[self.YSSXP,
                        self.WXMZP,
                         self.QYXQP,
                         self.XSPSP,
                         self.SETDP,
                         self.WYXXP,
                         self.YLZYP,
                         self.RWSKP,
                         self.SSRDP,
                         self.SYCJP,
                         @"1",
                         self.JKYSP,
                         self.SSSHP,
                         @"2",
                         self.ZYJNP,
                         self.JYSTP,];
    }return _dataPic;
}

+ (CGFloat )heightForContentText:(NSString *)text{
     CGFloat height = [text boundingRectWithSize:CGSizeMake(TBWidth - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor redColor]}context:nil].size.height;
       return height ;
    
}





@end
