//
//  LiveCollectionViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/19.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "LiveCollectionViewController.h"
#import "LivePlayViewController.h"
#import "NoDataView.h"

@interface LiveCollectionViewController ()

@property (nonatomic, strong) NoDataView *noDataView;

@end

@implementation LiveCollectionViewController

- (NoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [NoDataView noDataView];
        _noDataView.frame = self.view.bounds;
    }
    return _noDataView;
}

- (NSMutableArray *)rooms{
    if (!_rooms) {
        _rooms = [NSMutableArray array];
    }
    return _rooms;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyFaceCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"faceCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionViewCell"];
    
    [self setupRefresh];
    [self.collectionView addSubview:self.noDataView];
}

- (void)setupRefresh {
#pragma mark 留给子类实现 refreshData 和 loadMoreData方法
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [header setImages:@[[UIImage imageNamed:@"dyla_img_mj_stateIdle_64x66_"]] forState:MJRefreshStateIdle];
    [header setImages:@[[UIImage imageNamed:@"dyla_img_mj_statePulling_64x66_"]] forState:MJRefreshStatePulling];
    [header setImages:@[[UIImage imageNamed:@"dyla_img_mj_stateRefreshing_01_135x66_"],
                        [UIImage imageNamed:@"dyla_img_mj_stateRefreshing_02_135x66_"],
                        [UIImage imageNamed:@"dyla_img_mj_stateRefreshing_03_135x66_"],
                        [UIImage imageNamed:@"dyla_img_mj_stateRefreshing_04_135x66_"]] duration:0.5 forState:MJRefreshStateRefreshing];
    [header setTimeLabelHidden:YES forState:MJRefreshStateRefreshing];
    self.collectionView.mj_header = header;
    
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark <UICollectionViewDataSource>

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    self.noDataView.hidden = !(self.rooms.count==0);
    return self.rooms.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellType == LiveCellTypeFaceLevel) {
        MyFaceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"faceCollectionViewCell" forIndexPath:indexPath];
        cell.room = self.rooms[indexPath.item];
        return cell;
    }else{
        MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
        cell.room = self.rooms[indexPath.item];
        return cell;
    }
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LivePlayViewController *playVc = [[LivePlayViewController alloc]init];
    [self.navigationController pushViewController:playVc animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (self.cellType == LiveCellTypeFaceLevel) {
        return CGSizeMake(NormalItemW, FaceItemH);
    }else{
        return CGSizeMake(NormalItemW, NormalItemH);
    }
}

- (UIEdgeInsets)collectionView: (UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(ItemMargin, ItemMargin, -44 + ItemMargin, ItemMargin);
}

@end
