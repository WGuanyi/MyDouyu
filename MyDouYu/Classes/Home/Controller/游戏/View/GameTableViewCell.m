//
//  GameTableViewCell.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/6.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "GameTableViewCell.h"
#import "MyTag.h"
#import "MyGameVerticalButton.h"

@implementation GameTableViewCell

-(void)setAllTags:(NSArray *)allTags{
    _allTags = allTags;
    CGFloat btnW = GameBtnW;
    CGFloat btnH = GameBtnH;
    CGFloat margin = GameBtnMargin;
    CGFloat btnMargin = (self.width - 2*margin - 3*btnW)/2;
    for (int i = 0; i<allTags.count; i++) {
        MyTag *tag = allTags[i];
        CGFloat btnX = 20 + (i%3) * (btnW + btnMargin);
        CGFloat btnY = margin + (i/3) * (btnH + 2 * margin);
        MyGameVerticalButton *btn = [[MyGameVerticalButton alloc]init];
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitle:tag.tag_name forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:tag.icon_url] forState:UIControlStateNormal];
        [self addSubview:btn];
        
        UIView *divider = [[UIView alloc]init];
        divider.alpha = 0.1;
        divider.frame = CGRectMake(20, btnH + btnY + 20 - 1, self.width - 40, 1);
        divider.backgroundColor = [UIColor grayColor];
        [self addSubview:divider];
    }
}

@end
