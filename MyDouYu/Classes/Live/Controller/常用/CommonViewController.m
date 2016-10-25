//
//  CommonViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/21.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "CommonViewController.h"
#import "MyTag.h"
#import "LiveDownButtonView.h"
#import "LivePlayViewController.h"


#define TagsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tags.data"]

@interface CommonViewController ()

@property (nonatomic,strong) NSMutableArray *inCommonTags;

@property (nonatomic,weak) UIScrollView *baseScrollView;

@end

@implementation CommonViewController
- (NSMutableArray *)inCommonTags {
    if (!_inCommonTags) {
        _inCommonTags = [NSMutableArray array];
    }
    return _inCommonTags;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 创建一个scrollView
    UIScrollView *baseScrollView = [[UIScrollView alloc] init];
    baseScrollView.frame = self.view.bounds;
    [self.view addSubview:baseScrollView];
    self.baseScrollView = baseScrollView;
    
    // 添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addTag:) name:@"addTag" object:nil];
    
    [self addTag:nil];
}

/**
 *  监听方法
 */
- (void)addTag:(NSNotification *)note {
    MyTag *tag = note.userInfo[@"tag"];
    NSMutableArray *tags = [NSKeyedUnarchiver unarchiveObjectWithFile:TagsPath];
    if (tags == nil) {
        tags = [NSMutableArray array];
        if (tag) {
            [tags addObject:tag];
        }
        [NSKeyedArchiver archiveRootObject:tags toFile:TagsPath];
    } else {
        for (MyTag *tag2 in tags) {
            if ([tag2 isEqual:tag]) {
                [tags removeObject:tag2];
                break;
            }
        }
        if (tag) {
            [tags insertObject:tag atIndex:0];
        }
        [NSKeyedArchiver archiveRootObject:tags toFile:TagsPath];
    }
    
    [self.baseScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    for (int i = 0; i < tags.count; i++) {
        MyTag *tag = tags[i];
        LiveDownButtonView *btn = [LiveDownButtonView liveDownButtonView];
        [btn.tagIconView sd_setImageWithURL:[NSURL URLWithString:tag.icon_url]];
        btn.tagNameLabel.text = tag.tag_name;
        [self.baseScrollView addSubview:btn];
        // 添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonViewClick:)];
        [btn addGestureRecognizer:tap];
    }
}

- (void)buttonViewClick:(UITapGestureRecognizer *)tapGest {
    LivePlayViewController *playVc = [[LivePlayViewController alloc] init];
    [self.navigationController pushViewController:playVc animated:YES];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 3;
    CGFloat btnH = btnW;
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    
    for (int i = 0; i < self.baseScrollView.subviews.count; i++) {
        LiveDownButtonView *btn = self.baseScrollView.subviews[i];
        btnX = (i) % 3 * btnW;
        btnY = (i) / 3 * btnH;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    self.baseScrollView.contentSize = CGSizeMake(0, (self.baseScrollView.subviews.count + 3 - 1) / 3 * btnH);
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
