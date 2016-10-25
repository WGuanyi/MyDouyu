//
//  EntainmentViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/6.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "EntainmentViewController.h"
#import "MyRoom.h"
#import "MyRoomGroup.h"
#import "MyTag.h"
#import "MyRecommendHeaderView.h"
#import "MyRecommendCell.h"
#import "MyGameVerticalButton.h"
#import "LivePlayViewController.h"

@interface EntainmentViewController () <UIScrollViewDelegate>
@property (nonatomic, weak)UIScrollView *topScrollView;
@property (nonatomic, strong)NSMutableArray *tags;
@property (nonatomic, weak)UIPageControl *pageControl;
@end

@implementation EntainmentViewController

-(NSMutableArray *)tags{
    if (!_tags){
        _tags = [NSMutableArray array];
    }
    return _tags;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *baseView = [[UIView alloc]init];
    baseView.backgroundColor = MyColor(233, 233, 233);
    baseView.frame = CGRectMake(0, 0, self.view.width, 210);
    
    UIScrollView *topScrollView = [[UIScrollView alloc]init];
    topScrollView.frame = CGRectMake(0, 0, self.view.width, 200);
    topScrollView.backgroundColor = [UIColor whiteColor];
    topScrollView.pagingEnabled = YES;
    topScrollView.showsHorizontalScrollIndicator = NO;
    topScrollView.delegate = self;
    [baseView addSubview:topScrollView];
    self.topScrollView = topScrollView;
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.frame = CGRectMake(0,185,self.view.width,10);
    [baseView addSubview:pageControl];
    self.pageControl = pageControl;
    
    self.tableView.tableHeaderView = baseView;
    
    [self setupRefresh];
    
    [self.tableView registerClass:[MyRecommendCell class] forCellReuseIdentifier:@"recommendCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    
    [self.tableView.mj_header beginRefreshing];
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

- (void)refreshData{
    [self loadAllData];
}

- (void)loadAllData{
    NSString *path = @"http://capi.douyucdn.cn/api/v1/getHotRoom/2?aid=ios&client_sys=ios&time=1473733020&auth=5a284ada37a7a6236e72903390ff20d9";
    [[HTTPManager sharedInstance] GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.tags removeAllObjects];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *roomsDic = dic[@"data"];
        NSArray *tags = [MyTag mj_objectArrayWithKeyValuesArray:roomsDic];
        for (int i = 0; i<tags.count; i++) {
            MyTag *tag = tags[i];
            if ([tag.tag_name isEqualToString:@"最热"]) {
                tag.groupImageName = @"home_header_hot_18x18_";
            }else{
                tag.groupImageName = @"home_header_normal_18x18_";
            }
            [self.tags addObject:tag];
        }
        [self setupScrollViewData];
        
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)setupScrollViewData{
    CGFloat btnW = 70;
    CGFloat btnH = 80;
    CGFloat leftMargin = 10;
    CGFloat btnMargin = (self.view.width - 4 * btnW - 2 * leftMargin) / 3;
    NSArray *newTags = [self.tags subarrayWithRange:NSMakeRange(1, self.tags.count - 1)];
    for (int i = 0; i<newTags.count; i++) {
        MyTag *tag = newTags[i];
        int j = i/8;
        MyGameVerticalButton *btn = [[MyGameVerticalButton alloc]init];
        CGFloat btnX = j * self.view.width + 10 + (i % 4 * (btnW + btnMargin));
        CGFloat btnY = 10 + (i / 4 * (btnH + 10)) - j * 2 * (btnH + 10);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitle:tag.tag_name forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:tag.icon_url] forState:UIControlStateNormal];
        [self.topScrollView addSubview:btn];
    }
    self.pageControl.numberOfPages = (newTags.count + 8 - 1) / 8;
    self.pageControl.currentPage = 0;
    
    self.topScrollView.contentSize = CGSizeMake(self.view.width * ((newTags.count + 8 - 1) / 8), 0);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tags.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell"];
    cell.rooms = [self.tags[indexPath.section] room_list];
    // 用来判断是不是颜值分组
    cell.groupName = [self.tags[indexPath.section] groupImageName];
    __weak EntainmentViewController *weakSelf = self;
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
    view.tagName = [self.tags[section] tag_name];
    view.imageName = [self.tags[section] groupImageName];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 房间的总数量
    int count = (int)[self.tags[indexPath.section] room_list].count;
    // 判断有多少行
    int rols = (count + 2 - 1) / 2;
    // cell的高度
    CGFloat height = 0;
    height = rols * NormalItemH + (rols) * ItemMargin + 5;
    return height;
}

#pragma mark UIScrolViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrolW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrolW * 0.5) / scrolW;
    self.pageControl.currentPage = page;
}

@end
