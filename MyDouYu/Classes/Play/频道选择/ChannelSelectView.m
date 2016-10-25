//
//  ChannelSelectView.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/15.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "ChannelSelectView.h"

@interface ChannelSelectView ()


@end

@implementation ChannelSelectView

+ (instancetype)channelSelectView {
    return [[[NSBundle mainBundle] loadNibNamed:@"ChannelSelectView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setAttrWithBtn:self.superDefinitionBtn];
    [self setAttrWithBtn:self.highDefinitionBtn];
    [self setAttrWithBtn:self.normalDefinitionBtn];
}

- (void)setAttrWithBtn:(UIButton *)btn {
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor whiteColor].CGColor;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
}

- (IBAction)btnClick:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    sender.selected = YES;
    sender.layer.borderColor = [UIColor orangeColor].CGColor;
    if ([self.delegate respondsToSelector:@selector(channelSelectView:didClickBtn:)]) {
        [self.delegate channelSelectView:self didClickBtn:sender];
    }
}



@end
