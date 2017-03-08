//
//  LProgressView.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/13.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LProgressView.h"

@implementation LProgressView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    //设置内容
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    //替换出现-0的情况
    text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //更新UI到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressLabel.text = text;
    });
}

@end
