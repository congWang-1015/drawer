//
//  TBRankListController.m
//  TingBar
//
//  Created by lanouhn on 15/8/25.
//  Copyright (c) 2015年 Congwang. All rights reserved.
//

#import "TBRankListController.h"
#import "ViewController.h"
#import "TBRKTopCollectionViewCell.h"
@interface TBRankListController ()<UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong)UICollectionView *collectionView;
@end

@implementation TBRankListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)setUpCollectionView{
    ViewController *viewVC = [[ViewController alloc] init];
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.itemSize = CGSizeMake(170, 100);
    _layout.footerReferenceSize = CGSizeMake(0, 30);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 375, 550) collectionViewLayout:_layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [viewVC.BigViewScrollView addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor colorWithRed:205/256.0 green:240/256.0 blue:242/256.0 alpha:1];
}

#pragma mark ---------  UICollectionViewDataSource  - Methods
//设置分区的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
//设置每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }return 18;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(375, 150);
    }else if (indexPath.section == 1){
        return CGSizeMake(375, 70);
        
        
    }
    return CGSizeMake(170 - 1, 70);
    
    
}
//为每个分区的item配置内容
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    //if (indexPath.section == 0) {
////        TBRKTopCollectionViewCell *cell = [self.collection dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
////        cell.TopImgV.image = self.topImg;
//       // return cell;
//        
//   // }else if (indexPath.section == 1){
////        CollectionViewCell *cell = [self.collection dequeueReusableCellWithReuseIdentifier:@"cells" forIndexPath:indexPath];
////        cell.ImgView.image = self.topicImg;
////        return cell;
////    }
////    TBBookTypeCell *cell = [self.collection dequeueReusableCellWithReuseIdentifier:@"cellss" forIndexPath:indexPath];
////    cell.typeImgView.image = self.typeImg;
////    return cell;
//    
//}
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
