//
//  TBTypeResourceController.m
//  TingBar
//
//  Created by lanouhn on 15/8/27.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBTypeResourceController.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "TypeResourceModel.h"
#import "TBTypeResourceCell.h"
#import "TBTypeResourceDetailController.h"
#import "TBGetPicture.h"
#import "TBMacros.h"
#import "GiFHUD.h"
@interface TBTypeResourceController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong)NSMutableArray *dataArr;
@property (nonatomic, strong)UIAlertView *alert;
@end
@implementation TBTypeResourceController

- (void)viewDidLoad {
    [super viewDidLoad];
     [GiFHUD setGifWithImageName:@"pika.gif"];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.model.name;
    [self setUpCollectionView];
    [self.collection registerNib:[UINib nibWithNibName:@"TBTypeResourceCell" bundle:nil] forCellWithReuseIdentifier:@"cellsss"];
    [self getDetailData];
    
    // Do any additional setup after loading the view.
}
- (void)removeFromView{
    [self.alert dismissWithClickedButtonIndex:0 animated:YES];
 }

- (void)setUpaLert{
    self.alert = [[UIAlertView alloc] initWithTitle:@"请检查网络" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了", nil];
    [_alert show];
}
- (void)setUpNstimer{
     [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(removeFromView) userInfo:nil repeats:NO];
    
}
- (void)getDetailData{
    [GiFHUD dismiss];
    [GiFHUD show];
    NSString *completeUrl = [NSString stringWithFormat:@"http://117.25.143.74/yyting/bookclient/ClientTypeResource.action?type=%@&pageNum=0&pageSize=500&token=c-OSIyXjARZpyYxpsrvdPcMarrMcswoK-zdukwv7lbY*&q=35&imei=ODY0MzAxMDI2OTU2Nzk0",self.model.ID];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:completeUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = responseObject;
        NSArray *arr = dic[@"list"];
        for (NSDictionary *tempDic in arr) {
            TypeResourceModel *Typemodel = [[TypeResourceModel alloc] initWithDic:tempDic];
            [self.dataArr addObject:Typemodel];
        }
        [GiFHUD dismiss];
        [self.collection reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [GiFHUD dismiss];
        [self setUpaLert];
        [self setUpNstimer];
    }];
}

//创建collectionview
- (void)setUpCollectionView{
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.itemSize = CGSizeMake(XRF(170),YRF(100));
    _layout.footerReferenceSize = CGSizeMake(0, 0);
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, TBWidth, TBHight - 64) collectionViewLayout:_layout];
    _collection.delegate = self;
    _collection.dataSource = self;
    [self.view addSubview:_collection];
    _collection.backgroundColor = [UIColor whiteColor];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count > self.arrayPic.count ? self.arrayPic.count : self.dataArr.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(XRF(110), YRF(140));
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TBTypeListModel *model = self.dataArr[indexPath.row];
   TBTypeResourceCell *cell = [self.collection dequeueReusableCellWithReuseIdentifier:@"cellsss" forIndexPath:indexPath];
    cell.typeResourcesLabel.text = model.name;
    NSString *stringPic = self.arrayPic[indexPath.row];
    cell.typeResourceImgV.image = [UIImage imageNamed:stringPic];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TypeResourceModel *Typemodel = self.dataArr[indexPath.row];
    TBTypeResourceDetailController *detailVC = [[TBTypeResourceDetailController alloc] init];
    detailVC.ID = Typemodel.ID;
    detailVC.name = Typemodel.name;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        self.dataArr = [NSMutableArray array];
    }return _dataArr;
    
}

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
