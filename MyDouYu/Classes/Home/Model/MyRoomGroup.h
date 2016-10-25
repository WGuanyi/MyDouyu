//
//  MyRoomGroup.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/9.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRoomGroup : NSObject

@property (nonatomic,copy) NSString *groupName;

@property (nonatomic,copy) NSString *groupImage;

@property (nonatomic,strong) NSArray *rooms;

@property (nonatomic,assign) CGFloat cellHeight;

@end
