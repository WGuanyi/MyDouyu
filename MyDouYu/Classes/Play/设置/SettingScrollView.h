//
//  SettingScrollView.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/15.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BarrageAttributeTypeAlpha,                     // 弹幕透明度
    BarrageAttributeTypeFont,                      // 弹幕字体
    BarrageAttributeTypeBrightness,                // 弹幕亮度
    BarrageAttributeTypeSoftDecodingPerformance    // 软解码的性能
} BarrageAttributeType;

@class SettingScrollView;
@protocol SettingScrollViewDelegate <NSObject>

@optional
/**
 *  改变了弹幕的基本属性
 */
- (void)settingScrollView:(SettingScrollView *)settingScrollView didChangeBarrageAttributeType:(BarrageAttributeType)type value:(CGFloat)value;
/**
 *  改变弹幕的位置
 */
- (void)settingScrollView:(SettingScrollView *)settingScrollView changeBarrageLocationID:(int)locationID;
@end

@interface SettingScrollView : UIScrollView

+ (instancetype)settingScrollView;

@property (nonatomic,weak) id<SettingScrollViewDelegate> settingScrollViewDelegate;

@end
