//
//  LPostTopicView.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/20.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LPostTopicView.h"
#import "LAddTagViewController.h"

@interface LPostTopicView ()

@property (weak, nonatomic) IBOutlet UIButton *addButton;

/** 标签数组  */
@property (nonatomic ,strong) NSMutableArray *tags;
@end

@implementation LPostTopicView

- (NSMutableArray *)tags
{
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return  _tags;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}
- (IBAction)addTag {
    
    LAddTagViewController *addTag = [[LAddTagViewController alloc]init];
    [addTag setCompleteBlock:^(NSMutableArray *tags) {
        //遍历数组
        [tags enumerateObjectsUsingBlock:^(UIButton  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.tags addObject:obj.currentTitle];
        }];
        //刷新页面
        [self layoutIfNeeded];
    }];
    UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:addTag animated:YES];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSLog(@"%@",self.tags);
}


@end
