//
//  OnLiveCollectionViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/22.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "OnLiveCollectionViewController.h"


@interface OnLiveCollectionViewController ()

@end

@implementation OnLiveCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)refreshData {
    [self.collectionView.mj_header endRefreshing];
}

- (void)loadMoreData {
    [self.collectionView.mj_footer endRefreshing];
}

@end
