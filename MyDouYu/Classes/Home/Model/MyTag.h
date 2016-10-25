//
//  MyTag.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/9.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyRoom.h"
@interface MyTag : NSObject

//这个房间组的所有房间
@property (nonatomic,copy) NSArray *room_list;

//标签名
@property (nonatomic,copy) NSString *tag_name;

//标签id
@property (nonatomic,copy) NSString *tag_id;

//该标签的图片
@property (nonatomic,copy) NSString *icon_url;

//push_vertical_scree
@property (nonatomic,copy) NSString *push_vertical_screen;

@property (nonatomic,copy) NSString *short_name;

@property (nonatomic,copy) NSString *pic_name;

@property (nonatomic,copy) NSString *icon_name;

@property (nonatomic,copy) NSString *orderdisplay;
@property (nonatomic,copy) NSString *rank_score;
@property (nonatomic,copy) NSString *night_rank_score;
@property (nonatomic,copy) NSString *nums;

@property (nonatomic,copy) NSString *push_ios;
@property (nonatomic,copy) NSString *push_home;

@property (nonatomic,copy) NSString *is_game_cate;
@property (nonatomic,copy) NSString *cate_id;
@property (nonatomic,copy) NSString *is_del;
@property (nonatomic,copy) NSString *is_relate;
@property (nonatomic,copy) NSString *push_qqapp;
@property (nonatomic,copy) NSString *broadcast_limit;
@property (nonatomic,copy) NSString *pic_url;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) NSString *count_ios;

@property (nonatomic,copy) NSString *groupImageName;

@end

