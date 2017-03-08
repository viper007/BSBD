//
//  UIView+Extension.h
//  BSBD
//
//  Created by lvzhenhua on 2016/12/31.
//  Copyright © 2016年 lvzhenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/*! @brief width  */
@property (nonatomic ,assign) CGFloat width;
/*! @brief height  */
@property (nonatomic ,assign) CGFloat height;
/*! @brief x  */
@property (nonatomic ,assign) CGFloat x;
/*! @brief y  */
@property (nonatomic ,assign) CGFloat y;
/*! @brief y  */
@property (nonatomic ,assign) CGSize size;
/*! @brief centerX  */
@property (nonatomic ,assign) CGFloat centerX;
/*! @brief centerY  */
@property (nonatomic ,assign) CGFloat centerY;
/** 在分类中声明属性，只会生成方法的声明，不会生成带下划线的实例*/

+ (instancetype)viewFromXib;
@end
