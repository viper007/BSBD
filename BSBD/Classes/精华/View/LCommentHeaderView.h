//
//  LCommentHeaderView.h
//  BSBD
//
//  Created by lvzhenhua on 2017/2/27.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCommentHeaderView : UITableViewHeaderFooterView
/** 设置标题  */
@property (nonatomic ,copy) NSString *title;
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
