//
//  RecommentUserModel.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/4.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommentUserModel : NSObject

/*! @brief 粉丝数  */
@property (nonatomic ,assign) NSInteger fans_count;
/*! @brief 头像  */
@property (nonatomic ,copy) NSString *header;
/*! @brief 昵称  */
@property (nonatomic ,copy) NSString *screen_name;

//"fans_count" = 9437;
//gender = 2;
//header = "http://wimg.spriteapp.cn/profile/large/2015/09/30/560b557be210a_mini.jpg";
//introduction = "";
//"is_follow" = 0;
//"is_vip" = 0;
//"screen_name" = "\U5b59\U900a \U7b491227\U4eba";
//"tiezi_count" = 179;
//uid = 9017486;

@end
