//
//  LvZHRecommentModel.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/4.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LvZHRecommentModel : NSObject
/*! @brief id */
@property (nonatomic ,assign) NSInteger ID;
/*! @brief 数量  */
@property (nonatomic ,assign) NSInteger count;
/*! @brief 名字  */
@property (nonatomic ,copy) NSString *name;

/*! @brief 辅助开发用于记录右边模型数据  */
@property (nonatomic ,strong) NSMutableArray *users;
/*! @brief 总数  */
@property (nonatomic ,assign) NSInteger total;
/*! @brief 总页数  */
@property (nonatomic ,assign) NSInteger current_page;

@end
