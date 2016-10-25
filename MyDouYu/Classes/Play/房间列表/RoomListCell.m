//
//  RoomListCell.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/17.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "RoomListCell.h"
@interface RoomListCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *roomNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *onlinePeopleLabel;

@end
@implementation RoomListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:@"https://rpic.douyucdn.cn/z1608/05/18/424559_160805181731.jpg"]];
}

- (void)setRoom:(MyRoom *)room {
    _room = room;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:room.room_src]];
    self.roomNameLabel.text = room.room_name;
    
    int onlineNumber = room.online.intValue;
    if (onlineNumber < 10000) {
        self.onlinePeopleLabel.text = room.online;
    } else {
        self.onlinePeopleLabel.text = [NSString stringWithFormat:@"%0.1f万",[room.online doubleValue] / 10000];
    }
}

@end
