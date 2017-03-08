//
//  LTextField.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/6.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LTextField.h"
//#import <objc/runtime.h>
@implementation LTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    
//    unsigned int count = 0;
//    
//    Ivar *ivars = class_copyIvarList([UITextField class], &count);
//    for (int i = 0; i<count; i++) {
//        Ivar ivar = ivars[i];
//        NSLog(@"%s",ivar_getName(ivar));
//    }
//    free(ivars);
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.tintColor = self.textColor;//修改对应的光标的颜色
}
//-(void)setHighlighted:(BOOL)highlighted{
//    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
//}

- (BOOL)becomeFirstResponder{
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
}
/**
 *运行时去查看一些对应的隐藏的实例变量和方法
 */
@end
