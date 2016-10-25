//
//  RoomListView.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/17.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "RoomListView.h"
#import "RoomListCell.h"


@interface RoomListView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak)UITableView *tableView;
@end
@implementation RoomListView
- (instancetype)init {
    if (self = [super init]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:tableView];
        
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerNib:[UINib nibWithNibName:@"RoomListCell" bundle:nil] forCellReuseIdentifier:@"roomListCell"];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView = tableView;
        
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
        }];
    }
    return self;
}

-(void)setRooms:(NSArray *)rooms{
    _rooms = rooms;
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RoomListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"roomListCell"];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyRoom *room = [[MyRoom alloc] init];
    room.room_id = [NSString stringWithFormat:@"%ld", indexPath.row];
    if ([self.delegate respondsToSelector:@selector(roomListView:didSelectRoom:)]) {
        [self.delegate roomListView:self didSelectRoom:room];
    }
}

@end
