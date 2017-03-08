//
//  UIBarButtonItem+Extension.h
//  BSBD
//
//  Created by lvzhenhua on 2016/12/31.
//  Copyright © 2016年 lvzhenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWith:(NSString *)normalImage HighImage:(NSString *)highImage target:(id)target sel:(SEL)selector;
@end
