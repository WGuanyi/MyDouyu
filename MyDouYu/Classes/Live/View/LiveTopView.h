//
//  LiveTopView.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/21.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LiveTopView;
@protocol LiveTopViewDelegate <NSObject>

@optional

- (void)liveTopView: (LiveTopView *)topView didClickButtonTagNumber:(NSInteger)tagNum;

- (void)liveTopView: (LiveTopView *)topView didClickButtonTitle:(NSString *)title;

@end

@interface LiveTopView : UIView

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, weak) id<LiveTopViewDelegate> topViewDelegate;

@end





