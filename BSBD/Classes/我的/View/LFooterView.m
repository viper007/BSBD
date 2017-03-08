//
//  LFooterView.m
//  BSBD
//
//  Created by lvzhenhua on 2017/3/1.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LFooterView.h"
#import "LFooterModel.h"
#import "LSquareButton.h"
#import "LvZHTabBarViewController.h"
#import "LWebViewController.h"
#import "LvZHNavgationController.h"
@implementation LFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame data:(NSArray *)datas
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self createSquares:datas];
    }
    return self;
}

- (void)createSquares:(NSArray *)squares
{
    int maxCols = 4;
    // 宽度和高度
    CGFloat buttonW = screenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i<squares.count; i++) {
        // 创建按钮
        LSquareButton *button = [LSquareButton buttonWithType:UIButtonTypeCustom];
        // 监听点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 传递模型
        button.square = squares[i];
        [self addSubview:button];
        
        // 计算frame
        int col = i % maxCols;
        int row = i / maxCols;
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
}

- (void)buttonClick:(LSquareButton *)sender
{
    if (![sender.square.url hasPrefix:@"http"])return;
    LvZHTabBarViewController *tabVC = (LvZHTabBarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
     LvZHNavgationController *nav = tabVC.selectedViewController;
    
    //
    LWebViewController *web = [[LWebViewController alloc]init];
    web.url = sender.square.url;
    web.title = sender.square.name;
    [nav pushViewController:web animated:YES];
}

@end
