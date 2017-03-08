//
//  LvZHnewViewController.m
//  BSBD
//
//  Created by lvzhenhua on 2016/12/31.
//  Copyright © 2016年 lvzhenhua. All rights reserved.
//

#import "LvZHNewViewController.h"

@interface LvZHNewViewController ()

@end

@implementation LvZHNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.view.backgroundColor = LVZHGlobalBgColor;
}

- (NSString *)getRequestType{
    return @"newlist";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
