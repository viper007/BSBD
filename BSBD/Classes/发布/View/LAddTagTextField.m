//
//  LAddTagTextField.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/27.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LAddTagTextField.h"

@implementation LAddTagTextField

- (void)deleteBackward
{
    //字符
    if (![self hasText]) {
    !_deleteBlock?:_deleteBlock();
    }
    [super deleteBackward];
}

@end
