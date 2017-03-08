//
//  LCommentCell.h
//  BSBD
//
//  Created by lvzhenhua on 2017/2/27.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LComment;
@interface LCommentCell : UITableViewCell

/** 评论模型  */
@property (nonatomic ,strong) LComment *comment;
@end
