//
//  NSDate+LExtension.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/11.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LExtension)
/** 返回一个日期与当前时间的时间差 */
- (NSDateComponents *)time_intervalFrom:(NSDate *)from;
/** 是否为今年 */
- (BOOL)isThisYear;
/** 是否为今天 */
- (BOOL)isToday;
/** 是否为昨天 */
- (BOOL)isYesterday;
@end
