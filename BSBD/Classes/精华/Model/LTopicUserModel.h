//
//  LTopicUserModel.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/14.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTopicUserModel : NSObject
/** 用户名  */
@property (nonatomic ,copy) NSString *username;
/** 性别  */
@property (nonatomic ,copy) NSString *sex;
/** 头像  */
@property (nonatomic ,copy) NSString *profile_image;
@end
