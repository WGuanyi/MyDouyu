//
//  MineTableViewCell.m
//  MyDouYu
//
//  Created by 王冠一 on 16/9/26.
//  Copyright © 2016年 guanyi. All rights reserved.
//

#import "MineTableViewCell.h"

@interface MineTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setDict:(NSDictionary *)dict {
    _dict = dict;
    
    self.iconView.image = [UIImage imageNamed:dict[@"image"]];
    self.titleLabel.text = dict[@"title"];
    if (dict[@"subtitle"]) {
        self.subtitleLabel.text = dict[@"subtitle"];
    }
    
    if (dict[@"class"]) {
        self.targetClass = NSClassFromString(dict[@"class"]);
    }
}

@end
