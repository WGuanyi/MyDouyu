//
//  RecommendViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/6.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "RecommendViewController.h"
#import "SDCycleScrollView.h"
#import "HTTPManager.h"
#import "NSString+Extension.h"
#import "MyScrollModel.h"
#import "MyTag.h"
#import "MyVerticalButton.h"
#import "MJRefresh.h"
#import <UIButton+WebCache.h>
#import "MyRoomGroup.h"
#import "MyRecommendCell.h"
#import "MyRecommendHeaderView.h"
#import "MyGameVerticalButton.h"
#import "LivePlayViewController.h"

#define CyrcleViewH 160
#define BaseViewH 260


@interface RecommendViewController () <SDCycleScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,weak) SDCycleScrollView *cycleScrollView;

@property (nonatomic,weak) UIScrollView *topScrollView;

@property (nonatomic,strong) NSArray *scrollModels;

@property (nonatomic,strong) NSMutableArray *roomGroups;

@property (nonatomic, strong)NSString *groupName;

@property (nonatomic,strong) MyRecommendHeaderView *sectionHeaderView;

@property (nonatomic, copy)NSString *path;

@end

@implementation RecommendViewController

- (MyRecommendHeaderView *)sectionHeaderView {
    if (!_sectionHeaderView) {
        _sectionHeaderView = [[MyRecommendHeaderView alloc] init];
        _sectionHeaderView.bounds = CGRectMake(0, 0, self.view.width, 30);
    }
    return _sectionHeaderView;
}

- (NSMutableArray *)roomGroups {
    if (!_roomGroups) {
        _roomGroups = [NSMutableArray array];
    }
    return _roomGroups;
}

- (NSArray *)createAllGroup {
    MyRoomGroup *roomGroup1 = [[MyRoomGroup alloc] init];
    roomGroup1.groupName = @"最热";
    roomGroup1.groupImage = @"home_header_hot_18x18_";
    
    MyRoomGroup *roomGroup2 = [[MyRoomGroup alloc] init];
    roomGroup2.groupName = @"颜值";
    roomGroup2.groupImage = @"home_header_phone_18x18_";

    MyRoomGroup *roomGroup3 = [[MyRoomGroup alloc] init];
    roomGroup3.groupName = @"炉石传说";
    roomGroup3.groupImage = @"home_header_normal_18x18_";
    
    MyRoomGroup *roomGroup4 = [[MyRoomGroup alloc] init];
    roomGroup4.groupName = @"星际争霸";
    roomGroup4.groupImage = @"home_header_normal_18x18_";
    
    MyRoomGroup *roomGroup5 = [[MyRoomGroup alloc] init];
    roomGroup5.groupName = @"英雄联盟";
    roomGroup5.groupImage = @"home_header_normal_18x18_";
    
    MyRoomGroup *roomGroup6 = [[MyRoomGroup alloc] init];
    roomGroup6.groupName = @"美食";
    roomGroup6.groupImage = @"home_header_normal_18x18_";
    
    MyRoomGroup *roomGroup7 = [[MyRoomGroup alloc] init];
    roomGroup7.groupName = @"星秀";
    roomGroup7.groupImage = @"home_header_normal_18x18_";
    
    MyRoomGroup *roomGroup8 = [[MyRoomGroup alloc] init];
    roomGroup8.groupName = @"海外";
    roomGroup8.groupImage = @"home_header_normal_18x18_";
    
    MyRoomGroup *roomGroup9 = [[MyRoomGroup alloc] init];
    roomGroup9.groupName = @"小鲜肉";
    roomGroup9.groupImage = @"home_header_normal_18x18_";
    
    MyRoomGroup *roomGroup10 = [[MyRoomGroup alloc] init];
    roomGroup10.groupName = @"皇室战争";
    roomGroup10.groupImage = @"home_header_normal_18x18_";
    
    MyRoomGroup *roomGroup11 = [[MyRoomGroup alloc] init];
    roomGroup11.groupName = @"生活秀";
    roomGroup11.groupImage = @"home_header_normal_18x18_";
    
    MyRoomGroup *roomGroup12 = [[MyRoomGroup alloc] init];
    roomGroup12.groupName = @"鱼秀";
    roomGroup12.groupImage = @"home_header_normal_18x18_";
    
    return @[ roomGroup1,
              roomGroup2,
              roomGroup3,
              roomGroup4,
              roomGroup5,
              roomGroup6,
              roomGroup7,
              roomGroup8,
              roomGroup9,
              roomGroup10,
              roomGroup11,
              roomGroup12 ];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = MyColor(233, 233, 233);
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    
    [self setupTop];
    
    [self.tableView registerClass:[MyRecommendCell class] forCellReuseIdentifier:@"recommendCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupRefresh];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)setupTop {
    
    UIView *topBaseView = [[UIView alloc] init];
    topBaseView.backgroundColor = MyColor(233, 233, 233);
    topBaseView.frame = CGRectMake(0, 0, self.view.width, BaseViewH);
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.width, CyrcleViewH) delegate:self placeholderImage:[UIImage imageNamed:@"live_cell_default_phone_103x103_"]];
    cycleScrollView.currentPageDotColor = [UIColor orangeColor];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    [topBaseView addSubview:cycleScrollView];
    self.cycleScrollView = cycleScrollView;
    
    UIScrollView *topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CyrcleViewH, self.view.width, BaseViewH - CyrcleViewH - 10)];
    topScrollView.backgroundColor = [UIColor whiteColor];
    [topBaseView addSubview:topScrollView];
    topScrollView.showsHorizontalScrollIndicator = NO;
    self.topScrollView = topScrollView;
    
    self.tableView.tableHeaderView = topBaseView;
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
    self.tableView.mj_header = header;
}

- (void)refreshData {

    [self loadCyrcleViewData];
    
    [self loadScrollViewData];
    
    [self loadHotData];
}

- (void)loadHotData {
    //最热
    NSString *path1 = @"http://capi.douyucdn.cn/api/v1/live?limit=20&client_sys=ios&offset=0";
    [[HTTPManager sharedInstance] GET:path1 parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.roomGroups removeAllObjects];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *roomsDic = dic[@"data"];
        NSArray *rooms = [MyRoom mj_objectArrayWithKeyValuesArray:roomsDic];
        [self.roomGroups addObjectsFromArray:[self createAllGroup]];
        for (int i = 0; i < self.roomGroups.count; i++) {
            MyRoomGroup *rg = self.roomGroups[i];
            if (rooms.count == 0) {
                continue;
            }
            if (i == 0) {
                rg.rooms = [rooms objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 8)]];
            } else {
                rg.rooms = [rooms objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 4)]];
            }
        }
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}

- (void)loadCyrcleViewData {
    NSDictionary *params = @{ @"aid" : @"ios",
                              @"auth" : @"97d9e4d3e9dfab80321d11df5777a107",
                              @"client_sys" : @"ios",
                              @"time" : [NSString GetNowTimes]
                              };
    NSString *path = @"http://capi.douyucdn.cn/api/v1/slide/6?version=2.292&client_sys=ios";
    [[HTTPManager sharedInstance] GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *topModels = [MyScrollModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
        NSMutableArray *imageUrls = [NSMutableArray array];
        for (int i = 0; i < topModels.count; i++) {
            [imageUrls  addObject:[topModels[i] pic_url]];
        }
        
        self.cycleScrollView.imageURLStringsGroup = imageUrls;
        self.scrollModels = topModels;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)loadScrollViewData {
    NSString *path = @"http://capi.douyucdn.cn/api/v1/getHotCate?aid=ios&client_sys=ios&time=1473685020&auth=e9a622dfdad7844a305b26cd6e5e9146";
    [[HTTPManager sharedInstance] GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *tagsDict = dict[@"data"];
        NSArray *tags = [MyTag mj_objectArrayWithKeyValuesArray:tagsDict];
        CGFloat leftMargin = 10;
        CGFloat btnMargin = 10;
        CGFloat btnY = 10;
        CGFloat btnW = 70;
        CGFloat btnH = 70;
        MyGameVerticalButton *lastBtn = nil;
        for (int i = 0; i < tags.count; i++) {
            MyTag *tag = tags[i];
            MyGameVerticalButton *btn = [[MyGameVerticalButton alloc] init];
            lastBtn = btn;
            CGFloat btnX = leftMargin + (i * (btnW + btnMargin));
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            [btn setTitle:tag.tag_name forState:UIControlStateNormal];
            [btn sd_setImageWithURL:[NSURL URLWithString:tag.icon_url] forState:UIControlStateNormal];
            [self.topScrollView addSubview:btn];
        }
        
        MyGameVerticalButton *moewBtn = [[MyGameVerticalButton alloc] init];
        CGFloat btnX = CGRectGetMaxX(lastBtn.frame) + btnMargin;
        moewBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [moewBtn setTitle:@"更多" forState:UIControlStateNormal];
        [moewBtn setImage:[UIImage imageNamed:@"btn_v_more_34x34_"] forState:UIControlStateNormal];
        [self.topScrollView addSubview:moewBtn];
        
        self.topScrollView.contentSize = CGSizeMake(CGRectGetMaxX(moewBtn.frame) + leftMargin, 0);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.roomGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell"];

    cell.rooms = [self.roomGroups[indexPath.section] rooms];
    cell.backgroundColor = [UIColor orangeColor];
    // 用来判断是不是颜值分组
    cell.groupName = [self.roomGroups[indexPath.section] groupName];
    __weak RecommendViewController *weakSelf = self;
    // 播放视频
    cell.block = ^(MyRoom *room) {
    LivePlayViewController *playVc = [[LivePlayViewController alloc] init];
    [weakSelf.navigationController pushViewController:playVc animated:YES];
    };
    return cell;
}

/**
 *  必须返回高度，headerInsection方法才会调用
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MyRecommendHeaderView *view = [[MyRecommendHeaderView alloc] init];
    view.tagName = [self.roomGroups[section] groupName];
    view.imageName = [self.roomGroups[section] groupImage];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 房间的总数量
    int count = (int)[self.roomGroups[indexPath.section] rooms].count;
    // 判断有多少行
    int rols = (count + 2 - 1) / 2;
    // cell的高度
    CGFloat height = 0;
    if ([[self.roomGroups[indexPath.section] groupName] isEqualToString:@"颜值"]) {
        height = rols * FaceItemH + (rols) * ItemMargin + 5;
    } else {
        height = rols * NormalItemH + (rols) * ItemMargin + 5;
    }
    return height;
}


#pragma mark SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    LivePlayViewController *playVc = [[LivePlayViewController alloc] init];
    [self.navigationController pushViewController:playVc animated:YES];
}


@end
