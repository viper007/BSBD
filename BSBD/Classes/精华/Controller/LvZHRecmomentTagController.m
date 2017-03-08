//
//  LvZHRecmomentTagController.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/5.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LvZHRecmomentTagController.h"
#import "LvZHRecmmomentTagModel.h"
#import <MJExtension.h>
#import "LvZHRecommentTagCell.h"
@interface LvZHRecmomentTagController ()
/*! @brief 模型数组  */
@property (nonatomic ,strong) NSArray *tags;
@end

@implementation LvZHRecmomentTagController

static NSString * const TagsID = @"tags";

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self setupTableView];
    
    [self loadData];

}

/**
 * 设置tableView
 */
- (void)setupTableView{
    self.title = @"推荐标签";
    //
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LvZHRecommentTagCell class]) bundle:nil] forCellReuseIdentifier:TagsID];
    self.tableView.backgroundColor = LVZHGlobalBgColor;
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
}

- (void)loadData{
    //
    [SVProgressHUD show];
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    para[@"a"] = @"tag_recommend";
    para[@"action"] = @"sub";
    para[@"c"] = @"topic";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        [SVProgressHUD dismiss];
        self.tags = [LvZHRecmmomentTagModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载信息失败"];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LvZHRecommentTagCell *cell = [tableView dequeueReusableCellWithIdentifier:TagsID];
    
    cell.recommentTag = self.tags[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
