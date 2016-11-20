//
//  ViewController.m
//  TingBar
//
//  Created by lanouhn on 15/8/24.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "ViewController.h"
#import "TBMyCollectDetailController.h"
#import "CollectionViewCell.h"
#import "TBBookTypeCell.h"
#import "TBBookDetailController.h"
#import "TBGetMainData.h"
#import "TBGetPicture.h"
#import "NetWorkEngine.h"
#import "AFNetworking.h"
#import "TBTopImgModel.h"
#import "TBTypeListModel.h"
#import "TBTypeResourceController.h"
#import "TBSeacherBookController.h"
#import "MJRefresh.h"
#import "TBTypeResourceCell.h"
#import "TBheaderView.h"
#import "TBfooterView.h"
#import "UIImageView+WebCache.h"
#import "TBTJModel.h"
#import "TBTJListController.h"
#import "TBPHViewController.h"
#import "TBTypeResourceDetailController.h"
#import "TBMacros.h"
#import "TBTopicController.h"
#import "UIImage+ImageEffects.h"
#import "TBsingleton.h"
#import "ProjectCleanCaches.h"
#import "TBAboutMeVC.h"
#import "GiFHUD.h"
#import "AppDelegate.h"
#import "TBZBDTController.h"
#import "TopMianModel.h"
#import "AppDelegate.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIAlertViewDelegate,AppDelegateDelegate>
{
    BOOL flag ;  //用于记录是否切换夜间模式
    UISwitch  *DarkSwtich;
    BOOL value;
    NSUserDefaults *userDefaults;
}
@property (nonatomic, retain)UIView  *backView;
@property (nonatomic, strong)UICollectionView *collection;
@property (nonatomic, strong)UICollectionView *collectionTJ;
@property (nonatomic, strong) UISwipeGestureRecognizer *panGesture;
@property (nonatomic, strong) UIButton *searchBt;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong)  NSArray *arrr;
@property (nonatomic, strong) UIButton *titleBt;
@property (nonatomic, strong)UIScrollView *titleScrollView;
@property (nonatomic, strong)UIButton *button;
@property (nonatomic, strong)NSArray *titleArr;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)TBheaderView *headerView;
@property (nonatomic, strong)TBfooterView *footerView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionViewFlowLayout *layoutTJ;
@property (nonatomic, strong) NSMutableArray *ArrTJ12;
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, strong)UIAlertView *alert;
@property (nonatomic, strong)UIImageView *imageView ;
@property (strong, nonatomic) AppDelegate *myAppDelegate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myAppDelegate = [UIApplication sharedApplication].delegate;
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
      delegate.delegate = self;
    [GiFHUD setGifWithImageName:@"pika.gif"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setUp];
    [self setUptitleScrollView];
    [self setUpBigViewScrollView];
    [self setUpCollectionView];
    [self setUpTJCollectionView];
    [self registercell];
    [self setupimg];
    [self selectGesture];
    [self setUpRefresh];
}
- (void)setUpRefresh{
    self.collection.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.collectionTJ.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh1)];
}
- (void)headerRefresh1{
    [self getTJdata];
    [self.collectionTJ.header endRefreshing];
}
- (void)headerRefresh{
    [self selectNetWork];
    [self.collection.header endRefreshing];
}
//有网自动刷新
- (void)getMainData{
    [self.collection.header beginRefreshing];
    [self.collectionTJ.header beginRefreshing];
}
//加载存起来的数据
- (void)getCacheData{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"TopMianModel"];
    NSArray *resultArray = [self.myAppDelegate.managedObjectContext executeFetchRequest:request error:nil];
    [self.dataSource addObjectsFromArray:resultArray];
    [self.tableView reloadData];
    
    
}
- (void)selectGesture{
    if (self.upView.frame.origin.x == XRF(375/2) ) {
        [self.upView addGestureRecognizer:self.tapg];
        }else{
        [self.upView removeGestureRecognizer:self.tapg];
    }
}
- (void)setupimg{
    UIImage *image = [UIImage imageNamed:@"u=226804191,4173125022&fm=21&gp=0.jpg"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    _imageView.frame = CGRectMake(40, 0, 80, 80);
    [self.backView addSubview:_imageView];
    [self.backView insertSubview:_imageView belowSubview:self.upView];
}
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    }return _dataSource;
}
- (NSMutableArray *)ArrTJ12{
    if (_ArrTJ12 == nil) {
        self.ArrTJ12 = [NSMutableArray array];
    }return _ArrTJ12;
    
}
-(NSMutableArray *)typelistData{
    if (_typelistData == nil) {
        self.typelistData = [NSMutableArray array];
    }return _typelistData;
}
- (void)selectNetWork{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"network"] integerValue] < 1) {
        [self getInfoViaNoNet];
        }else{
        [self getInfoViaNet];
    }
}

- (void)removeFromView{
    [self.alert dismissWithClickedButtonIndex:0 animated:YES];
}
- (void)setUpaLert{
    self.alert = [[UIAlertView alloc] initWithTitle:@"请检查网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(removeFromView) userInfo:nil repeats:NO];
    [_alert show];
}
-(void)getInfoViaNet
{    __weak typeof(self) mySelf = self;
    [GiFHUD dismiss];
    //[GiFHUD show];
    [[NetWorkEngine shareNetWorkEngine]GetRequestNetInfoWithURLStrViaNet:@"http://api.mting.info/yyting/bookclient/ClientGetTypeIndex.action?type=0&pageNum=1&pageSize=30&coverType=12&terminalType=1&token=c" sucess:^(id response) {
        [GiFHUD dismiss];
        NSDictionary *dataDic = response;
        NSArray *items = dataDic[@"recommendList"];
        NSArray *typeItems = dataDic[@"typeList"];
        [mySelf.dataSource removeAllObjects];
        for (NSDictionary *dic in items) {
            TBTopImgModel *model = [[TBTopImgModel alloc] initWithDic:dic];
            NSEntityDescription *description = [NSEntityDescription entityForName:@"TopMianModel" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
            //创建模型对象
            TopMianModel *his = [[TopMianModel alloc] initWithEntity:description insertIntoManagedObjectContext:self.myAppDelegate.managedObjectContext];
            his.title = model.name;
            his.desc = model.desc;
            [self.myAppDelegate saveContext];
            [mySelf.dataSource addObject:model];
        }
        [mySelf.typelistData removeAllObjects];
        for (NSDictionary *dic in typeItems) {
            TBTypeListModel *model = [[TBTypeListModel alloc] initWithDic:dic];
            [mySelf.typelistData addObject:model];
        }
        [mySelf.collection reloadData];
        
    } failur:^(id error) {
        [self setUpaLert];
        [GiFHUD dismiss];
    }];
}
- (void)getInfoViaNoNet
{    __weak typeof(self) mySelf = self;
    [GiFHUD dismiss];
   // [GiFHUD show];
    [[NetWorkEngine shareNetWorkEngine]GetRequestNetInfoWithURLStrViaNoNet:@"http://api.mting.info/yyting/bookclient/ClientGetTypeIndex.action?type=0&pageNum=1&pageSize=100&coverType=12&terminalType=1&token=c" sucess:^(id response) {
         [GiFHUD dismiss];
        NSDictionary *dataDic = response;
        NSArray *items = dataDic[@"recommendList"];
        NSArray *typeItems = dataDic[@"typeList"];
        [mySelf.dataSource removeAllObjects];
        for (NSDictionary *dic in items) {
            TBTopImgModel *model = [[TBTopImgModel alloc] initWithDic:dic];
            
            [mySelf.dataSource addObject:model];
        }
        [mySelf.typelistData removeAllObjects];
        for (NSDictionary *dic in typeItems) {
            TBTypeListModel *model = [[TBTypeListModel alloc] initWithDic:dic];
            
            [mySelf.typelistData addObject:model];
        }
        [mySelf.collection reloadData];
       
    } failur:^(id error) {
        [GiFHUD dismiss];
        [self setUpaLert];
        
    }];
}


- (void)registercell{
    [self.collection registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cells"];
    [self.collection registerNib:[UINib nibWithNibName:@"TBBookTypeCell" bundle:nil] forCellWithReuseIdentifier:@"cellss"];
    [_collection registerClass:[TBheaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}
- (void)setUp{
    self.arrr = @[@"我的收藏",  @"清除缓存", @"关于我们"];
    self.backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.backView];
    for (NSInteger i = 0; i < self.arrr.count; i++) {
        self.titleBt = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleBt.frame = CGRectMake(0, YRF(140) + i * YRF(80), TBWidth/2, YRF(60));
        _titleBt.backgroundColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:1];
        [_titleBt addTarget:self action:@selector(handlepush:) forControlEvents:UIControlEventTouchUpInside];
        [_titleBt setTitle:_arrr[i] forState:UIControlStateNormal];
        [self.backView addSubview:_titleBt];
        [_titleBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setUpDrak];
    }
    self.upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, XRF(375), YRF(667))];
    self.upView.backgroundColor = [UIColor cyanColor];
     [self.backView addSubview:self.upView];
    self.myBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _myBt.frame = CGRectMake(5, 0, 20, 20);
    [_myBt setBackgroundImage:[UIImage imageNamed:@"ic_home_tab_mine_focused.png"] forState:UIControlStateNormal];
    [_myBt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_myBt addTarget:self action:@selector(handle:) forControlEvents:UIControlEventTouchUpInside];
    self.searchBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBt.frame = CGRectMake(345, 0, 20, 20);
    [_searchBt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_searchBt setBackgroundImage:[UIImage imageNamed:@"ic_member_search.png"] forState:UIControlStateNormal];
    [_searchBt addTarget:self action:@selector(handle1:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *PHBt = [UIButton buttonWithType:UIButtonTypeCustom];
    PHBt.frame = CGRectMake(345, 0, 20, 20);
    [PHBt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [PHBt setBackgroundImage:[UIImage imageNamed:@"ic_home_tab_listen_focused.png"] forState:UIControlStateNormal];
    [PHBt addTarget:self action:@selector(handle2:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_searchBt];
    UIBarButtonItem *_rightPHItem = [[UIBarButtonItem alloc] initWithCustomView:PHBt];
    UIButton *PHBt1 = [UIButton buttonWithType:UIButtonTypeCustom];
    PHBt1.frame = CGRectMake(345, 0, 20, 20);
    [PHBt1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    UIBarButtonItem *_rightBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:PHBt1];
    self.navigationItem.rightBarButtonItems = @[_rightPHItem,_rightBarButtonItem1, _rightBarButtonItem ];
     UIBarButtonItem *_leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_myBt];
    UIButton *PHBt2 = [UIButton buttonWithType:UIButtonTypeCustom];
    PHBt2.frame = CGRectMake(345, 0, 20, 20);
    [PHBt2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [PHBt2 setBackgroundImage:[UIImage imageNamed:@"ic_book_home_anchor_radio.png"] forState:UIControlStateNormal];
    [PHBt2 addTarget:self action:@selector(handleZBDT:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *_rightBarButtonItem2 = [[UIBarButtonItem alloc] initWithCustomView:PHBt2];
     self.navigationItem.leftBarButtonItems = @[_leftBarButtonItem,_rightBarButtonItem1, _rightBarButtonItem2];
}
- (void)handleZBDT:(UIButton *)sender{
    [GiFHUD dismiss];
    TBZBDTController *ZBDTVC = [[TBZBDTController alloc] init];
    [self.navigationController pushViewController:ZBDTVC animated:YES];
}

- (void)handle2:(UIButton *)sender{
    TBPHViewController *phVC = [[TBPHViewController alloc] init];
    [GiFHUD dismiss];
    [self.navigationController pushViewController:phVC animated:YES];
}
- (void)handlepush:(UIButton *)sender{
    [GiFHUD dismiss];
    if ([sender.titleLabel.text isEqualToString:self.arrr[0]]) {
        TBMyCollectDetailController *detailVC = [[TBMyCollectDetailController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];    }
       if([sender.titleLabel.text isEqualToString:self.arrr[1]]) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"这将清空你所有的数据" message:@"是否确定" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
    if([sender.titleLabel.text isEqualToString:self.arrr[2]]) {
        TBAboutMeVC *aboutVC = [[TBAboutMeVC alloc] init];
        
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}
- (void)setUpDrak{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, YRF(140) + 3 * YRF(80), TBWidth/2, YRF(20))];
    label.backgroundColor = [UIColor brownColor];
     label.text = @"夜间模式";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.backView addSubview:label];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame) , TBWidth/2, 32)];
    v.backgroundColor = [UIColor brownColor];
    DarkSwtich = [[UISwitch alloc] initWithFrame:CGRectMake(XRF(60), 0, TBWidth/2, 32)];
    [DarkSwtich setOnTintColor:[UIColor purpleColor]];
    DarkSwtich.on = [userDefaults boolForKey:@"teemo"];
    DarkSwtich.backgroundColor = [UIColor brownColor];
    [DarkSwtich addTarget:self action:@selector(DarkswitchAction) forControlEvents:UIControlEventValueChanged];
    [v addSubview:DarkSwtich];
    [self.backView addSubview:v];
}
-(void)DarkswitchAction{
    [GiFHUD dismiss];
    if (DarkSwtich.on ) {
        self.view.window.alpha = 0.6;
    }else{
        self.view.window.alpha = 1;
    }
    [userDefaults setBool:DarkSwtich.on forKey:@"teemo"];
}

-(void)viewDidAppear:(BOOL)animated{
    userDefaults = [NSUserDefaults standardUserDefaults];
    DarkSwtich.on = [userDefaults boolForKey:@"teemo"];
    [self DarkswitchAction];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:{
            NSArray *arr = [TBsingleton sharedSingleton].manager.operationQueue.operations;
            if (arr.count > 0) {
                for (int i = 0; i < arr.count; i++) {
                    AFHTTPRequestOperation *op = arr[i];
                    [op cancel];
                    op = nil;
                }
            }
            NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:@"downName"];
            if (array.count > 0) {
                for (NSString *str in array) {
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:str];
                }
            }
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"myArray"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"history"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"name"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"downName"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"downWIN"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"downVid"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"vid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSString *cach = [NSString stringWithFormat:@"本次共清除%.2fMB缓存",[ProjectCleanCaches sizeWithFilePaht:[ProjectCleanCaches CachesDirectory]]];
            [ProjectCleanCaches clearCachesWithFilePath:[ProjectCleanCaches CachesDirectory]];
            UIAlertView *alertView1 = [[UIAlertView alloc] initWithTitle:cach message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView1 show];
            
            break;
        }
        default:
            break;
    }
    
}
- (UITapGestureRecognizer *)tapg{
    [GiFHUD dismiss];
    if (_tapg == nil) {
        self.tapg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backNolmal)];
    }return _tapg;
}
- (void)handle:(UIButton *)sender{
    [GiFHUD dismiss];
    if (sender.isSelected == NO) {
        [UIView animateWithDuration:0.2 animations:^{
            self.upView.frame = CGRectMake(XRF(375/2), 0, XRF(375), YRF(667));
        }];
        [self.upView addGestureRecognizer:self.tapg];
        sender.selected = YES;
    }else{
        [self backNolmal];
    }
}
- (void)backNolmal{
    [UIView animateWithDuration:0.2 animations:^{
        self.upView.frame = CGRectMake(0, 0, XRF(375), YRF(667));
    }];
    [self.upView removeGestureRecognizer:self.tapg];
    self.myBt.selected = NO;
}
- (void)handle1:(UIButton *)sender{
    [GiFHUD dismiss];
    TBSeacherBookController *seachVC = [[TBSeacherBookController alloc] init];
    [self.navigationController pushViewController:seachVC animated:YES];
}
#pragma mark ---主界面
//
- (void)setUptitleScrollView{
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, XRF(375), 35)];
    self.titleScrollView.backgroundColor = [UIColor colorWithRed:248/256.0 green:202/256.0 blue:239/256.0 alpha:1];
    [self.upView addSubview:self.titleScrollView];
    [self setUpButton];
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(TBWidth/5, 32, 60, 2)];
    self.lineView.backgroundColor = [UIColor cyanColor];
    [self.titleScrollView addSubview:self.lineView];
}
- (void)setUpButton{
    self.titleArr = @[@"分类", @"推荐"];
    for (NSInteger i = 0; i < 2; i++) {
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.button.frame = CGRectMake(TBWidth/5 + i * 150, 0, 60, 35);
        [self.titleScrollView addSubview:self.button];
        [self.button addTarget:self action:@selector(handleLoad:) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)handleLoad:(UIButton *)sender{
    sender.selected = NO;
    if (sender.isSelected == NO) {
        [UIView animateWithDuration:0.1 animations:^{
            self.lineView.frame = CGRectMake(sender.frame.origin.x, 33, 60, 2);
            NSInteger a = sender.frame.origin.x/150;
            self.BigViewScrollView.contentOffset = CGPointMake(XRF(a * 375), 0);
        }];
        sender.selected = YES;
    }
    if ([sender.currentTitle isEqualToString:@"推荐"]) {
        [self.collectionTJ.header beginRefreshing];
        }
    if ([sender.currentTitle isEqualToString:@"分类"]) {
        [self.collection.header beginRefreshing];
    }
}
- (void)setUpBigViewScrollView{
    self.BigViewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 35, self.upView.frame.size.width , self.upView.frame.size.height - 35 - 64)];
    self.BigViewScrollView.contentSize = CGSizeMake(XRF(375 * 2), self.upView.frame.size.height - 35 - 64);
    self.BigViewScrollView.showsVerticalScrollIndicator = NO;
    self.BigViewScrollView.showsHorizontalScrollIndicator = NO;
    self.BigViewScrollView.pagingEnabled = YES;
    self.BigViewScrollView.delegate = self;
    self.BigViewScrollView.bounces = NO;
    self.BigViewScrollView.userInteractionEnabled = YES;
    [self.upView addSubview:self.BigViewScrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.BigViewScrollView) {
        self.lineView.frame = CGRectMake(TBWidth/5 +((scrollView.contentOffset.x)/(TBWidth)) * 150, 33, 60, 2);
        if ((scrollView.contentOffset.x) / (TBWidth) == 1) {
            [self.collectionTJ.header beginRefreshing];
        }
    }

}

//创建collectionview
- (void)setUpCollectionView{
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.itemSize = CGSizeMake(XRF(170), YRF(110));
    _layout.footerReferenceSize = CGSizeMake(0, 0);
    _layout.headerReferenceSize = CGSizeMake(0, 0);
    
    
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.BigViewScrollView.frame.size.width, self.BigViewScrollView.frame.size.height) collectionViewLayout:_layout];
    _collection.delegate = self;
    _collection.dataSource = self;
    [self.BigViewScrollView addSubview:_collection];
    _collection.backgroundColor = [UIColor whiteColor];
    
}
#pragma mark  -- 推荐界面
//推荐界面请求数据
//推荐数据
- (void)getTJdata{
    //
    
    [GiFHUD dismiss];
    [GiFHUD show];
    NSString *completeUrlTJ = [NSString stringWithFormat:@"http://api.mting.info/yyting/bookclient/ClientGetTopicRecommendList.action?token=c-OSIyXjARZpyYxpsrvdPZWQdfZwFL7R-zdukwv7lbY*&q=507&imei=ODY0MzAxMDI2OTU2Nzk0"];
    AFHTTPRequestOperationManager *managerTJ = [AFHTTPRequestOperationManager manager];
    [managerTJ GET:completeUrlTJ parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *arr = dic[@"list"];
        [self.ArrTJ12 removeAllObjects];
        for (NSDictionary *tempDic in arr) {
            TBTJModel *model = [[TBTJModel alloc] initWithDic:tempDic];
            [self.ArrTJ12 addObject:model];
        }
        if (self.ArrTJ12.count != 0) {
            [self.collectionTJ reloadData];
            [GiFHUD dismiss];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [GiFHUD dismiss];
        [self setUpaLert];
    }];
}
- (void)setUpTJCollectionView{
    self.layoutTJ = [[UICollectionViewFlowLayout alloc] init];
    _layoutTJ.itemSize = CGSizeMake(XRF(70), YRF(100));
    _layoutTJ.footerReferenceSize = CGSizeMake(0, 40);
    _layoutTJ.headerReferenceSize = CGSizeMake(0, 40);
    self.collectionTJ = [[UICollectionView alloc] initWithFrame:CGRectMake(XRF(375), 0, self.BigViewScrollView.frame.size.width, self.BigViewScrollView.frame.size.height) collectionViewLayout:_layoutTJ];
    _collectionTJ.delegate = self;
    _collectionTJ.dataSource = self;
    [self.BigViewScrollView addSubview:_collectionTJ];
    [self.collectionTJ registerNib:[UINib nibWithNibName:@"TBTypeResourceCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cellsss"];
    _collectionTJ.backgroundColor = [UIColor whiteColor];
    [_collectionTJ registerClass:[TBheaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    //注册页脚
    [_collectionTJ registerClass:[TBfooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
 }
#pragma mark <UICollectionViewDataSource>
#pragma mark ---------  UICollectionViewDataSource  - Methods
//设置分区的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView == self.collection) {
        return 2;
    }else{
        return self.ArrTJ12.count ;
    }
}
//设置每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.collection) {
        if (section == 0) {
            return self.dataSource.count ;
          }else if(section == 1){
             return self.typelistData.count ;
        }
        return 2;
    }else{
        return 6;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collection) {
        if (indexPath.section == 0) {
            return CGSizeMake(XRF(375), YRF(70));
        }
        return CGSizeMake(XRF(180) - 1, YRF(50));
    }else{
        return CGSizeMake(XRF(110), 150);
    }
}
//为每个分区的item配置内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //给书籍推荐,新书上架配置内容
    NSArray *arr = [TBGetPicture getPictureCycle];
    NSArray *arr1 = [TBGetPicture getPictureType];
    if (collectionView == self.collection ) {
        if (indexPath.section == 0 ) {
            TBTopImgModel *model = self.dataSource[indexPath.row];
            CollectionViewCell *cell = [self.collection dequeueReusableCellWithReuseIdentifier:@"cells" forIndexPath:indexPath];
             cell.ImgView.image = arr[indexPath.row];
            cell.titleLabel.text = model.name;
            cell.detailLabel.text = model.desc;
//            TopMianModel *modelNew = [NSEntityDescription insertNewObjectForEntityForName:@"TopMianModel" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
//            modelNew.title = cell.titleLabel.text;
//            modelNew.desc = cell.detailLabel.text;
            //[self.myAppDelegate saveContext];
            return cell;
        }else if(self.typelistData.count != 0 && indexPath.section == 1 ){
            //给下面的17种分类配置内容
            TBTypeListModel *model = self.typelistData[indexPath.row ];
            TBBookTypeCell *cell = [self.collection dequeueReusableCellWithReuseIdentifier:@"cellss" forIndexPath:indexPath];
             cell.typeImgView.image = arr1[indexPath.row];
            cell.typeLabel.text = model.name;
            return cell;
        }
        else{
            CollectionViewCell *cell = [self.collection dequeueReusableCellWithReuseIdentifier:@"cells" forIndexPath:indexPath];
            return cell;
        }
    }else{
        //给推荐页面配置内容
        TBTypeResourceCell *cell = [self.collectionTJ dequeueReusableCellWithReuseIdentifier:@"cellsss" forIndexPath:indexPath];
        
        TBTJModel *model = self.ArrTJ12[indexPath.section];
        TBBookDetailModel *detailModel = model.dataSource[indexPath.row + 1];
        NSURL *url = [NSURL URLWithString:detailModel.cover];
        [cell.typeResourceImgV sd_setImageWithURL:url placeholderImage:self.img];
        cell.typeResourcesLabel.text = detailModel.bookName;
        return cell;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collection) {
        if ((indexPath.section == 0 && indexPath.row == 0) || (indexPath.section == 0 && indexPath.row == 1)) {
            TBTopImgModel *model = self.dataSource[indexPath.row];
            TBBookDetailController *bookDetailVC = [[TBBookDetailController alloc] init];
            bookDetailVC.ID = model.ID;
            [self.navigationController pushViewController:bookDetailVC animated:YES];
        }
        if (indexPath.section == 0 && indexPath.row == 2) {
            TBTopImgModel *model = self.dataSource[indexPath.row];
            TBTopicController *bookDetailVC = [[TBTopicController alloc] init];
            bookDetailVC.ID = model.ID;
            [self.navigationController pushViewController:bookDetailVC animated:YES];
        }
          if (indexPath.section == 1 && indexPath.row != 10 && indexPath.row != 13 && indexPath.row != 16) {
            TBTypeListModel *model = self.typelistData[indexPath.row];
            NSArray *array = [TBGetPicture sharedGetPicture].dataPic[indexPath.row];
            TBTypeResourceController *TypeVC = [[TBTypeResourceController alloc] init];
            TypeVC.model = model;
            TypeVC.arrayPic = array;
            [self.navigationController pushViewController:TypeVC animated:YES];
        }
        if ((indexPath.section == 1 && indexPath.row  == 10) || (indexPath.section == 1 && indexPath.row  == 13 )|| (indexPath.section == 1 && indexPath.row  == 16)) {
            TBTypeListModel *model = self.typelistData[indexPath.row];
            TBTypeResourceDetailController  *TypeVC = [[TBTypeResourceDetailController alloc] init];
            TypeVC.ID = model.ID;
            TypeVC.name = model.name;
            [self.navigationController pushViewController:TypeVC animated:YES];
        }
    }
    else{
        TBTJModel *model = self.ArrTJ12[indexPath.section];
        TBBookDetailModel *detailModel = model.dataSource[indexPath.row + 1];
        TBBookDetailController *detailVC = [[TBBookDetailController alloc] init];
        detailVC.ID = detailModel.bookID;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }
}
- (void)saveData{
   
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (self.ArrTJ12.count != 0) {
         //给推荐界面配置footer和header
        if (kind == UICollectionElementKindSectionHeader && collectionView == self.collectionTJ) {
            TBTJModel *model = self.ArrTJ12[indexPath.section];
            self.headerView = [self.collectionTJ dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
            //为页眉上的控件赋值
            _headerView.headLabel.text = model.topicName;
            return _headerView;
         }else if(kind == UICollectionElementKindSectionFooter && collectionView == self.collectionTJ){
            TBTJModel *model = self.ArrTJ12[indexPath.section];
            TBfooterView *footerView = [self.collectionTJ dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
            footerView.alabel.text = [NSString stringWithFormat:@"查看更多%@", model.topicName];
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleList:)];
            footerView.tag = 100 + indexPath.section;
            [footerView addGestureRecognizer:tapGesture];
            return footerView;
            return _headerView;
        }
    }
    self.headerView = [self.collection dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    //为页眉上的控件赋值
    return _headerView;
}
- (void)handleList:(UITapGestureRecognizer *)sender{
    TBTJModel *model = self.ArrTJ12[sender.view.tag - 100];
    TBTJListController *listVC = [[TBTJListController alloc] init];
    listVC.model = model;
    [self.navigationController pushViewController:listVC animated:YES];
}
- (UIImage *)img{
    if (_img == nil) {
        self.img = [UIImage imageNamed:@"7.00.jpg"];
    }return _img;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
