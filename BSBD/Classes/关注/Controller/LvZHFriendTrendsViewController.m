//
//  LvZHFriendTrendsViewController.m
//  BSBD
//
//  Created by lvzhenhua on 2016/12/31.
//  Copyright © 2016年 lvzhenhua. All rights reserved.
//

#import "LvZHFriendTrendsViewController.h"
#import "RecomentViewController.h"
#import "LoginRegisterController.h"
@interface LvZHFriendTrendsViewController ()
/*
 * Option+enter 在Xib里面对对应的文字进行换行
 */
@end

@implementation LvZHFriendTrendsViewController
- (IBAction)login:(UIButton *)sender {
    LoginRegisterController *login = [[LoginRegisterController alloc]init];
    [self presentViewController:login animated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.这个只是设置导航栏的标题 
    self.navigationItem.title = @"关注";
   /** self.title = @"我的关注";//等价于
    self.navigationItem.title = @"我的关注";
    self.tabBarItem.title = @"我的关注";*/
    
    //左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWith:@"friendsRecommentIcon" HighImage:@"friendsRecommentIcon-click" target:self sel:@selector(tagFriendClick)];
    //背景颜色
    self.view.backgroundColor = LVZHGlobalBgColor;
}

- (void)tagFriendClick{
    RecomentViewController *recomet = [[RecomentViewController alloc]init];
    [self.navigationController pushViewController:recomet animated:YES];
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
