//
//  LPlaceholderTextView.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/15.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LPlaceholderTextView.h"

@implementation LPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        self.tintColor = [UIColor blackColor];
        self.font = [UIFont systemFontOfSize:15];
        self.placeholderColor = [UIColor grayColor];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
}
- (void)textDidChange
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    if (self.hasText) return;
    [self.placeholder drawInRect:CGRectMake(4, 7, self.width, self.height) withAttributes:@{NSFontAttributeName : self.font ,
          NSForegroundColorAttributeName : self.placeholderColor}];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark --重写setter方法(写框架或者类的使用的时候记得怎么样，修改对应的属性的时候，还有父类的属性)

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
    
}

- (void)setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}
- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}
@end
