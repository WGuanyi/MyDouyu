//
//  HomeViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/5.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "HomeViewController.h"
#import "EntainmentViewController.h"
#import "RecommendViewController.h"
#import "GameViewController.h"
#import "FunToPlayViewController.h"
#import "UIBarButtonItem+My.h"

@interface HomeViewController ()

@property (nonatomic, weak) UIBarButtonItem *itemSearch;

@property (nonatomic, weak) UIBarButtonItem *itemScan;

@property (nonatomic, weak) UIBarButtonItem *itemHistory;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MyColor(223, 223, 223);
    
    //设置状态栏为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //设置导航栏
    [self setupNav];
    
    // 添加子控制器
    [self setupChildVc];
    
    // 设置滚动的内容
    [self setupScrollContent];
}

//设置导航栏

- (void)setupNav {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"white_icon@3x" highIcon:nil target:self action:@selector(updateHomeData)];
    
    UIBarButtonItem *itemScan = [UIBarButtonItem itemWithIcon:@"222" highIcon:@"Image_scan_22x22_" target:self action:@selector(scan)];
    self.itemScan = itemScan;
    
    UIBarButtonItem *itemSearch = [UIBarButtonItem itemWithIcon:@"111" highIcon:@"btn_search_22x22_" target:self action:@selector(search)];
    self.itemSearch = itemSearch;
    
    UIBarButtonItem *itemHistory = [UIBarButtonItem itemWithIcon:@"333" highIcon:@"image_my_history_26x26_" target:self action:@selector(history)];
    self.itemHistory = itemHistory;
    
    self.navigationItem.rightBarButtonItems = @[itemScan, itemSearch, itemHistory ];
    
}

    


//添加子控制器

- (void)setupChildVc {
    // 推荐
    RecommendViewController *recommendVc = [[RecommendViewController alloc] initWithStyle:UITableViewStyleGrouped];
    recommendVc.title = @"推荐";
    [self addChildViewController:recommendVc];
    
    // 游戏
    GameViewController *gameVc = [[GameViewController alloc] init];
    gameVc.title = @"游戏";
    [self addChildViewController:gameVc];
    
    // 娱乐
    EntainmentViewController *entainmentVc = [[EntainmentViewController alloc] initWithStyle:UITableViewStyleGrouped];
    entainmentVc.title = @"娱乐";
    [self addChildViewController:entainmentVc];
    
    // 趣玩
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = ItemMargin;
    flowLayout.minimumInteritemSpacing = ItemMargin;
    flowLayout.itemSize = CGSizeMake(NormalItemW, NormalItemH);
    FunToPlayViewController *funToPlayVc = [[FunToPlayViewController alloc] initWithCollectionViewLayout:flowLayout];
    funToPlayVc.title = @"趣玩";
    [self addChildViewController:funToPlayVc];
}


- (void)setupScrollContent {
    self.customLabelsWidth = [NSNumber numberWithFloat:self.view.width / self.childViewControllers.count];
    self.customMargin = [NSNumber numberWithFloat:0.00001];
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        *underLineColor = [UIColor colorWithRed:RSLRed green:RSLGreen blue:RSLBlue alpha:1.0];
    }];
    
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        *norColor = [UIColor colorWithRed:NormalColorRGB green:NormalColorRGB blue:NormalColorRGB alpha:1];
        *selColor = [UIColor colorWithRed:RSLRed green:RSLGreen blue:RSLBlue alpha:1.0];
        *titleColorGradientStyle = YZTitleColorGradientStyleRGB;
    }];
}

- (void)updateHomeData {
    NSLog(@"首页更新");
}

- (void)scan {
    NSLog(@"扫描");
}

- (void)search {
    NSLog(@"搜索");
}

- (void)history {
    NSLog(@"历史");
}
@end

