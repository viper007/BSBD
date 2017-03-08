//
//  LTopicTableViewController.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/10.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface LTopicTableViewController : UITableViewController

@property (nonatomic ,assign) TopicType type;
/** 是否是新帖或为首页的帖子  */
@property (nonatomic ,copy) NSString *a;
@end
