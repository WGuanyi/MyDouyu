//
//  MyScrollModel.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/9.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "MyScrollModel.h"

@implementation MyScrollModel
+ (void)load {
    [self mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"ID":@"id"};
    }];
}
MJCodingImplementation
@end
