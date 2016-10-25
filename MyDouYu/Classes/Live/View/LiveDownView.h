//
//  LiveDownView.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/21.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LiveDownView;
@protocol LiveDownViewDelegate <NSObject>

@optional

- (void)liveDownView: (LiveDownView *)downView DidClickDownButtonViewName: (NSString *)name;

@end

@interface LiveDownView : UIScrollView

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, weak) id<LiveDownViewDelegate> downViewDelegate;

/**
 *  重新设置下拉列表选中的按钮
 */
- (void)selectButtonViewName: (NSString *)btnName;

@end
