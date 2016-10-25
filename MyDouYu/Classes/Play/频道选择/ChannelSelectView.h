//
//  ChannelSelectView.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/15.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChannelSelectView;
@protocol ChannelSelectViewDelegate <NSObject>
@optional
- (void)channelSelectView:(ChannelSelectView *)view didClickBtn:(UIButton *)btn;
@end
@interface ChannelSelectView : UIView

+ (instancetype)channelSelectView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *superDefinitionBtn;

@property (weak, nonatomic) IBOutlet UIButton *highDefinitionBtn;

@property (weak, nonatomic) IBOutlet UIButton *normalDefinitionBtn;

@property (nonatomic, weak) id<ChannelSelectViewDelegate> delegate;

@end
