//
//  LPlaceholderTextView.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/15.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LPlaceholderTextView : UITextView

/** 占位文字  */
@property (nonatomic ,copy) NSString *placeholder;
/**  占位文字的颜色 */
@property (nonatomic ,strong) UIColor *placeholderColor;

@end
