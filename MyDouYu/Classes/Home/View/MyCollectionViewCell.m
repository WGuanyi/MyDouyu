//
//  MyCollectionViewCell.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/9.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import <UIImageView+WebCache.h>
@interface MyCollectionViewCell ()
/**
 *  房间ImageView
 */
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

/**
 *  主播名字
 */
@property (strong, nonatomic) IBOutlet UILabel *nickNameLabel;

/**
 *  在线人数
 */
@property (strong, nonatomic) IBOutlet UILabel *onlinePeople;

/**
 *  标题
 */
@property (strong, nonatomic) IBOutlet UILabel *roomNameLabel;

@end

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.layer.cornerRadius = 5;
    self.imageView.layer.masksToBounds = YES;
}

- (void)setRoom:(MyRoom *)room{
    _room = room;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:room.room_src] placeholderImage:[UIImage imageNamed: @"live_cell_default_phone_103x103_"]];
    self.roomNameLabel.text = room.room_name;
    self.nickNameLabel.text = room.nickname;
    
    int onlineNumbers = room.online.intValue;
    if (onlineNumbers < 10000) {
        self.onlinePeople.text = room.online;
    }else{
        self.onlinePeople.text = [NSString stringWithFormat:@"%0.1f万",[room.online doubleValue]/10000];
    }
}



@end
