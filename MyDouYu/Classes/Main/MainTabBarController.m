//
//  MainTabBarController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/5.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "HomeViewController.h"
#import "LiveViewController.h"
#import "FocusViewController.h"
#import "MineViewController.h"
#import "LivePlayViewController.h"

#define TabBarTintColor MyColor(244, 89, 27)

@interface MainTabBarController ()

@end

@implementation MainTabBarController

+ (void)initialize {
    [UITabBar appearance].tintColor = TabBarTintColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化子控制器
    [self setupChildViewControllers];
    
    self.selectedIndex = 0;
}
- (void)setupChildViewControllers {
    // 首页
    HomeViewController *homeVc = [[HomeViewController alloc] init];
    [self addChildVcWithTitle:@"首页" vc:homeVc imageName:@"btn_home_normal_24x24_" selImageName:@"btn_home_selected_24x24_"];
    
    // 直播
    LiveViewController *liveVc = [[LiveViewController alloc] init];
    [liveVc setUpContentViewFrame:^(UIView *contentView) {
        contentView.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
    }];
    [self addChildVcWithTitle:@"直播" vc:liveVc imageName:@"btn_column_normal_24x24_" selImageName:@"btn_column_selected_24x24_"];
    
    // 关注
    FocusViewController *focusOnVc = [[FocusViewController alloc] init];
    [self addChildVcWithTitle:@"关注" vc:focusOnVc imageName:@"btn_live_normal_30x24_" selImageName:@"btn_live_selected_30x24_"];
    
    // 我的
    MineViewController *meVc = [[MineViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self addChildVcWithTitle:@"我的" vc:meVc imageName:@"btn_user_normal_24x24_" selImageName:@"btn_user_selected_24x24_"];
}

- (void)addChildVcWithTitle:(NSString *)title vc:(UIViewController *)vc imageName:(NSString *)imageName selImageName:(NSString *)selImageName {
    [vc.tabBarItem setTitle:title];
    [vc.tabBarItem setImage:[UIImage imageNamed:imageName]];
    [vc.tabBarItem setSelectedImage:[UIImage imageNamed:selImageName]];
    MainNavigationController *navVc = [[MainNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:navVc];
}

// 哪些页面支持自动转屏
- (BOOL)shouldAutorotate{
    
    UINavigationController *nav = self.viewControllers[self.selectedIndex];
    
    if ([nav.topViewController isKindOfClass:[LivePlayViewController class]]) {
        return YES;
    }
    return NO;
}

/**
 *  viewcontroller支持哪些转屏方向
 */
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    UINavigationController *nav = self.viewControllers[self.selectedIndex];
    if ([nav.topViewController isKindOfClass:[LivePlayViewController class]]) {
        LivePlayViewController *liveVc = (LivePlayViewController *)nav.topViewController;
        // 判断如果直播控制器点击了，锁定屏幕的话，就禁止竖屏
        if (liveVc.isLock) {
            return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
        }
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    // 其他页面
    return UIInterfaceOrientationMaskPortrait;
}

@end
