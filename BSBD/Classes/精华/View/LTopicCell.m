//
//  LTopicCell.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/10.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LTopicCell.h"
#import "LTopicModel.h"
#import <UIImageView+WebCache.h>
#import "LPictureView.h"
#import "LTopicVideoView.h"
#import "LTopicVoiceView.h"

@interface LTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profineImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *authImageView;
@property (weak, nonatomic) IBOutlet UILabel *text_label;


/** 图片帖子中间的内容 */
@property (nonatomic ,strong) LPictureView *pictureView;
/** 视频  */
@property (nonatomic ,weak) LTopicVideoView *videoView;
/** 声音  */
@property (nonatomic ,weak) LTopicVoiceView *voiceView;
@end

@implementation LTopicCell

+ (instancetype)cell
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
- (LPictureView *)pictureView{
    if (!_pictureView) {
        LPictureView *pictureView = [LPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (LTopicVoiceView *)voiceView{
    if (!_voiceView) {
        LTopicVoiceView *voiceView = [LTopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (LTopicVideoView *)videoView{
    if (!_videoView) {
        LTopicVideoView *videoView = [LTopicVideoView viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //去掉系统自动调整的伸缩，以免对自己设置的造成影响
    
    self.autoresizingMask = UIViewAutoresizingNone;
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setTopic:(LTopicModel *)topic
{
    _topic = topic;
    UIImage *placeholderImage = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self.profineImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.profineImageView.image = image ?  [image circleImage] : placeholderImage;
    }];
    
    self.authImageView.hidden = !topic.jie_v;
    self.nameLabel.text = topic.name;
    self.timeLabel.text = topic.create_time;
    //设置正文内容
    self.text_label.text = topic.text;
    [self setupTitle:topic.ding forButton:self.dingButton placeholder:@"定"];
    [self setupTitle:topic.cai forButton:self.caiButton placeholder:@"踩"];
    [self setupTitle:topic.repost forButton:self.repostButton placeholder:@"分享"];
    [self setupTitle:topic.comment forButton:self.commentButton placeholder:@"评论"];
    
    //根据类型添加对应的控件
    if (topic.type == TopicTypePicture) {
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureFrame;
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }else if (topic.type == TopicTypeVideo){
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoFrame;
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
    }else if (topic.type == TopicTypeVoice){
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceFrame;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
    }else{
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
}

- (void)setupTitle:(NSInteger)count forButton:(UIButton *)button placeholder:(NSString *)placeholder{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else if (count > 0){
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame{
    
//    frame.origin.x = Cell_Margin;
//    frame.size.width -= 2 * Cell_Margin;
    frame.origin.y += Cell_Margin;
    frame.size.height = self.topic.cellHeight - Cell_Margin;
    [super setFrame:frame];
}
@end
