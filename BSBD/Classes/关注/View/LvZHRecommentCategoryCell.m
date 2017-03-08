//
//  LvZHRecommentCategoryCell.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/4.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LvZHRecommentCategoryCell.h"
#import "LvZHRecommentModel.h"

@interface LvZHRecommentCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end

@implementation LvZHRecommentCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = LVZHRGEColor(244, 244, 244);
    
//    self.textLabel.textColor = LVZHRGEColor(78, 78, 78);
    self.selectedIndicator.backgroundColor = LVZHRGEColor(219, 21, 26);
    //self.textLabel.highlightedTextColor = LVZHRGEColor(219, 21, 26);//默认进入高亮的时候文字的颜色
    
}

- (void)setCategory:(LvZHRecommentModel *)category{
    _category = category;
    self.textLabel.text = category.name;
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    //重新调整Label的位置信息
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2*self.textLabel.y;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected?self.selectedIndicator.backgroundColor:LVZHRGEColor(78, 78, 78);
}

@end
