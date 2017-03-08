//
//  RecomentViewController.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/3.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

/**
  * 有时候会出现对应的底部的问题，这个是返回的数据的问题。返回的总个数与返回的元素的个数不一致
  */

#import "RecomentViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "LvZHRecommentCategoryCell.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "LvZHRecommentModel.h"
#import "RecommentUserCell.h"
#import "RecommentUserModel.h"
#define SelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
@interface RecomentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/*! @brief 数量  */
@property (nonatomic ,strong) NSArray *categories;

@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (nonatomic ,strong) NSMutableDictionary *para;
/*! @brief 请求管理者  */
@property (nonatomic ,strong) AFHTTPSessionManager *manager;
@end

@implementation RecomentViewController
/*
 * storyBoard可以创建动态的cell
 * Xib需要创建新的一个Xib
 */
static NSString * const categoryID = @"category";
static NSString * const userID = @"user";

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    [self setupTableView];
    //刷新
    [self setupRefresh];
    //1.
    [SVProgressHUD show];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"category";
    para[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        self.categories = [LvZHRecommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        [SVProgressHUD dismiss];
        //选中状态
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.mj_header beginRefreshing];//开始刷新会调用loadNewUsers这个方法
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载信息失败"];
        
    }];
}

- (void)setupTableView{
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LvZHRecommentCategoryCell class]) bundle:nil] forCellReuseIdentifier:categoryID];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([RecommentUserCell class]) bundle:nil] forCellReuseIdentifier:userID];
    //
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.userTableView.contentInset = self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.rowHeight = 70.0f;
    //
    self.title = @"推荐关注";
    self.userTableView.backgroundColor = LVZHGlobalBgColor;
    
}

- (void)setupRefresh{
    
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.userTableView.mj_footer.hidden = YES;
}
- (void)loadNewUsers{
    
    LvZHRecommentModel *model = SelectedCategory;
    model.current_page = 1;
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"list";
    para[@"c"] = @"subscribe";
    para[@"category_id"] = @(model.ID);
    para[@"page"] = @(model.current_page);
    self.para = para;
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        if (self.para != para)return ;
        //删除以前的所有旧数据
        [model.users removeAllObjects];
        NSArray *users = [RecommentUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加数据
        [model.users addObjectsFromArray:users];
        model.total = [responseObject[@"total"] integerValue];
        [self.userTableView reloadData];
        //结束刷新标志
        [self.userTableView.mj_header endRefreshing];
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.para != para)return ;
        [SVProgressHUD showErrorWithStatus:@"加载信息失败"];
        [self.userTableView.mj_header endRefreshing];
    }];

}
- (void)loadMore{
    
    LvZHRecommentModel *model = SelectedCategory;
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"list";
    para[@"c"] = @"subscribe";
    para[@"category_id"] = @(model.ID);
    para[@"page"] = @(++model.current_page);
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.para != para)return ;
        //
        NSArray *users = [RecommentUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加数据
        [model.users addObjectsFromArray:users];
        [self.userTableView reloadData];
        //结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.para != para)return ;
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        [self.userTableView.mj_footer endRefreshing];
    }];

}

/*!
 * @brief 检查底部控件的状态
 */
- (void)checkFooterState{
    LvZHRecommentModel *model = SelectedCategory;
    self.userTableView.mj_footer.hidden = (model.users.count == 0);
    if (model.users.count == model.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.userTableView.mj_footer endRefreshing];
    }
}
#pragma mark --UItableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.categoryTableView)
       return self.categories.count;
   //else
       [self checkFooterState];
       return [SelectedCategory users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.categoryTableView) {
        LvZHRecommentCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        cell.category = self.categories[indexPath.row];
        return cell;

    }else{
        RecommentUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userID];
        cell.user = [SelectedCategory users][indexPath.row];
        return cell;
    }
    
}

#pragma mark --uitableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.categoryTableView) {
        
        LvZHRecommentModel *model = self.categories[indexPath.row];
        if (model.users.count) {
            [self.userTableView reloadData];
        }else{
            [self.userTableView reloadData];
            [self.userTableView.mj_header beginRefreshing];
        }
    }
   
}

- (void)dealloc{//防止控制器销毁，但是网络请求回来使得控制器，崩溃
    [self.manager.operationQueue cancelAllOperations];
    [SVProgressHUD dismiss];
}
/**
  *目前只显示一页
  *重复发送请求()
  *网速慢带来的烦恼
 */
@end
