//
//  LvZHRecmmomentTagModel.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/5.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LvZHRecmmomentTagModel : NSObject

/*! @brief 头像  */
@property (nonatomic ,copy) NSString *image_list;
/*! @brief 订阅数  */
@property (nonatomic ,assign) NSInteger sub_number;
/*! @brief 名字  */
@property (nonatomic ,copy) NSString *theme_name;
//"image_list" = "http://img.spriteapp.cn/ugc/2014/07/29/140324_27071.jpg";
//"is_default" = 0;
//"is_sub" = 0;
//"sub_number" = 179389;
//"theme_id" = 9;
//"theme_name"
@end
