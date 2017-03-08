//
//  LTopicCell.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/10.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTopicModel;
@interface LTopicCell : UITableViewCell
+ (instancetype)cell;
/*! @brief 帖子模型  */
@property (nonatomic ,strong) LTopicModel *topic;
@end
