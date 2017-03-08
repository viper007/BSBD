//
//  LvZHTabBar.m
//  BSBD
//
//  Created by lvzhenhua on 2016/12/31.
//  Copyright © 2016年 lvzhenhua. All rights reserved.
//

// 添加的时候注意添加的顺序，如果一起设置的话，不知道什么时候添加进去的。

#import "LvZHTabBar.h"
#import "LPublishController.h"
@interface LvZHTabBar ()

/*! @brief 发布按钮  */
@property (nonatomic ,strong) UIButton *publishButton;

@end

@implementation LvZHTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
    //添加发布按钮
        UIButton *publish = [UIButton buttonWithType:UIButtonTypeCustom];
        [publish setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publish setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publish addTarget:self action:@selector(showPublish) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:publish];
        self.publishButton = publish;
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];//这个方法要写到上面自己布局的要覆盖系统的
    //自动布局
    //
    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    CGFloat buttonY = 0 ;
    CGFloat buttonW = self.width/5;
    CGFloat buttonH = self.height;
    NSUInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]]||button==self.publishButton) continue;
        CGFloat buttonX = buttonW * (index > 1?(index+1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index++;
    }
}

- (void)showPublish
{
    LPublishController *publish = [[LPublishController alloc]init];
    publish.view.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:NO completion:nil];
    
}
@end
