//
//  FocusViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/12.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "FocusViewController.h"
#import "OnLiveCollectionViewController.h"
#import "NotStartCollectionViewController.h"

@interface FocusViewController ()

@end

@implementation FocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"关注";
    
    //设置title颜色
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self setupScrollContent];
    
    [self setupChildVc];
    
    //设置状态栏为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)setupScrollContent {
    
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor, BOOL *isUnderLineEqualTitleWidth) {
        
        *isUnderLineDelayScroll = YES;
        
        *underLineColor = [UIColor colorWithRed:RSLRed green:RSLGreen blue:RSLBlue alpha:1.0];
        
    }];
    
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        *norColor = [UIColor colorWithRed:NormalColorRGB green:NormalColorRGB blue:NormalColorRGB alpha:1.0];
        *selColor = [UIColor colorWithRed:RSLRed green:RSLGreen blue:RSLBlue alpha:1.0];
        
        *titleColorGradientStyle = YZTitleColorGradientStyleRGB;
    }];
}
/**
 *  添加子控制器
 */
- (void)setupChildVc {
    // 直播中
    [self addChildVc:[OnLiveCollectionViewController class] title:@"直播中"];
    
    // 未开播
    [self addChildVc:[NotStartCollectionViewController class] title:@"未开播"];
}

- (void)addChildVc:(Class)vcClass title:(NSString *)title {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = ItemMargin;
    layout.minimumInteritemSpacing = ItemMargin;
    
    UICollectionViewController *vc = [[vcClass alloc] initWithCollectionViewLayout:layout];
    vc.title = title;
    [self addChildViewController:vc];
}

@end
