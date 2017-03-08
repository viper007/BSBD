//
//  LSettingController.m
//  BSBD
//
//  Created by lvzhenhua on 2017/3/2.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LSettingController.h"
#import <SDImageCache.h>
@interface LSettingController ()

@end

@implementation LSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView.backgroundColor = LVZHGlobalBgColor;
    LVLog(@"%@",NSHomeDirectory());
    self.tableView.contentInset = UIEdgeInsetsMake(Cell_Margin - 35, 0, 0, -20);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    CGFloat resultSize = size/1000.0/1000;
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(%.1fM)",resultSize];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [[SDImageCache sharedImageCache]clearDiskOnCompletion:^{
        cell.textLabel.text = @"清除缓存(0.0M)";
    }];
}
@end
