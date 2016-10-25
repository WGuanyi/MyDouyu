//
//  MyGameVerticalButton.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/9.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "MyGameVerticalButton.h"

@implementation MyGameVerticalButton
- (void)setup {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setup];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 修改图片
    self.imageView.width = self.width * 0.7;
    self.imageView.height = self.imageView.width;
    self.imageView.x = (self.width - self.imageView.width ) / 2;
    self.imageView.y = 0;
    
    // 修改标题
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
    self.imageView.layer.cornerRadius = self.imageView.width / 2;
    self.imageView.clipsToBounds = YES;
    self.imageView.backgroundColor = [UIColor redColor];
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
