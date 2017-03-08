//
//  LAddTagTextField.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/27.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LAddTagTextField : UITextField

/** 删除对应的标签  */
@property (nonatomic ,copy) void(^deleteBlock)() ;

@end
