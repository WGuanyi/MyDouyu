//
//  ChannelSelectScrollView.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/15.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelSelectScrollView : UIScrollView

@property (nonatomic, strong) NSArray *channels;

/**
 *  选择了频道将会调用的block
 */
@property (nonatomic, copy) void (^selectedChannel)(NSString *title, NSString *channelString);
@end
