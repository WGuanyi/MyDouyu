//
//  FishLiveCollectionViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/20.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "FishLiveCollectionViewController.h"

@interface FishLiveCollectionViewController ()

@end

@implementation FishLiveCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // 设置cell的类型
    self.cellType = LiveCellTypeNormal;
    
    [self.collectionView.mj_header beginRefreshing];
}

- (void)refreshData {
    self.offset = 0;
    __block NSString *url = [NSString stringWithFormat:@"http://capi.douyucdn.cn/api/v1/getColumnRoom/10?aid=ios&client_sys=ios&limit=20&offset=%d&time=1469015520&auth=19d9ee69d294976b98b90b67a2ca9f94", self.offset];
    self.lastUrl = url;
    [self.collectionView.mj_footer resetNoMoreData];
    [[HTTPManager sharedInstance] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![self.lastUrl isEqualToString:url]) {
            return ;
        }
        // 删除之前的所有元素
        [self.rooms removeAllObjects];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *roomsDict = dict[@"data"];
        NSArray *rooms = [MyRoom mj_objectArrayWithKeyValuesArray:roomsDict];
        [self.rooms addObjectsFromArray:rooms];
        
        
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData {
    self.offset += 20;
    __block NSString *url = [NSString stringWithFormat:@"http://capi.douyucdn.cn/api/v1/getColumnRoom/10?aid=ios&client_sys=ios&limit=20&offset=%d&time=1469015520&auth=19d9ee69d294976b98b90b67a2ca9f94", self.offset];
    self.lastUrl = url;
    
    [[HTTPManager sharedInstance] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![self.lastUrl isEqualToString:url]) {
            return ;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *roomsDict = dict[@"data"];
        NSArray *newRooms = [MyRoom mj_objectArrayWithKeyValuesArray:roomsDict];
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", [self.rooms[indexPath.item] room_name]);
    // 播放视频
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

@end
