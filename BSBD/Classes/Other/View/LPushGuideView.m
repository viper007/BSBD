//
//  LPushGuideView.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/6.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LPushGuideView.h"

@implementation LPushGuideView

+ (void)show{
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][key];
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]stringForKey:key];
    if (![lastVersion isEqualToString:currentVersion]) {
        //添加引导图
        UIWindow *window = [[UIApplication sharedApplication]keyWindow];
        LPushGuideView *guide = [LPushGuideView guideView];
        guide.frame = window.bounds;
        [window addSubview:guide];
        //保存
        [[NSUserDefaults standardUserDefaults]setValue:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}
+ (instancetype)guideView{
    return [[[NSBundle mainBundle]loadNibNamed:@"LPushGuide" owner:nil options:nil] firstObject];
}
- (IBAction)removeGuideView {
     [self removeFromSuperview];
}

@end
