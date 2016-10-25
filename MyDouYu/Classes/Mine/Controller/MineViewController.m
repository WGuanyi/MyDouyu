//
//  MineViewController.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/26.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "MineViewController.h"
#import "HeaderView.h"
#import "MineTableViewCell.h"
#import "StartRemindViewController.h"
#import "TicketCenterViewController.h"
#import "GameCenterViewController.h"

@interface MineViewController ()

@property (nonatomic,strong) NSArray *resources;

@end

@implementation MineViewController
- (NSArray *)resources {
    if (!_resources) {
        _resources = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mine.plist" ofType:nil]];
    }
    return _resources;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 不要自动调整scrollView的边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tableView.bounces = NO;
    
    HeaderView *headerView = [[HeaderView alloc] init];
    headerView.frame = CGRectMake(0, 0, self.view.width, 295);
    self.tableView.tableHeaderView = headerView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:@"mineCell"];
    
    //设置状态栏为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.resources.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.resources[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineCell"];
    cell.dict = self.resources[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self.navigationController pushViewController:[[cell.targetClass alloc] init] animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

@end
