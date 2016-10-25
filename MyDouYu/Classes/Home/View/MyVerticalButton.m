//
//  MyVerticalButton.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/9.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "MyVerticalButton.h"

@implementation MyVerticalButton
- (void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    self.titleLabel.backgroundColor = [UIColor grayColor];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self awakeFromNib];
    [self setup];
}

-(void)layoutSubviews{
    //修改图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    //修改标题
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 5;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
    self.imageView.layer.cornerRadius = self.imageView.width/2;
    //剪边
    self.imageView.clipsToBounds = YES;
}


@end
