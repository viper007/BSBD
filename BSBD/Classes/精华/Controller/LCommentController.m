//
//  LCommentController.m
//  BSBD
//
//  Created by lvzhenhua on 2017/2/26.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LCommentController.h"
#import "LTopicCell.h"
#import "LTopicModel.h"
#import "LPlaceholderTextView.h"
#import "LCommentHeaderView.h"
#import "LComment.h"
#import "LCommentCell.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>
@interface LCommentController ()<UITableViewDataSource,UITableViewDelegate>{
    NSIndexPath *_preIndexPath;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstant;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet LPlaceholderTextView *textView;
/** 最热评论  */
@property (nonatomic ,strong) NSArray *hotComments;
/** 最新评论  */
@property (nonatomic ,strong) NSMutableArray *lastComments;

@property (nonatomic ,strong) AFHTTPSessionManager *manager;
/** <#propertyName#>  */
@property (nonatomic ,assign) NSInteger currentPage;
@end

static NSString * const commentID= @"Cell";

@implementation LCommentController

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        self.manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWith:@"comment_nav_item_share_icon" HighImage:@"comment_nav_item_share_icon_click" target:self sel:@selector(more)];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.backgroundColor = LVZHGlobalBgColor;
    
    self.textView.placeholder = @"写评论...";
    self.textView.placeholderColor = [UIColor lightGrayColor];
    [self setHeader];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)more
{
    UIAlertController *actionsheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *replay = [UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self shareTopic];
    }];
    UIAlertAction *report = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"举报");
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionsheet addAction:replay];
    [actionsheet addAction:report];
    [actionsheet addAction:cancel];
    [self presentViewController:actionsheet animated:YES completion:nil];
}
/**
 * @brief 设置头视图
 */
- (void)setHeader
{
    UIView *header = [[UIView alloc] init];//最好包装一层
    // 添加cell
    LTopicCell *cell = [LTopicCell viewFromXib];
    cell.topic = self.topic;
    cell.size = CGSizeMake(screenW, self.topic.cellHeight);
    [header addSubview:cell];
    // header的高度
    header.height = self.topic.cellHeight + Cell_Margin;
    // 设置header
    self.tableView.tableHeaderView = header;
    self.tableView.delegate = self;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LCommentCell class]) bundle:nil] forCellReuseIdentifier:commentID];
    //
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, Cell_Margin, 0);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer.hidden = YES;
}

- (void)loadNewComments
{
    //
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            [self.tableView.mj_header endRefreshing];
            return;
        } // 说明没有评论数据
        
        // 最热评论
        self.hotComments = [LComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        // 最新评论
        self.lastComments = [LComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        // 页码
        self.currentPage = 1;
        
        // 刷新数据
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.lastComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)loadMoreComments
{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    // 页码
    NSInteger page = self.currentPage + 1;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    LComment *cmt = [self.lastComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params  progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        // 没有数据
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            return;
        }
        // 最新评论
        NSArray *newComments = [LComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.lastComments addObjectsFromArray:newComments];
        
        self.currentPage = page;
        
        // 刷新数据
        [self.tableView reloadData];
        // 控制footer的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.lastComments.count >= total) { // 全部加载完毕
            self.tableView.mj_footer.hidden = YES;
        } else {
            // 结束刷新状态
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];

}
- (void)keyboardWillChange:(NSNotification *)note
{
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomConstant.constant = screenH - frame.origin.y;
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue        ];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}


#pragma mark --UitableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastCount = self.lastComments.count;
    if (hotCount > 0) return 2;
    if (lastCount ) return 1;
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LCommentHeaderView *header = [LCommentHeaderView headerViewWithTableView:tableView];
    
    NSInteger hotCount = self.hotComments.count;
    if (section == 0) {
        header.title = hotCount>0 ? @"最热评论" : @"最新评论";
    }else{
        header.title = @"最新评论";
    }
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.lastComments;
    }
    return self.lastComments;
}

- (LComment *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark --uitableView data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger lastCount = self.lastComments.count;
    
    tableView.mj_footer.hidden = (lastCount == 0);
    if (section == 0) {
        return ((hotCount>0) ? hotCount : lastCount);
    }
    return lastCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentID];
    cell.comment = [self commentInIndexPath:indexPath];
    return cell;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    [[UIMenuController sharedMenuController]setMenuVisible:NO animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }else{
        LCommentCell *cell = (LCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        UIMenuItem *reponse = [[UIMenuItem alloc]initWithTitle:@"回复" action:@selector(reponse:)];
        UIMenuItem *report = [[UIMenuItem alloc]initWithTitle:@"举报" action:@selector(report:)];
        UIMenuItem *support = [[UIMenuItem alloc]initWithTitle:@"顶" action:@selector(support:)];
        menu.menuItems = @[support,reponse,report];
        CGRect rect = CGRectMake(0, cell.height*0.5, cell.width, cell.height*0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
    _preIndexPath = indexPath;
}
- (void)reponse:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}
- (void)report:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}
- (void)support:(UIMenuController *)menu
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%s %@", __func__, [self commentInIndexPath:indexPath].content);
}

- (void)shareTopic
{
    [self shareTopicToView:self.view];
}
- (void)shareTopicToView:(UIView *)view
{
    //1.创建分享参数
    NSArray *imageArray = @[[UIImage imageNamed:@"setup-head-default.png"]];
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"测试分享标题"
                                           type:SSDKContentTypeImage];
        
        [ShareSDK showShareActionSheet:view items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            
        }];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
