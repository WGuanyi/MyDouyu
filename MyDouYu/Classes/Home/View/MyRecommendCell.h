//
//  MyRecommendCell.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/9.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRoomGroup.h"
@class MyRoom;
typedef void (^MyBlock)(MyRoom *room);

@interface MyRecommendCell : UITableViewCell
@property (nonatomic, copy)MyBlock block;
@property (nonatomic, strong)NSArray *rooms;
@property (nonatomic, copy)NSString *groupName;
@end
