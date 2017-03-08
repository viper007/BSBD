//
//  LvZHNavgationController.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/3.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LvZHNavgationController.h"

@interface LvZHNavgationController ()<UINavigationControllerDelegate>

@end

@implementation LvZHNavgationController

+ (void)initialize{
    
     UINavigationBar *bar = [UINavigationBar appearance];
     [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
     [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    //
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    attrs[NSForegroundColorAttributeName] = [UIColor blueColor];
    
    NSMutableDictionary *disabledAttrs = [NSMutableDictionary dictionary];
    disabledAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    disabledAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    disabledAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:disabledAttrs forState:UIControlStateDisabled];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.delegate = self;
    //如果滑动控制器失效，清空代理（导航控制器会重新设置这个功能）
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //系统加载VC的时候也是push进来的，需要先
    
    if (self.childViewControllers.count > 0) {
        UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
        [item setTitle:@"返回" forState:UIControlStateNormal];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [item setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        item.titleLabel.font = [UIFont systemFontOfSize:14];
        [item sizeToFit];
        item.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        item.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [item addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:item];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //
    //LVLog(@"%d--%s---%@--%@",__LINE__,__func__,viewController,
      //    self.topViewController);
    //在这里可以拿到对应的控制
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}


#pragma mark --

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    LVLog(@"%d--%s---%@",__LINE__,__func__,viewController);
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    LVLog(@"%d--%s---%@",__LINE__,__func__,viewController);
}

//- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController{
//    LVLog(@"%d--%s",__LINE__,__func__);
//    return UIInterfaceOrientationMaskAllButUpsideDown;
//}
//- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController {
//    LVLog(@"%d--%s",__LINE__,__func__);
//    return  UIInterfaceOrientationPortrait;
//}
//
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    LVLog(@"%d--%s",__LINE__,__func__);
    return nil;
    
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    LVLog(@"%d--%s",__LINE__,__func__);
    return nil;
}
@end
