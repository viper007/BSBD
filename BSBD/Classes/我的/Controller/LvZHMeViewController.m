//
//  LvZHMeViewController.m
//  BSBD
//
//  Created by lvzhenhua on 2016/12/31.
//  Copyright © 2016年 lvzhenhua. All rights reserved.
//

#import "LvZHMeViewController.h"
#import "LMeCell.h"
#import "LFooterView.h"
#import "LFooterModel.h"
#import "LSettingController.h"
@interface LvZHMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

static NSString * const reuseCell= @"me";

@implementation LvZHMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    //
    [self setupTableView];
}
- (void)setupNav
{
    self.navigationItem.title = @"我的";
    //右边按钮
    UIBarButtonItem *setting = [UIBarButtonItem itemWith:@"mine-setting-icon" HighImage:@"mine-setting-icon-click" target:self sel:@selector(settingClick)];
    UIBarButtonItem *night = [UIBarButtonItem itemWith:@"mine-moon-icon" HighImage:@"mine-moon-icon-click" target:self sel:@selector(nightClick)];
    
    self.navigationItem.rightBarButtonItems = @[setting,night];
    
    //背景颜色
    self.view.backgroundColor = LVZHGlobalBgColor;
}
- (void)setupTableView
{
    
    [self.tableView registerClass:[LMeCell class] forCellReuseIdentifier:reuseCell];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = Cell_Margin;
    self.tableView.sectionHeaderHeight = 0;
    //inset
    self.tableView.contentInset = UIEdgeInsetsMake(Cell_Margin - 35, 0, 0, -20);
    [self setNewData];
}

- (void)setNewData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"square";
    param[@"c"] = @"topic";
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        NSArray *array = [LFooterModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        [self setFooterView:array];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"错误出现"];
    }];
}

- (void)setFooterView:(NSArray *)datas
{
    NSUInteger rows = (datas.count+ maxCols -1)/maxCols;
    CGFloat w = screenW/maxCols;
    LFooterView *footer = [[LFooterView alloc]initWithFrame:CGRectMake(0, 0, screenW, w*rows) data:datas];
    self.tableView.tableFooterView = footer;
    //修改contentSize内容正好填充整个tableView
    self.tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(footer.frame));
#warning 这个有个小问题就是出现footer不是在最下面有一部分间隙,多了一个20的高度
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LMeCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCell];
    if (cell == nil) {
        cell = [[LMeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"登录/注册";
    }
    if (indexPath.section == 1) {
        cell.imageView.image = nil;
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
}
- (void)settingClick{
    LSettingController *set = [[LSettingController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:set animated:YES];
}

- (void)nightClick{
    LVLog(@"%d--%s",__LINE__,__func__);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
