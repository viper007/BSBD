//
//  UIBarButtonItem+Extension.m
//  BSBD
//
//  Created by lvzhenhua on 2016/12/31.
//  Copyright © 2016年 lvzhenhua. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWith:(NSString *)normalImage HighImage:(NSString *)highImage target:(id)target sel:(SEL)selector{
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [tagButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    tagButton.size = tagButton.currentBackgroundImage.size;
    return [[self alloc]initWithCustomView:tagButton];
}
@end
