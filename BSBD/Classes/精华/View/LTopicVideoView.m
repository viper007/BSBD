//
//  LTopicVideoView.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/14.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LTopicVideoView.h"
#import "LTopicModel.h"
#import "LPictureViewController.h"
#import "AVPlayerDemoPlaybackViewController.h"
@interface LTopicVideoView ()
/** 图片  */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 播放次数  */
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
/** 播放时间  */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation LTopicVideoView


- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;//防止拉伸
    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showVideo)]];
}

- (void)showVideo
{
    LPictureViewController *picture = [[LPictureViewController alloc]init];
    picture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picture animated:YES completion:nil];
}
- (void)setTopic:(LTopicModel *)topic
{
    _topic = topic;
    
    //
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    NSInteger minute = topic.videotime/60;
    NSInteger second = topic.videotime%60;
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}
- (IBAction)playButton:(id)sender {
    AVPlayerDemoPlaybackViewController *playVC = [[AVPlayerDemoPlaybackViewController alloc]init];
    playVC.URL = [NSURL URLWithString:self.topic.videouri];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:playVC animated:YES completion:nil];
    
}


@end
