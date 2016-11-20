//
//  TBPHViewController.m
//  TingBar
//
//  Created by lanouhn on 15/8/29.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBPHViewController.h"
#import "EFAnimationViewController.h"
#import "TBPHListController.h"
#import "JHTickerView.h"
#import "TBMacros.h"
#define RADIUS 100.0
#define PHOTONUM 5
#define TAGSTART 1000
#define TIME 1.5
#define SCALENUMBER 1.25
NSInteger array [PHOTONUM][PHOTONUM] = {
    {0,1,2,3,4},
    {4,0,1,2,3},
    {3,4,0,1,2},
    {2,3,4,0,1},
    {1,2,3,4,0}
};


@interface TBPHViewController ()<EFItemViewDelegate>
@property (nonatomic, strong) EFAnimationViewController *viewController;
@property (nonatomic, assign) NSInteger currentTag;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic,strong) JHTickerView *ticker;
@end

@implementation TBPHViewController
CATransform3D rotationTransform1[PHOTONUM];
- (void)viewDidLoad {
    [super viewDidLoad];
     self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"排行榜";
    self.viewController = ({
        EFAnimationViewController *viewController = [[EFAnimationViewController alloc] init];
        [self.view addSubview:viewController.view];
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
        viewController;
    });
        
    [self configViews];
    self.ticker = [[JHTickerView alloc] initWithFrame:CGRectMake(10, YRF(40), TBWidth - 20, YRF(50))];
    _ticker.backgroundColor = [UIColor cyanColor];
    [_ticker setDirection:JHTickerDirectionRTL];
    [_ticker setTickerSpeed:100.0f];
    _ticker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_ticker];
    [self buttonActionWith];
    
    
    
    // Do any additional setup after loading the view.
}
//


- (void)buttonActionWith
{
    NSArray * array = [NSArray arrayWithObjects:
                      @"随心FM,欢迎您,这里有热门榜,好评榜,下载榜, 搜索榜",
//                  @"榜索搜,榜载下,榜评好,榜门热有里这,您迎欢书听McGee",
                       @"本周热榜,仙逆",
                       nil];
    [_ticker setTickerStrings:array];
    [_ticker start];
    
}

- (void)configViews {
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_background.png"]];
    NSArray *dataArray = @[@"1.00.jpg", @"5.01.jpg", @"3.02.jpg", @"5.02.jpg", @"u=226804191,4173125022&fm=21&gp=0.jpg"];
   self.titleArray = @[@"热门榜", @"好评榜", @"下载榜", @"搜索榜", @"欢迎"];
    CGFloat centery = self.view.center.y - 50;
    CGFloat centerx = self.view.center.x;
    
    for (NSInteger i = 0;i < PHOTONUM;i++) {
        CGFloat tmpy =  centery + RADIUS*cos(2.0*M_PI *i/PHOTONUM);
        CGFloat tmpx =	centerx - RADIUS*sin(2.0*M_PI *i/PHOTONUM);
        EFItemView *view = [[EFItemView alloc] initWithNormalImage:dataArray[i] highlightedImage:[dataArray[i] stringByAppendingFormat:@"%@", @"_hover"] tag:TAGSTART+i title:nil];
        UILabel *alabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 85, 115, 30)];
        alabel.text = _titleArray[i];
        alabel.alpha = 0.7;
        alabel.backgroundColor = [UIColor cyanColor];
        if (i == 4) {
            alabel.backgroundColor = [UIColor whiteColor];
        }
        alabel.textAlignment = NSTextAlignmentCenter;
        [view addSubview:alabel];
        view.layer.masksToBounds = YES;
        //截取边角的半径
        view.layer.cornerRadius = 115/2;
        view.frame = CGRectMake(0.0, 0.0,115,115);
        view.center = CGPointMake(tmpx,tmpy);
        view.delegate = self;
        rotationTransform1[i] = CATransform3DIdentity;
        
        CGFloat Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
        if (Scalenumber < 0.3) {
            Scalenumber = 0.4;
        }
        CATransform3D rotationTransform = CATransform3DIdentity;
        rotationTransform = CATransform3DScale (rotationTransform, Scalenumber*SCALENUMBER,Scalenumber*SCALENUMBER, 1);
        view.layer.transform=rotationTransform;
        [self.view addSubview:view];
        
    }
    self.currentTag = TAGSTART;
}

#pragma mark - EFItemViewDelegate

- (void)didTapped:(NSInteger)index {
    
    if (self.currentTag  == index) {
        if (self.currentTag - 999 == 5) {
            return;
        }
        TBPHListController *listVC = [[TBPHListController alloc] init];
        listVC.type = self.currentTag - 999;
        NSString *name = self.titleArray[listVC.type - 1];
        listVC.name = name;
        [self.navigationController pushViewController:listVC animated:YES];
         return;
    }
    
    NSInteger t = [self getIemViewTag:index];
    
    for (NSInteger i = 0;i<PHOTONUM;i++ ) {
        
        UIView *view = [self.view viewWithTag:TAGSTART+i];
        [view.layer addAnimation:[self moveanimation:TAGSTART+i number:t] forKey:@"position"];
        [view.layer addAnimation:[self setscale:TAGSTART+i clicktag:index] forKey:@"transform"];
        
        NSInteger j = array[index - TAGSTART][i];
        CGFloat Scalenumber = fabs(j - PHOTONUM/2.0)/(PHOTONUM/2.0);
        if (Scalenumber < 0.3) {
            Scalenumber = 0.4;
        }
    }
    self.currentTag  = index;
}

- (CAAnimation*)setscale:(NSInteger)tag clicktag:(NSInteger)clicktag {
    
    NSInteger i = array[clicktag - TAGSTART][tag - TAGSTART];
    NSInteger i1 = array[self.currentTag  - TAGSTART][tag - TAGSTART];
    CGFloat Scalenumber = fabs(i - PHOTONUM/2.0)/(PHOTONUM/2.0);
    CGFloat Scalenumber1 = fabs(i1 - PHOTONUM/2.0)/(PHOTONUM/2.0);
    if (Scalenumber < 0.3) {
        Scalenumber = 0.4;
    }
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.duration = TIME;
    animation.repeatCount =1;
    
    CATransform3D dtmp = CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber*SCALENUMBER, Scalenumber*SCALENUMBER, 1.0);
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(rotationTransform1[tag - TAGSTART],Scalenumber1*SCALENUMBER,Scalenumber1*SCALENUMBER, 1.0)];
    animation.toValue = [NSValue valueWithCATransform3D:dtmp ];
    animation.autoreverses = NO;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

- (CAAnimation*)moveanimation:(NSInteger)tag number:(NSInteger)num {
    // CALayer
    UIView *view = [self.view viewWithTag:tag];
    CAKeyframeAnimation* animation;
    animation = [CAKeyframeAnimation animation];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL,view.layer.position.x,view.layer.position.y);
    
    NSInteger p =  [self getIemViewTag:tag];
    CGFloat f = 2.0*M_PI  - 2.0*M_PI *p/PHOTONUM;
    CGFloat h = f + 2.0*M_PI *num/PHOTONUM;
    CGFloat centery = self.view.center.y - 50;
    CGFloat centerx = self.view.center.x;
    CGFloat tmpy =  centery + RADIUS*cos(h);
    CGFloat tmpx =	centerx - RADIUS*sin(h);
    view.center = CGPointMake(tmpx,tmpy);
    
    CGPathAddArc(path,nil,self.view.center.x, self.view.center.y - 50,RADIUS,f+ M_PI/2,f+ M_PI/2 + 2.0*M_PI *num/PHOTONUM,0);
    animation.path = path;
    CGPathRelease(path);
    animation.duration = TIME;
    animation.repeatCount = 1;
    animation.calculationMode = @"paced";
    return animation;
}

- (NSInteger)getIemViewTag:(NSInteger)tag {
    
    if (self.currentTag >tag){
        return self.currentTag  - tag;
    } else {
        return PHOTONUM  - tag + self.currentTag ;
    }
}



//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
