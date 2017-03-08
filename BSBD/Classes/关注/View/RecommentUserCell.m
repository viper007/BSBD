//
//  RecommentUserCell.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/4.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "RecommentUserCell.h"
#import "RecommentUserModel.h"
#import <UIImageView+WebCache.h>

@interface RecommentUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;


@end
@implementation RecommentUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUser:(RecommentUserModel *)user{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    
    NSString *fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd人订阅",user.fans_count];
    }else{
        fansCount = [NSString stringWithFormat:@"%.1f万人订阅",user.fans_count / 10000.0];
    }
    self.fansCountLabel.text = fansCount;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}
@end
