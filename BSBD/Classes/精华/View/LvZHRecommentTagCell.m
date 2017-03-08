//
//  LvZHRecommentTagCell.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/5.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LvZHRecommentTagCell.h"
#import "LvZHRecmmomentTagModel.h"
#import <UIImageView+WebCache.h>
@interface LvZHRecommentTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end
@implementation LvZHRecommentTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommentTag:(LvZHRecmmomentTagModel *)recommentTag{
    _recommentTag = recommentTag;
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommentTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommentTag.theme_name;
    NSString *subNumber = nil;
    if (recommentTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd人订阅",recommentTag.sub_number];
    }else{
        subNumber = [NSString stringWithFormat:@"%.1f万人订阅",recommentTag.sub_number / 10000.0];
    }
    self.subNumberLabel.text = subNumber;
}

- (void)setFrame:(CGRect)frame{
    frame.origin.x = 5;
    frame.size.width -= 2*frame.origin.x;
    frame.size.height -= 1;
    [super setFrame:frame];
}
@end
