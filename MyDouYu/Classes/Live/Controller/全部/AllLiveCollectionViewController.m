//
//  AllLiveCollectionViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/20.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "AllLiveCollectionViewController.h"

@interface AllLiveCollectionViewController ()

@end

@implementation AllLiveCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.cellType = LiveCellTypeNormal;
    [self.collectionView.mj_header beginRefreshing];
}

- (void)refreshData{
    self.offset = 0;
    __block NSString *url = [NSString stringWithFormat:@"http://capi.douyucdn.cn/api/v1/live?aid=ios&client_sys=ios&limit=20&offset=%d&time=1468894680&auth=848c60f9ab96f0ee866a8ab588f2e2b6", self.offset];
    self.lastUrl = url;
    [self.collectionView.mj_footer resetNoMoreData];
    [[HTTPManager sharedInstance] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![self.lastUrl isEqualToString:url]) {
            return ;
        }
        [self.rooms removeAllObjects];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *roomDic = dic[@"data"];
        NSArray *rooms = [MyRoom mj_objectArrayWithKeyValuesArray:roomDic];
        [self.rooms addObjectsFromArray:rooms];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData {
    self.offset += 20;
    __block NSString *url = [NSString stringWithFormat:@"http://capi.douyucdn.cn/api/v1/live?aid=ios&client_sys=ios&limit=20&offset=%d&time=1468894680&auth=848c60f9ab96f0ee866a8ab588f2e2b6",self.offset];
    self.lastUrl = url;
    
    [[HTTPManager sharedInstance] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![self.lastUrl isEqualToString:url]) {
            return ;
        }
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *roomDic = dic[@"data"];
        NSArray *newRooms = [MyRoom mj_objectArrayWithKeyValuesArray:roomDic];
        [self.rooms addObjectsFromArray:newRooms];
        [self.collectionView reloadData];
        
        if (newRooms.count == 0) {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.offset -= 20;
        [self.collectionView.mj_footer endRefreshing];
    }];
}

@end
