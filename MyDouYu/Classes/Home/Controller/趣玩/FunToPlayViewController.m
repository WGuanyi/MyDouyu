//
//  FunToPlayViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/6.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "FunToPlayViewController.h"
#import "MyRoom.h"
#import "MyCollectionViewCell.h"
#import "LivePlayViewController.h"

@interface FunToPlayViewController ()

@property (nonatomic,strong) NSMutableArray *datas;

@property (nonatomic,assign) int offset;

@property (nonatomic,copy) NSString *lastUrl;

@end

@implementation FunToPlayViewController

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"funToPlayCell"];
    [self setupRefresh];
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 90, 0);
}

- (void)setupRefresh {
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

- (void)refreshData{
    self.offset = 0;
    __block NSString *url = [NSString stringWithFormat:@"http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=20&client_sys=ios&offset=%d", self.offset];
    self.lastUrl = url;
    [self.collectionView.mj_footer resetNoMoreData];
    [[HTTPManager sharedInstance] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![self.lastUrl isEqualToString:url]) {
            return ;
        }
        [self.datas removeAllObjects];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *roomDic = dic[@"data"];
        NSArray *rooms = [MyRoom mj_objectArrayWithKeyValuesArray:roomDic];
        [self.datas addObjectsFromArray:rooms];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData {
    self.offset += 20;
    __block NSString *url = [NSString stringWithFormat:@"http://capi.douyucdn.cn/api/v1/getColumnRoom/3?limit=20&client_sys=ios&offset=%d",self.offset];
    self.lastUrl = url;
    
    [[HTTPManager sharedInstance] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![self.lastUrl isEqualToString:url]) {
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *roomDic = dic[@"data"];
        NSArray *rooms = [MyRoom mj_objectArrayWithKeyValuesArray:roomDic];
        [self.datas addObjectsFromArray:rooms];
        [self.collectionView reloadData];
        
        if (rooms.count == 0) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.offset -= 20;
        [self.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"funToPlayCell" forIndexPath:indexPath];
    cell.room = self.datas[indexPath.item];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(ItemMargin, ItemMargin, -44 + ItemMargin, ItemMargin);
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LivePlayViewController *playVc = [[LivePlayViewController alloc] init];
    [self.navigationController pushViewController:playVc animated:YES];
}
@end
