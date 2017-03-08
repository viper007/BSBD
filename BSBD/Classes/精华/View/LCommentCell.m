//
//  LCommentCell.m
//  BSBD
//
//  Created by lvzhenhua on 2017/2/27.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LCommentCell.h"
#import "LComment.h"
#import "LTopicUserModel.h"
#import "LPlayer.h"
@interface LCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;

@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation LCommentCell

-(BOOL)canBecomeFirstResponder
{
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setComment:(LComment *)comment
{
    _comment = comment;
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.secImageView.image = [comment.user.sex isEqualToString:TopCommentSexM] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.nickName.text = comment.user.username;
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

- (IBAction)playAudio:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
         [[LPlayer sharedManeger]playWithUrl:self.comment.voiceuri];
    }else{
        [[LPlayer sharedManeger]pause];
    }
}
- (IBAction)praise:(UIButton *)sender {
    NSLog(@"sender");
}


- (void)setFrame:(CGRect)frame
{
    frame.origin.x = Cell_Margin/2;
    frame.size.width -= Cell_Margin;
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
