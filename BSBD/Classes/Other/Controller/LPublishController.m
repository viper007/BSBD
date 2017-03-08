//
//  LPublishController.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/13.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LPublishController.h"
#import "LVerticalButton.h"
#import <POP.h>
#import "LPostTopicController.h"
#import "LvZHNavgationController.h"
@interface LPublishController ()

@end

#define TimeInterval 0.05

@implementation LPublishController

- (void)awakeFromNib{
    [super awakeFromNib];
    LVLog(@"%d--%s",__LINE__,__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.userInteractionEnabled = NO;
    
    //添加slogan
    
    NSArray *images = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray *titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    //添加按钮
    int maxCols = 3;
    CGFloat xMargin = 20;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (screenH - 2 * buttonH) * 0.5;
    CGFloat buttonMiddleMargin = (screenW - buttonW * maxCols - 2 * xMargin)/(maxCols -1);
    for (int i = 0 ; i < titles.count; i++) {
        LVerticalButton *button = [[LVerticalButton alloc]init];
        [self.view addSubview:button];
        
        //设置属性
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        //添加
        [self.view addSubview:button];
        //设置frame
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = xMargin + (buttonW + buttonMiddleMargin) * col;
        CGFloat buttonY = buttonStartY + buttonH * row;
        //button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        //添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.beginTime = CACurrentMediaTime() + TimeInterval * i;
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY - screenH, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        [button pop_addAnimation:anim forKey:nil];
       
    }
    //添加slogan
    UIImageView *slogan = [[UIImageView alloc]init];
    slogan.image = [UIImage imageNamed:@"app_slogan"];
    slogan.size = slogan.image.size;
    slogan.centerX = screenW * 0.5;
    slogan.centerY = screenH * 0.2 - screenH;
    [self.view addSubview:slogan];
    //给slogan添加动画
    CGFloat sloganEndX = slogan.centerX;
    CGFloat sloganStartY = screenH * 0.2 - screenH;
    CGFloat sloganEndY = screenH * 0.2 + 0.5 * slogan.size.height;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.beginTime = CACurrentMediaTime() + TimeInterval * titles.count + TimeInterval;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(sloganEndX, sloganStartY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(sloganEndX, sloganEndY)];
    //可以调整它的速度和弹簧的弹性
    [slogan pop_addAnimation:anim forKey:nil];
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
}

- (IBAction)cancel
{
   [self cancenlBlock:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancenlBlock:nil];
}

- (void)buttonClick:(UIButton *)button
{
    [self cancenlBlock:^{
        if (button.tag == 2) {
            LPostTopicController *post = [[LPostTopicController alloc]init];
            LvZHNavgationController *nav = [[LvZHNavgationController alloc]initWithRootViewController:post];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
            
        }
    }];
}
/**
 *  点击按钮做的方法
 */
- (void)cancenlBlock:(void (^)())cancelBlock
{
    self.view.userInteractionEnabled = NO;
    int index = 2;
    //掉下去的动画
    for (int i = index; i < self.view.subviews.count; i++) {
        UIView *view = self.view.subviews[i];
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.beginTime = CACurrentMediaTime() + (i - index) * TimeInterval;
        //anim.timingFunction 做的是否为线性动画
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(view.x, view.y, view.width, view.height)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(view.x, view.y + screenH, view.width, view.height)];
        [view pop_addAnimation:anim forKey:nil];
        if (i == self.view.subviews.count -1) {
            [anim setCompletionBlock:^(POPAnimation *anim , BOOL finished) {
                self.view.userInteractionEnabled = YES;
                [self dismissViewControllerAnimated:NO completion:nil];
//                if (cancelBlock) {
//                    cancelBlock();
//                }
                !cancelBlock ?  : cancelBlock() ;
               // cancelBlock ? cancelBlock() : ;❌
            }];
        }
    }
}

@end
