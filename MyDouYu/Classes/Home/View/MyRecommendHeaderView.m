//
//  MyRecommendHeaderView.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/9.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "MyRecommendHeaderView.h"
#import "MyMoreButton.h"

@interface MyRecommendHeaderView ()
@property (nonatomic, weak)UIImageView *iconView;
@property (nonatomic, weak)UILabel *tagLabel;
@property (nonatomic, weak)MyMoreButton *moreBtn;
@end
@implementation MyRecommendHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
        
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.contentMode = UIViewContentModeCenter;
    [self addSubview:iconView];
    self.iconView = iconView;
    
    UILabel *tagLabel = [[UILabel alloc]init];
    tagLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:tagLabel];
    self.tagLabel = tagLabel;
    
    MyMoreButton *moreBtn = [[MyMoreButton alloc]init];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn setImage:[UIImage imageNamed:@"dyla_右箭头_16x16_"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(clickHeaderView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreBtn];
    self.moreBtn = moreBtn;
}

-(void)clickHeaderView{
    NSLog(@"点击的标签名字是: %@", self.tagName);
}

- (void)setHideMoreBtn:(BOOL)hideMoreBtn {
    self.moreBtn.hidden = hideMoreBtn;
}

-(void)setImageName:(NSString *)imageName{
    _imageName = [imageName copy];
    self.iconView.image = [UIImage imageNamed:imageName];
}

-(void)setTagName:(NSString *)tagName{
    _tagName = [tagName copy];
    self.tagLabel.text = tagName;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.iconView.frame = CGRectMake(10, 5, 20, 20);
    self.tagLabel.frame = CGRectMake(30, 0, 100, 30);
    self.moreBtn.frame = CGRectMake(self.width - 50, 5, 45, 25);
}

@end
