//
//  LCommentHeaderView.m
//  BSBD
//
//  Created by lvzhenhua on 2017/2/27.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LCommentHeaderView.h"

@interface LCommentHeaderView ()

@property (nonatomic ,weak) UILabel *label;

@end

@implementation LCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"header";
    LCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[LCommentHeaderView alloc]initWithReuseIdentifier:ID];
    }
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
    self.contentView.backgroundColor = LVZHGlobalBgColor;
    
    // 创建label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = LVZHRGEColor(67, 67, 67);
    label.width = 200;
    label.x = Cell_Margin;
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;//竖直方向拉伸，根据父视图拉伸
    [self.contentView addSubview:label];
    self.label = label;
    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.label.text = title;
    
}
@end
