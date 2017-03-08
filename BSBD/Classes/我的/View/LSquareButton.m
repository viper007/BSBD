//
//  LSquareButton.m
//  BSBD
//
//  Created by lvzhenhua on 2017/3/1.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LSquareButton.h"
#import <UIButton+WebCache.h>
#import "LFooterModel.h"
@implementation LSquareButton


- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupButton];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupButton];
    }
    return self;
}

- (void)setupButton{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //
    self.imageView.y = self.height * 0.2;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    //
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setSquare:(LFooterModel *)square
{
    _square = square;
    
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
}

@end
