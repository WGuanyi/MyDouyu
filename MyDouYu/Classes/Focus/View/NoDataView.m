//
//  NoDataView.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/19.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView

+ (instancetype)noDataView{
    return [[[NSBundle mainBundle] loadNibNamed:@"NoDataView" owner:nil options:nil]lastObject];
}

@end
