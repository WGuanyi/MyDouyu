//
//  ChannelSelectScrollView.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/15.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "ChannelSelectScrollView.h"
#import "ChannelSelectView.h"

@interface ChannelSelectScrollView () <ChannelSelectViewDelegate>
@property (nonatomic, strong)UIButton *lastBtn;
@end

@implementation ChannelSelectScrollView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    return self;
}

- (void)setChannels:(NSArray *)channels {
    _channels = channels;
    
    for (int i = 0; i < channels.count; i++) {
        ChannelSelectView *channelSelectView = [ChannelSelectView channelSelectView];
        if (i == 0) {
            self.lastBtn = channelSelectView.normalDefinitionBtn;
            channelSelectView.normalDefinitionBtn.selected = YES;
            channelSelectView.normalDefinitionBtn.layer.borderColor = [UIColor orangeColor].CGColor;
        }
        channelSelectView.delegate = self;
        channelSelectView.titleLabel.text = channels[i];
        [self addSubview:channelSelectView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat viewH = 70;
    for (int i = 0; i < self.subviews.count; i++) {
        ChannelSelectView *channelSelectView = self.subviews[i];
        channelSelectView.frame = CGRectMake(0, i * viewH, self.width, viewH);
    }
    self.contentSize = CGSizeMake(0, self.subviews.count * viewH);
}

#pragma mark - YCChannelSelectViewDelegate
- (void)channelSelectView:(ChannelSelectView *)view didClickBtn:(UIButton *)btn {
    self.lastBtn.selected = NO;
    self.lastBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.selectedChannel(view.titleLabel.text, [btn titleForState:UIControlStateNormal]);
    
    self.lastBtn = btn;
}

@end
