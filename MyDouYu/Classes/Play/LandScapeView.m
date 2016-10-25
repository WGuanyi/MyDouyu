//
//  LandScapeView.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/14.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "LandScapeView.h"

@interface LandScapeView () <UITextFieldDelegate>

/**
 *  上半部分控制view
 */
@property (weak, nonatomic) IBOutlet UIView *topView;
/**
 *  下半部分控制view
 */
@property (weak, nonatomic) IBOutlet UIView *bottomView;
/**
 *  房间名
 */
@property (weak, nonatomic) IBOutlet UILabel *roomNameLabel;
/**
 *  播放和暂停按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
/**
 *  输入弹幕的文本框的父控件
 */
@property (weak, nonatomic) IBOutlet UIView *textFieldSuperView;
/**
 *  弹幕按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *barrageBtn;
/**
 *  弹幕文本框
 */
@property (weak, nonatomic) IBOutlet UITextField *barrageField;

@property (nonatomic,strong) UIView *coverView;

@property (nonatomic,assign) BOOL isClickReturn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation LandScapeView

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.frame = [UIScreen mainScreen].bounds;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didmissKeyboard)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}

- (void)didmissKeyboard {
    [self.barrageField endEditing:YES];
}

+ (instancetype)landScapeView {
    return [[[NSBundle mainBundle] loadNibNamed:@"LandScapeView" owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.topView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    self.bottomView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    self.textFieldSuperView.layer.cornerRadius = 5;
    self.textFieldSuperView.layer.masksToBounds = YES;
    
    self.barrageField.delegate = self;
    
    // 监听键盘的显示和隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL pointAtTopView = CGRectContainsPoint(self.topView.frame, point);
    BOOL pointAtBottomView = CGRectContainsPoint(self.bottomView.frame, point);
    if (pointAtTopView || pointAtBottomView) {
        return [super hitTest:point withEvent:event];
    } else {
        return nil;
    }
}

#pragma mark - 所有按钮的点击事件
- (IBAction)backBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(landScapeViewDidClickBackBtn:)]) {
        [self.delegate landScapeViewDidClickBackBtn:self];
    }
}

- (IBAction)selectChannel:(id)sender {
    if ([self.delegate respondsToSelector:@selector(landScapeViewDidClickChannelSelectBtn:)]) {
        [self.delegate landScapeViewDidClickChannelSelectBtn:self];
    }
}

- (IBAction)attentionClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(landScapeView:didAttention:)]) {
        [self.delegate landScapeView:self didAttention:sender.selected];
    }
}

- (IBAction)shareBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(landScapeViewDidClickShareBtn:)]) {
        [self.delegate landScapeViewDidClickShareBtn:self];
    }
}

- (IBAction)giftBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(landScapeView:didClickGiftBtn:)]) {
        [self.delegate landScapeView:self didClickGiftBtn:!sender.selected];
    }
}

- (IBAction)settingBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(landScapeViewDidClickSettingBtn:)]) {
        [self.delegate landScapeViewDidClickSettingBtn:self];
    }
}

- (IBAction)roomListBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(landScapeViewdidClickRoomListBtn:)]) {
        [self.delegate landScapeViewdidClickRoomListBtn:self];
    }
}

- (IBAction)refreshBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(landScapeViewDidClickRefreshBtn:)]) {
        [self.delegate landScapeViewDidClickRefreshBtn:self];
    }
}

- (IBAction)playOrPauseBtnClick:(id)sender {
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayStateShouldChanged" object:nil];
}

- (void)setIsPlaying:(BOOL)isPlaying{
    self.playOrPauseBtn.selected = !isPlaying;
}

- (void)setIsOpenBarrage:(BOOL)isOpenBarrage{
    self.barrageBtn.selected = !isOpenBarrage;
}

- (IBAction)barrageBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(landScapeView:didClickBarrageBtn:)]) {
        [self.delegate landScapeView:self didClickBarrageBtn:!sender.selected];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField hasText]) {
        self.isClickReturn = YES;
        [textField endEditing:YES];
    } else {
        [textField endEditing:YES];
    }
    return YES;
}

#pragma mark - 监听键盘的弹出和隐藏
/**
 *  键盘即将显示
 */
- (void)keyBoardWillShow:(NSNotification *)note {
    
    // 隐藏上面的控制view
    self.topView.hidden = YES;
    
    // 关闭自动隐藏
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteTimer" object:nil];
    
    [self.superview insertSubview:self.coverView belowSubview:self];
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    self.bottomConstraint.constant = keyboardFrame.size.height;
    [UIView animateWithDuration:duration animations:^{
        [self.bottomView layoutIfNeeded];
    }];
}

/**
 *  键盘即将隐藏
 */
- (void)keyBoardWillHide:(NSNotification *)note {
    
    // 显示上面的控制view
    self.topView.hidden = NO;
    
    if (self.isClickReturn) {
        self.isClickReturn = NO;
        // 隐藏横屏的view、隐藏状态栏
        self.hidden = YES;
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        // 发弹幕通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendBarrage" object:nil userInfo:@{ @"text" : self.barrageField.text}];
        // 清空文本框的文字
        self.barrageField.text = nil;
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addTimer" object:nil];
    }
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    self.bottomConstraint.constant = 0;
    [UIView animateWithDuration:duration animations:^{
        [self.bottomView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.coverView removeFromSuperview];
    }];
    
}

@end
