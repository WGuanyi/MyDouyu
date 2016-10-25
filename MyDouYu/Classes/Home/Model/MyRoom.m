//
//  MyRoom.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/6.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "MyRoom.h"
#import "MyCDN.h"
@implementation MyRoom
+ (void)load {
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"cdnsWithName" : [MyCDN class]};
    }];
}

MJCodingImplementation

@end
