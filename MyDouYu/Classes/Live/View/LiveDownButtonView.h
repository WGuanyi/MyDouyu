//
//  LiveDownButtonView.h
//  MyDouYu
//
//  Created by 王冠一 on 16/9/20.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTag.h"

@interface LiveDownButtonView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *tagIconView;

@property (weak, nonatomic) IBOutlet UILabel *tagNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *checkIconView;


+ (instancetype)liveDownButtonView;

@end
