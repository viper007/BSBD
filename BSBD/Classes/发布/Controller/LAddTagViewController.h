//
//  LAddTagViewController.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/21.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LAddTagViewController : UIViewController

/** 完成Block  */
@property (nonatomic ,copy) void(^completeBlock)(NSMutableArray *tags);

@end
