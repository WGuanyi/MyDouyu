//
//  PhoneLiveCollectionViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/20.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "PhoneLiveCollectionViewController.h"
#import "LiveTopView.h"
#import "LiveDownView.h"
#import "MyTag.h"


@interface PhoneLiveCollectionViewController () <LiveTopViewDelegate>

@property (nonatomic,weak) LiveTopView *topView;

@property (nonatomic,weak) LiveDownView *downView;

@property (nonatomic,copy) NSString *url;

/**
 *  存储当前的标签
 */
@property (nonatomic,strong) MyTag *tag;
@end

@implementation PhoneLiveCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"YCAdCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"adCell"];
    
    // 设置cell的类型
    self.cellType = LiveCellTypeNormal;
    
    self.collectionView.contentInset = UIEdgeInsetsMake(50, 0, 50, 0);
    
    // 第一次进来加载全部
    [self liveTopView:nil didClickButtonTitle:nil];
    
    [self.collectionView.mj_header beginRefreshing];
}

- (void)refreshData {
    [self loadNewData];
    if (self.topView == nil) {
        // 加载顶部的数据
        [self loadAllGameData];
    }
}

- (void)loadNewData {
    self.offset = 0;
    __block NSString *url = self.url;
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
    __block NSString *url = self.url;
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

- (void)loadAllGameData {
    NSString *path = @"http://capi.douyucdn.cn/api/v1/getHotRoom/9?aid=ios&client_sys=ios&time=1468825800&auth=94d0ae945c16542cc6dee7fe031f1316";
    [[HTTPManager sharedInstance] GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *tagsDict = dict[@"data"];
        NSMutableArray *array = [NSMutableArray arrayWithArray:[MyTag mj_objectArrayWithKeyValuesArray:tagsDict]];
        [array removeObjectAtIndex:0];
        
        // 添加顶部的scrollView
        LiveTopView *topView = [[LiveTopView alloc] init];
        topView.topViewDelegate = self;
        topView.frame = CGRectMake(0, 0, self.view.width, 50);
        [self.view addSubview:topView];
        self.topView = topView;
        
        self.topView.tags = array;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", [self.rooms[indexPath.item] room_name]);
    // 发出添加到常用的通知
    if (self.tag != nil) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addTag" object:nil userInfo:@{@"tag" : self.tag}];
    }
    // 播放视频
    [super collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

#pragma mark YCLiveTopViewDelegate
- (void)liveTopView:(LiveTopView *)topView didClickButtonTagNumber:(NSInteger)tagNumber {
    NSString *url = [NSString stringWithFormat:@"http://capi.douyucdn.cn/api/v1/live/%ld?aid=ios&client_sys=ios&limit=20&offset=%d&time=1469009040&auth=411b9ed1d270efe90e260391e0a93d62", tagNumber, self.offset];
    self.url = url;
    // 存储当前的标签
    for (MyTag *tag in self.topView.tags) {
        if (tag.tag_id.integerValue == tagNumber) {
            self.tag = tag;
            break;
        }
    }
    [self.collectionView.mj_header beginRefreshing];
}

- (void)liveTopView:(LiveTopView *)topView didClickButtonTitle:(NSString *)title {
    NSString *url = [NSString stringWithFormat:@"http://capi.douyucdn.cn/api/v1/getColumnRoom/9?aid=ios&client_sys=ios&limit=20&offset=%d&time=1469008980&auth=3392837008aa8938f7dce0d8c72c321d",self.offset];
    self.url = url;
    [self.collectionView.mj_header beginRefreshing];
}
@end
