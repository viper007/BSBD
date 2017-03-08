//
//  LvZHTabBarViewController.m
//  BSBD
//
//  Created by lvzhenhua on 2016/12/31.
//  Copyright © 2016年 lvzhenhua. All rights reserved.
//

#import "LvZHTabBarViewController.h"
#import "LvZHEssenceViewController.h"
#import "LvZHNewViewController.h"
#import "LvZHFriendTrendsViewController.h"
#import "LvZHMeViewController.h"
#import "LvZHTabBar.h"
#import "LvZHNavgationController.h"
@interface LvZHTabBarViewController ()

@end
/*
 *
 */
@implementation LvZHTabBarViewController

+ (void)initialize{
    //带有UI_APPEARANCE_SELECTOR可以设置全局的一致性

    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSFontAttributeName] = attr[NSFontAttributeName];
    selectedAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:attr forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
       //添加自控制器
    
    //在这里注意图片渲染的问题有两种方式
    //1.可以设置渲染模式为->UIImageRenderingModeAlwaysOriginal，默认的是default的
    //2.可以选中图片在对应的最右边设置render as这个勾选为original 
   
    [self setupChildViewController:[[LvZHEssenceViewController alloc]init] Title:@"精华" NormalImage:@"tabBar_essence_icon" SelectedImage:@"tabBar_essence_click_icon"];
    [self setupChildViewController:[[LvZHNewViewController alloc]init] Title:@"新帖" NormalImage:@"tabBar_new_icon" SelectedImage:@"tabBar_new_click_icon"];
    [self setupChildViewController:[[LvZHFriendTrendsViewController alloc]init] Title:@"关注" NormalImage:@"tabBar_friendTrends_icon" SelectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildViewController:[[LvZHMeViewController alloc]initWithStyle:UITableViewStyleGrouped] Title:@"我" NormalImage:@"tabBar_me_icon" SelectedImage:@"tabBar_me_click_icon"];
     //更换tabBar
    [self setValue:[[LvZHTabBar alloc]init] forKeyPath:@"tabBar"];
}

- (void)setupChildViewController:(UIViewController *)VC Title:(NSString *)title NormalImage:(NSString *)normalImage SelectedImage:(NSString *)selectedImage{
    //设置文字和图片
    VC.tabBarItem.title = title;
    VC.tabBarItem.image = [UIImage imageNamed:normalImage];
    VC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    //在这里加载的时候会全部加载控制器的view，我们应该做到用到的时候才回去加载对应的view
   // VC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    //添加导航控制器
    LvZHNavgationController *nav = [[LvZHNavgationController alloc]initWithRootViewController:VC];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
