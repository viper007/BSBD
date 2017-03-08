//
//  NSDate+LExtension.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/11.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "NSDate+LExtension.h"

@implementation NSDate (LExtension)

- (NSDateComponents *)time_intervalFrom:(NSDate *)from{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    return [calendar components:unit fromDate:from toDate:self options:0];
}

- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger currentYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return  currentYear == nowYear;
}

/*
- (BOOL)isToday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSDateComponents *selfCmps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    return nowCmps.year==selfCmps.year&&nowCmps.month==selfCmps.month&&nowCmps.day==selfCmps.day;
}
*/
- (BOOL)isToday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";//yyyy-MM-dd HH:mm:ss
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selString = [fmt stringFromDate:self];
    return [nowString isEqualToString:selString];
}
- (BOOL)isYesterday{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *now = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selfDate = [fmt dateFromString:[fmt stringFromDate:self]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:selfDate toDate:now options:0];
    return cmps.year == 0&&cmps.month==0&&cmps.day == 1;
}
@end
