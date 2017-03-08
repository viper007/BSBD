//
//  LProgressView.h
//  BSBD
//
//  Created by lvzhenhua on 2017/1/13.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <DALabeledCircularProgressView.h>

@interface LProgressView : DALabeledCircularProgressView
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
@end
