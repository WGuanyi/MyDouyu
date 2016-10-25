//
//  MyFaceCollectionViewCell.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/9.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "MyFaceCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@interface MyFaceCollectionViewCell ()

/**
 *  房间ImageView
 */
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  当前在线的人数
 */
@property (weak, nonatomic) IBOutlet UILabel *onlinePeopleLabel;

/**
 *  标题
 */
@property (strong, nonatomic) IBOutlet UILabel *roomNameLabel;
/**
 *  位置
 */
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation MyFaceCollectionViewCell

- (void)awakeFromNib {

    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;
    
    self.onlinePeopleLabel.layer.cornerRadius = 3;
    self.onlinePeopleLabel.layer.masksToBounds = YES;
    
    [super awakeFromNib];
}

- (void)setRoom:(MyRoom *)room {
    _room = room;
    
    /**
     *  房间图片
     */
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:room.room_src] placeholderImage:[UIImage imageNamed:@"live_cell_default_phone_103x103_"]];
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    /**
     *  房间名
     */
    self.roomNameLabel.text = room.room_name;
    
    /**
     *  在线数量
     */
    int onlineNumber = room.online.intValue;
    if (onlineNumber < 10000) {
        self.onlinePeopleLabel.text = [NSString stringWithFormat:@"%@人在线",room.online];
    } else {
        self.onlinePeopleLabel.text = [NSString stringWithFormat:@"%0.1f万人在线",[room.online doubleValue]/10000];
    }
    
    /**
     *  位置
     */
    if (room.anchor_city) {
        self.locationLabel.text = room.anchor_city;
    } else {
        self.locationLabel.text = @"斗鱼直播";
    }
}

@end
