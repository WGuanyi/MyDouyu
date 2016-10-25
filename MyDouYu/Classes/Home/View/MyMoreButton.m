//
//  MyMoreButton.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/9.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "MyMoreButton.h"

@implementation MyMoreButton
-(instancetype)init{
    if (self=[super init]) {
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.x = 0;
    self.titleLabel.width = self.width * 0.7;
    self.titleLabel.y = 0;
    self.titleLabel.height = self.height;
    
    self.imageView.x = self.titleLabel.width;
    self.imageView.y = 0;
    self.imageView.width = self.width - self.imageView.x;
    self.imageView.height = self.height;
}

@end
