//
//  LVerticalButton.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/6.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LVerticalButton.h"

@implementation LVerticalButton

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
}
- (void)layoutSubviews{
    [super layoutSubviews];
    //
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    //
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
