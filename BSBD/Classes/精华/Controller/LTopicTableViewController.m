//
//  LTopicTableViewController.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/10.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

//可以根据返回的数据的id来加载最新的数据
#import "LTopicTableViewController.h"
#import "LTopicModel.h"
#import <UIImageView+WebCache.h>
#import "LTopicCell.h"
#import "LPlayer.h"
#import "LCommentController.h"
@interface LTopicTableViewController (){
    NSIndexPath *selectedIndexPath;
}

/*! @brief Models  */
@property (nonatomic ,strong) NSMutableArray *topics;

/*! @brief 页码  */
@property (nonatomic ,assign) NSInteger page;
/*! @brief 上次传过来的maxtime  */
@property (nonatomic ,copy) NSString *maxtime;

/*! @brief 判断是否发送多次的请求  */
@property (nonatomic ,strong) NSMutableDictionary *param;
@end

@implementation LTopicTableViewController

static NSString * const TopicID = @"cell";

- (NSMutableDictionary *)param{
    if (!_param) {
        _param = [NSMutableDictionary dictionary];
    }
    return _param;
}

- (NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    [self setupTableView];
    //刷新控件
    [self setupRefresh];
    //
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(videoPlayingCell:) name:NSNotificationVideoPlaying object:nil];
}

- (void)setupTableView{
    self.view.backgroundColor = LVZHGlobalBgColor;
    CGFloat top = TitlesViewH+TitlesViewY;//
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LTopicCell class]) bundle:nil] forCellReuseIdentifier:TopicID];
}
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    //
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}

/**
 * 加载更多的数据
 */
- (void)loadMoreTopics{
    //
    [self.tableView.mj_header endRefreshing];
    self.page++;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = self.a;
    param[@"c"] = @"data";
    param[@"page"] = @(self.page);
    param[@"type"] = @(self.type);
    param[@"maxtime"] = self.maxtime;//第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容
    self.param = param;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        if (self.param != param) return ;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *topics = [LTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:topics];
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.param != param) return ;
        [self.tableView.mj_footer endRefreshing];
        self.page--;
    }];
}
/**
 * 网络请求帖子数据
 */
- (void)loadNewTopics{
    
    [self.tableView.mj_footer endRefreshing];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = self.a;
    param[@"c"] = @"data";
    param[@"type"] = @(self.type);
    self.param = param;
   // param[@"maxtime"] = @"";//第一次加载帖子时候不需要传入此关键字，当需要加载下一页时：需要传入加载上一页时返回值字段“maxtime”中的内容
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        if (self.param != param) return ;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        self.topics = [LTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.param != param) return ;
        [self.tableView.mj_header endRefreshing];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --通知方法
- (void)videoPlayingCell:(NSNotification *)note
{
    NSUInteger index = [self.topics indexOfObject:note.object];
    selectedIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    //[self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //个数为0的话就隐藏底部自动刷新的控件
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicID];
    LTopicModel *topic = self.topics[indexPath.row];
    cell.topic = topic;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LTopicModel *topic = self.topics[indexPath.row];
    return topic.cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect cellOriginalRect = [self.tableView rectForRowAtIndexPath:selectedIndexPath];
    CGRect concertRect = [self.tableView convertRect:cellOriginalRect toView:[self.tableView superview]];
    if (concertRect.origin.y < 99 - concertRect.size.height) {
        [[LPlayer sharedManeger]pause];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCommentController *commentVC = [[LCommentController alloc]init];
    commentVC.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
