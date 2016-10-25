//
//  MyTag.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/9.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "MyTag.h"

@implementation MyTag
+ (void)load {
    [self mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"room_list":[MyRoom class]};
    }];
}
- (BOOL)isEqual:(MyTag *)object{
    if ([object.tag_id isEqualToString:self.tag_id] && [object.tag_name isEqualToString:self.tag_name]) {
        return YES;
    }
    return NO;
}
MJCodingImplementation
@end
