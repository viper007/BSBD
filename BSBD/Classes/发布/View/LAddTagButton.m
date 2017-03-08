//
//  LAddTagButton.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/25.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LAddTagButton.h"

@implementation LAddTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.backgroundColor = LVZHRGEColor(68, 180, 251);
        
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    //
    self.width += 3*addTags_margin;
    self.height = TagsButton_Height;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = addTags_margin;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + addTags_margin;
}
@end
