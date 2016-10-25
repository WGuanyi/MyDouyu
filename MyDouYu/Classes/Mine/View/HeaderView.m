//
//  HeaderView.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/26.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "HeaderView.h"
#import "BottomButton.h"
#import <Masonry.h>
@interface HeaderView ()
/**
 *  背景图片
 */
@property (nonatomic,weak) UIImageView *backgroundView;
/**
 *  消息按钮
 */
@property (nonatomic,weak) UIButton *messageBtn;
/**
 *  设置按钮
 */
@property (nonatomic,weak) UIButton *settingBtn;
/**
 *  头像
 */
@property (nonatomic,weak) UIImageView *iconView;
/**
 *  等级图片
 */
@property (nonatomic,weak) UIImageView *levelView;
/**
 *  昵称label
 */
@property (nonatomic,weak) UILabel *nameLabel;
/**
 *  鱼丸、鱼翅label
 */
@property (nonatomic,weak) UILabel *fishBallLabel;
/**
 *  直播按钮
 */
@property (nonatomic,weak) UIButton *liveBtn;
/**
 *  观看历史
 */
@property (nonatomic,weak) BottomButton *hisBtn;
/**
 *  关注管理
 */
@property (nonatomic,weak) BottomButton *focusManageBtn;
/**
 *  我的任务
 */
@property (nonatomic,weak) BottomButton *fishTaskBtn;
/**
 *  鱼翅充值
 */
@property (nonatomic,weak) BottomButton *finTopUpBtn;
/**
 *  分割线1
 */
@property (nonatomic, weak) BottomButton *line1;
/**
 *  分割线2
 */
@property (nonatomic, weak) BottomButton *line2;
/**
 *  分割线3
 */
@property (nonatomic, weak) BottomButton *line3;
@end

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setup {
    
    // 0.背景图片
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"usercenter_top_bg_day"]];
    backgroundView.userInteractionEnabled = YES;
    [self addSubview:backgroundView];
    self.backgroundView = backgroundView;
    
    // 1.消息按钮
    UIButton *messageBtn = [[UIButton alloc] init];
    [messageBtn setImage:[UIImage imageNamed:@"image_personal_letter"] forState:UIControlStateNormal];
    [self addSubview:messageBtn];
    self.messageBtn = messageBtn;
    
    // 2.设置按钮
    UIButton *settingBtn = [[UIButton alloc] init];
    [settingBtn setImage:[UIImage imageNamed:@"image_player_config_normal"] forState:UIControlStateNormal];
    [self addSubview:settingBtn];
    self.settingBtn = settingBtn;
    
    // 3.头像
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.image = [UIImage imageNamed:@"dy015"];
    [self addSubview:iconView];
    self.iconView = iconView;
    self.iconView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    self.iconView.layer.cornerRadius = 40;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.contentMode = UIViewContentModeCenter;
    self.iconView.layer.borderWidth = 5;
    self.iconView.layer.borderColor = MyColor(254, 190, 0).CGColor;
    
    // 4.等级
    UIImageView *levelView = [[UIImageView alloc] init];
    [levelView sd_setImageWithURL:[NSURL URLWithString:@"http://staticlive.douyucdn.cn/common/douyu/images/user_level/newm2_lv1.png?v=v48748"]];
    [self addSubview:levelView];
    self.levelView = levelView;
    
    // 5.昵称label
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = @"Hduwang";
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    // 6.鱼丸、鱼翅label
    UILabel *fishBallLabel = [[UILabel alloc] init];
    fishBallLabel.font = [UIFont systemFontOfSize:14];
    fishBallLabel.textColor = [UIColor whiteColor];
    fishBallLabel.textAlignment = NSTextAlignmentCenter;
    fishBallLabel.text = @"鱼丸 0  |  鱼翅 0";
    [self addSubview:fishBallLabel];
    self.fishBallLabel = fishBallLabel;
    
    // 7.直播按钮
    UIButton *liveBtn = [[UIButton alloc] init];
    [liveBtn setImage:[UIImage imageNamed:@"btn_start_live"] forState:UIControlStateNormal];
    liveBtn.layer.cornerRadius = 5;
    liveBtn.layer.masksToBounds = YES;
    [self addSubview:liveBtn];
    self.liveBtn = liveBtn;
    
    // 8.观看历史
    BottomButton *hisBtn = [[BottomButton alloc] init];
    [hisBtn setImage:[UIImage imageNamed:@"image_my_history_26x26_"] forState:UIControlStateNormal];
    [hisBtn setTitle:@"观看历史" forState:UIControlStateNormal];
    [self addSubview:hisBtn];
    self.hisBtn = hisBtn;
    
    // 9.关注管理
    BottomButton *focusManageBtn = [[BottomButton alloc] init];
    [focusManageBtn setImage:[UIImage imageNamed:@"image_my_focus_26x26_"] forState:UIControlStateNormal];
    [focusManageBtn setTitle:@"关注管理" forState:UIControlStateNormal];
    [self addSubview:focusManageBtn];
    self.focusManageBtn = focusManageBtn;
    
    // 10.我的任务
    BottomButton *fishTaskBtn = [[BottomButton alloc] init];
    [fishTaskBtn setImage:[UIImage imageNamed:@"image_my_task_26x26_"] forState:UIControlStateNormal];
    [fishTaskBtn setTitle:@"我的任务" forState:UIControlStateNormal];
    [self addSubview:fishTaskBtn];
    self.fishTaskBtn = fishTaskBtn;
    
    // 11.鱼翅充值
    BottomButton *finTopUpBtn = [[BottomButton alloc] init];
    [finTopUpBtn setImage:[UIImage imageNamed:@"Image_my_pay_26x26_"] forState:UIControlStateNormal];
    [finTopUpBtn setTitle:@"鱼翅充值" forState:UIControlStateNormal];
    [self addSubview:finTopUpBtn];
    self.finTopUpBtn = finTopUpBtn;
    
    //12.分割线1
    BottomButton *line1 = [[BottomButton alloc]init];
    [line1 setImage:[UIImage imageNamed:@"widget_line"] forState:UIControlStateNormal];
    [self addSubview:line1];
    self.line1 = line1;
    
    //13.分割线2
    BottomButton *line2 = [[BottomButton alloc]init];
    [line2 setImage:[UIImage imageNamed:@"widget_line"] forState:UIControlStateNormal];
    [self addSubview:line2];
    self.line2 = line2;
    
    //14.分割线3
    BottomButton *line3 = [[BottomButton alloc]init];
    [line3 setImage:[UIImage imageNamed:@"widget_line"] forState:UIControlStateNormal];
    [self addSubview:line3];
    self.line3 = line3;
    
    // 设置子控件的约束
    // 背景图片约束
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.height.offset(215);
        make.right.equalTo(self.mas_right);
    }];
    
    // 消息按钮约束
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(settingBtn.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-50);
        make.width.offset(20);
        make.height.offset(15);
    }];
    
    // 设置按钮约束
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(35);
        make.right.equalTo(self.mas_right).offset(-20);
        make.width.offset(20);
        make.height.offset(20);
    }];
    
    // 头像约束
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(60);
        make.left.equalTo(self.mas_left).offset(15);
        make.width.offset(80);
        make.height.offset(80);
    }];
    
    // 等级图片
    [self.levelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView.mas_top).offset(5);
        make.right.equalTo(self.iconView.mas_right);
        make.width.offset(30);
        make.height.offset(15);
    }];
    
    // 昵称
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(70);
        make.left.equalTo(self.iconView.mas_right).offset(20);
        make.height.offset(20);
    }];
    
    // 鱼丸和鱼翅
    [self.fishBallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(15);
        make.left.equalTo(self.iconView.mas_right).offset(20);
        make.height.offset(20);
    }];
    
    // 直播按钮
    [self.liveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(530);
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.offset(70);
        make.height.offset(70);
    }];
    
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - 4 * 50 - 2 * 20) / 3;
    // 观看历史
    [self.hisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.offset(50);
        make.height.offset(70);
    }];
    
    // 关注管理
    [self.focusManageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.hisBtn.mas_right).offset(margin);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.offset(50);
        make.height.offset(70);
    }];
    
    // 我的任务
    [self.fishTaskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.focusManageBtn.mas_right).offset(margin);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.offset(50);
        make.height.offset(70);
    }];
    
    // 鱼翅充值
    [self.finTopUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.width.offset(50);
        make.height.offset(70);
    }];
    
    // 分割线
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(hisBtn.mas_right).offset(25);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.width.offset(1);
        make.height.offset(60);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(focusManageBtn.mas_right).offset(25);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.width.offset(1);
        make.height.offset(60);
    }];
    [self.line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(fishTaskBtn.mas_right).offset(25);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.width.offset(1);
        make.height.offset(60);
    }];
}
@end
