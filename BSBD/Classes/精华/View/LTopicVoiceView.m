//
//  LTopicVoiceView.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/14.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LTopicVoiceView.h"
#import "LPictureViewController.h"
#import "LTopicModel.h"
#import "LPlayer.h"
#import <AVFoundation/AVFoundation.h>
@interface LTopicVoiceView ()<AVPlayDidEndDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) UIButton *playButton;

@end

@implementation LTopicVoiceView


- (void)awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;//防止拉伸
    self.imageView.userInteractionEnabled = YES;
    
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showVoice)]];
    //添加播放完成的回调代理
    [LPlayer sharedManeger].delegate = self;
    
}

- (void)showVoice
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
    
    NSString *playCount ;
    if (topic.playcount > 10000) {
        playCount = [NSString stringWithFormat:@"%.1f万播放",topic.playfcount/10000.0];
    }else{
        playCount = [NSString stringWithFormat:@"%zd播放",topic.playfcount];
    }
    
    self.playcountLabel.text = playCount;
    NSInteger minute = topic.voicetime/60;
    NSInteger second = topic.voicetime%60;
    self.timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

- (IBAction)playMusic:(UIButton *)sender {//播放音乐
    if (self.topic.voiceuri) {
        self.topic.isVideoPlaying = sender.selected = !sender.selected;
        if (sender.selected) {
            [[LPlayer sharedManeger]playWithUrl:self.topic.voiceuri];
        }else{
            [[LPlayer sharedManeger]pause];
        }
    }
    //添加一个cell划出屏幕后停止的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationVideoPlaying object:self.topic];
    self.playButton = sender;
}

- (void)playEnd
{
    self.playButton.selected = NO;
}
@end
