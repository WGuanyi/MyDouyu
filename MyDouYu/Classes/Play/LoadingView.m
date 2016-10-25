//
//  LoadingView.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/14.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView ()

@property (nonatomic, strong)UIImageView *animView;

@end

@implementation LoadingView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //动画
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeCenter;
        imageView.animationImages = @[[UIImage imageNamed:@"image_loading_player01_108x100_"],
                                      [UIImage imageNamed:@"image_loading_player02_108x100_"],
                                      [UIImage imageNamed:@"image_loading_player03_108x100_"]
                                      ];
        imageView.animationDuration = 0.5;
        imageView.animationRepeatCount = MAXFLOAT;
        [imageView startAnimating];
        [self addSubview:imageView];
        self.animView = imageView;
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(216);
            make.height.equalTo(self.mas_height).multipliedBy(0.7);
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"视频加载中...";
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.offset(216);
            make.height.equalTo(self.mas_height).multipliedBy(0.1);
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(imageView.mas_bottom).offset(-20);
        }];
        
    }
    return self;
}

-(void)startAnim{
    [self.animView startAnimating];
}

-(void)stopAnim{
    [self.animView stopAnimating];
}
@end
