//
//  LPictureView.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/11.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
// 图片帖子中间的imageView上的内容

#import <UIKit/UIKit.h>
@class LTopicModel;
@interface LPictureView : UIView


/*! @brief 帖子模型  */
@property (nonatomic ,strong) LTopicModel *topic;
@end
