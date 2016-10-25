//
//  RoomListView.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/17.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRoom.h"

@class RoomListView;
@protocol RoomListViewDelegate <NSObject>

@optional
- (void)roomListView:(RoomListView *)roomListView didSelectRoom:(MyRoom *)room;

@end

@interface RoomListView : UIView
@property (nonatomic, strong)NSArray *rooms;
@property (nonatomic, weak) id<RoomListViewDelegate> delegate;
@end
