//
//  HJGameCell.m
//  LivePlayer-HJ
//
//  Created by huangjian on 17/3/3.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "HJGameCell.h"
#import "UIImageView+WebCache.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width

@interface HJGameCell()
@property (nonatomic, strong) UIImageView *topImage;

@property (nonatomic, strong) UILabel *titleLab;
@end

@implementation HJGameCell
- (void)setModel:(HJGameCellModel *)model{
    _model = model;
    [self.topImage sd_setImageWithURL:[NSURL URLWithString:model.spic] placeholderImage:[UIImage imageNamed:@"liveImage"]];
    self.titleLab.text = model.name;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI{
    self.topImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (WIDTH - 40)/3.0, 120)];
    self.topImage.image = [UIImage imageNamed:@"liveImage"];
    [self.contentView addSubview:self.topImage];
    
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topImage.frame) + 7, CGRectGetWidth(self.topImage.frame), 15)];
    self.titleLab.text = @"专题标题";
    self.titleLab.font = [UIFont systemFontOfSize:12];
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLab];
    
}

@end
