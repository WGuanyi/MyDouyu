//
//  GameViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/6.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "GameViewController.h"
#import "MyTag.h"
#import "MyRecommendHeaderView.h"
#import "GameViewController.h"
#import "GameTableViewCell.h"
#import "MyGameVerticalButton.h"

@interface GameViewController ()
@property (nonatomic, strong)NSArray *allTags;
@property (nonatomic, strong)UIScrollView *topScrollView;
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupHeaderView];
    [self setupRefresh];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
    [self.tableView registerClass:[GameTableViewCell class] forCellReuseIdentifier:@"gameCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView.mj_header beginRefreshing];
}

-(void)setupHeaderView{
    UIView *headerView = [[UIView alloc]init];
    headerView.bounds = CGRectMake(0, 0, self.view.width, 140);
    headerView.backgroundColor = MyColor(233, 233, 233);
    
    MyRecommendHeaderView *tagView = [[MyRecommendHeaderView alloc]init];
    tagView.frame = CGRectMake(0, 0, self.view.width, 30);
    tagView.tagName = @"常用";
    tagView.imageName = @"Img_orange_3x14_";
    tagView.hideMoreBtn = YES;
    [headerView addSubview:tagView];
    
    UIScrollView *topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, self.view.width, 100)];
    topScrollView.backgroundColor = [UIColor whiteColor];
    topScrollView.showsHorizontalScrollIndicator = NO;
    [headerView addSubview:topScrollView];
    self.topScrollView = topScrollView;
    
    self.tableView.tableHeaderView = headerView;
}

- (void)setupRefresh{
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
    [self loadScrollViewData];
    
    [self loadAllGameData];
}

- (void)loadScrollViewData{
    NSString *path = @"http://capi.douyucdn.cn/api/v1/getHotCate?aid=ios&client_sys=ios&time=1468636740&auth=a326ef2a1a645e479a853e9486878776";
    [[HTTPManager sharedInstance] GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *tagDic = dic[@"data"];
        NSArray *tags = [MyTag mj_objectArrayWithKeyValuesArray:tagDic];
        CGFloat leftMargin = 10;
        CGFloat btnMargin = 15;
        CGFloat btnY = 10;
        CGFloat btnW = 70;
        CGFloat btnH = 80;
        MyGameVerticalButton *lastBtn = nil;
        for (int i = 0; i < tags.count; i++) {
            MyTag *tag = tags[i];
            MyGameVerticalButton *btn = [[MyGameVerticalButton alloc]init];
            lastBtn = btn;
            CGFloat btnX = leftMargin + (i * (btnW + btnMargin));
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            [btn setTitle:tag.tag_name forState:UIControlStateNormal];
            [btn sd_setImageWithURL:[NSURL URLWithString:tag.icon_url] forState:UIControlStateNormal];
            [self.topScrollView addSubview:btn];
            }
        self.topScrollView.contentSize = CGSizeMake(CGRectGetMaxX(lastBtn.frame) + leftMargin, 0);
        [self.tableView.mj_header endRefreshing];
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadAllGameData{
    NSString *path = @"http://capi.douyucdn.cn/api/v1/getColumnDetail?aid=ios&client_sys=ios&shortName=game&time=1468640760&auth=73e5e04ce9fc4eef33036c56707f53c5";
    [[HTTPManager sharedInstance] GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *tagDic = dic[@"data"];
        NSArray *tags = [MyTag mj_objectArrayWithKeyValuesArray:tagDic];
        self.allTags = tags;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gameCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.allTags = self.allTags;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MyRecommendHeaderView *header = [[MyRecommendHeaderView alloc]init];
    header.tagName = @"全部";
    header.hideMoreBtn = YES;
    header.backgroundColor = [UIColor whiteColor];
    header.imageName = @"Img_orange_3x14_";
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    int count = (int)self.allTags.count;
    int roles = (count+3-1)/3;
    int height = roles * (GameBtnH + 2*GameBtnMargin);
    return height;
}

@end
