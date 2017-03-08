//
//  LvZHRecommentModel.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/4.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LvZHRecommentModel.h"

@implementation LvZHRecommentModel
- (NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID" : @"id"};
}
@end
