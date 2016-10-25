//
//  LandScapeView.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/14.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LandScapeView;

@protocol LandScapeViewDelegate <NSObject>

@optional
/**
 *  点击了返回
 */
- (void)landScapeViewDidClickBackBtn:(LandScapeView *)landScapeView;
/**
 *  点击了刷新
 */
- (void)landScapeViewDidClickRefreshBtn:(LandScapeView *)landScapeView;
/**
 *  点击了关注
 */
- (void)landScapeView:(LandScapeView *)landScapeView didAttention:(BOOL)isAttention;
/**
 *  点击了礼物
 */
- (void)landScapeView:(LandScapeView *)landScapeView didClickGiftBtn:(BOOL)isOpenGift;
/**
 *  点击了分享
 */
- (void)landScapeViewDidClickShareBtn:(LandScapeView *)landScapeView;
/**
 *  点击了频道选择
 */
- (void)landScapeViewDidClickChannelSelectBtn:(LandScapeView *)landScapeView;
/**
 *  点击了设置
 */
- (void)landScapeViewDidClickSettingBtn:(LandScapeView *)landScapeView;
/**
 *  点击了弹幕
 */
- (void)landScapeView:(LandScapeView *)landScapeView didClickBarrageBtn:(BOOL)isOpenBarrage;
/**
 *  点击了房间列表
 */
- (void)landScapeViewdidClickRoomListBtn:(LandScapeView *)landScapeView;

@end

@interface LandScapeView : UIView

+ (instancetype)landScapeView;

@property (nonatomic, weak) id<LandScapeViewDelegate> delegate;

/**
 *  设置是否在播放
 */
- (void)setIsPlaying:(BOOL)isPlaying;

/**
 *  设置弹幕按钮的状态
 */
- (void)setIsOpenBarrage:(BOOL)isOpenBarrage;

@end
