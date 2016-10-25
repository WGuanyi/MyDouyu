//
//  LiveDownButtonView.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/20.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "LiveDownButtonView.h"

@interface LiveDownButtonView()

@end

@implementation LiveDownButtonView

+ (instancetype)liveDownButtonView{
    return [[[NSBundle mainBundle] loadNibNamed:@"LiveDownButtonView" owner:nil options:nil] firstObject];
}

-(void)awakeFromNib{
    self.tagIconView.userInteractionEnabled = YES;
    self.tagNameLabel.userInteractionEnabled = YES;
    self.checkIconView.userInteractionEnabled = YES;
    
    self.tagIconView.layer.cornerRadius = 21;
    self.tagIconView.layer.masksToBounds = YES;
    [super awakeFromNib];
}

@end
