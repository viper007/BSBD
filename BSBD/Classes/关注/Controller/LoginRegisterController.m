//
//  LoginRegisterController.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/6.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

/*
 *改变对应的文本框的聚焦的颜色和占位字符串的颜色
 */
#import "LoginRegisterController.h"
#import <ShareSDK/ShareSDK.h>
@interface LoginRegisterController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginLeftMargin;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipe;

@end

@implementation LoginRegisterController
- (IBAction)back {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)logout:(UISwipeGestureRecognizer *)sender {
    [self back];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)showLoginOrReg:(UIButton *)sender {
    
    [self.view endEditing:YES];
    //在这里要注意设置右边的时候
    if (self.loginLeftMargin.constant == 0) {
        self.loginLeftMargin.constant = - screenW;
        sender.selected = YES;
    }else{
        self.loginLeftMargin.constant = 0;
        sender.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)QQLogin {
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            NSLog(@"uid=%@",user.uid);
            NSLog(@"%@",user.credential);
            NSLog(@"token=%@",user.credential.token);
            NSLog(@"nickname=%@",user.nickname);
        }else{
            NSLog(@"-----%@",error);
        }
    }];
}
- (IBAction)sinaWeiboLogin {
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            NSLog(@"uid=%@",user.uid);
            NSLog(@"%@",user.credential);
            NSLog(@"token=%@",user.credential.token);
            NSLog(@"nickname=%@",user.nickname);
        }else{
            NSLog(@"%@",error);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
