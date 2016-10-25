//
//  MyScrollModel.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/9.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyRoom.h"
@interface MyScrollModel : NSObject
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *ID;
@property (nonatomic, copy)NSString *pic_url;
@property (nonatomic, copy)NSString *tv_pic_url;
@property (nonatomic, strong)MyRoom *room;
@end
