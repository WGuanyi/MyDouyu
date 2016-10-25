//
//  PortraitView.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/14.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PortraitView;
@protocol PortraitViewDelegate <NSObject>

@optional
- (void)portraitViewDidClickBackBtn:(PortraitView *)portraitView;
- (void)portraitView:(PortraitView *)portraitView setLandScape:(UIInterfaceOrientation)interfaceOrientation;

@end

@interface PortraitView : UIView

@property (nonatomic, weak) id<PortraitViewDelegate> delegate;

- (void)setIsPlaying:(BOOL)isPlaying;

@end
