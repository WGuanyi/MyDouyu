//
//  LiveViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/12.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "LiveViewController.h"
#import "CommonViewController.h"
#import "AllLiveCollectionViewController.h"
#import "HotLiveCollectionViewController.h"
#import "PhoneLiveCollectionViewController.h"
#import "EntertainmentLiveViewController.h"
#import "FishLiveCollectionViewController.h"
#import "FaceLiveCollectionViewController.h"
#import "ScienceLiveCollectionViewController.h"
#import "CultureLiveCollectionViewController.h"
#import "SportsLiveCollectionViewController.h"


@interface LiveViewController ()

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupScrollContent];
    [self setChildVc];
    
    //设置状态栏为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    /**
     *  设置状态栏背景颜色
     */
    UIView *statusBarView = [[UIView alloc]init];
    statusBarView.backgroundColor = [UIColor orangeColor];
    statusBarView.frame = CGRectMake(0, -20, self.view.size.width, 20);
    [self.contentView addSubview:statusBarView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //滚动条背景颜色
    self.titleScrollViewColor = [UIColor orangeColor];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)setupScrollContent{
    
    //设置下划线
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        *isUnderLineDelayScroll = YES;
        *underLineColor = [UIColor whiteColor];
    }];
    //设置标题长度
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        *norColor = [UIColor colorWithRed:210 green:210 blue:210 alpha:1.0];
        *selColor = [UIColor whiteColor];
        *titleColorGradientStyle = YZTitleColorGradientStyleRGB;
    }];
}

- (void)setChildVc{
    CommonViewController *vc = [[CommonViewController alloc]init];
    vc.title = @"常用";
    [self addChildViewController:vc];
    
    [self addChildVc:[AllLiveCollectionViewController class] title:@"全部"];
    [self addChildVc:[HotLiveCollectionViewController class] title:@"热门游戏"];
    [self addChildVc:[PhoneLiveCollectionViewController class] title:@"手游休闲"];
    [self addChildVc:[EntertainmentLiveViewController class] title:@"鱼乐星天地"];
    [self addChildVc:[FishLiveCollectionViewController class] title:@"鱼秀"];
    [self addChildVc:[FaceLiveCollectionViewController class] title:@"颜值"];
    [self addChildVc:[ScienceLiveCollectionViewController class] title:@"科技"];
    [self addChildVc:[CultureLiveCollectionViewController class] title:@"文娱课堂"];
    [self addChildVc:[SportsLiveCollectionViewController class] title:@"体育频道"];
}

- (void)addChildVc:(Class)classVc title:(NSString *)title {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = ItemMargin;
    layout.minimumInteritemSpacing = ItemMargin;
    
    UICollectionViewController *vc = [[classVc alloc] initWithCollectionViewLayout:layout];
    vc.title = title;
    [self addChildViewController:vc];
}

@end
