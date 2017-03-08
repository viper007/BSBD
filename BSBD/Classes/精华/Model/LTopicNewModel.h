//
//  LTopicNewModel.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/14.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LTopicUserModel;
@interface LTopicNewModel : NSObject
/** voiceTime  */
@property (nonatomic ,assign) NSInteger voicetime;
/** 音频URL  */
@property (nonatomic ,copy) NSString *vioceuri;
/** 评论内容  */
@property (nonatomic ,copy) NSString *content;
/** 点赞数量  */
@property (nonatomic ,assign) NSInteger like_count;
/** 用户个人信息模型  */
@property (nonatomic ,strong) LTopicUserModel *user;
@end
