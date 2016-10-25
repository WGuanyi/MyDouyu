//
//  MainNavigationController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/5.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "MainNavigationController.h"
#import "LivePlayViewController.h"
@interface MainNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation MainNavigationController

+ (void)initialize {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    如果滑动移除控制器的功能失效，清空代理（让控制器重新设置这个功能）
    //    self.interactivePopGestureRecognizer.delegate = nil;
    
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
    
    popRecognizer.delegate = self;
    popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:popRecognizer];
    
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    /**
     *  获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
     */
    id gestureRecognizerTarget = [_targets firstObject];
    /**
     *  获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
     */
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    /**
     *  通过前面的打印，我们从控制台获取出来它的方法签名。
     */
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    /**
     *  创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
     */
    [popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
    /**
     *  修改导航栏的颜色
     */
    self.navigationBar.barTintColor = [UIColor orangeColor];
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    if ([gestureRecognizer translationInView:gestureRecognizer.view].x < 0 || [gestureRecognizer translationInView:gestureRecognizer.view].y > 0 || [gestureRecognizer translationInView:gestureRecognizer.view].y < 0) {
        return NO;
    }
    
    if ([self.topViewController isKindOfClass:[LivePlayViewController class]]) {
        return NO;
    }
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) { // push进来的不是第一个子控制器
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        backBtn.bounds = CGRectMake(0, 0, 70, 30);
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
    }
    
    // 调用super的push方法放到后面，让viewcontroller可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
