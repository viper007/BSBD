//
//  LPlayer.m
//  BSBD
//
//  Created by lvzhenhua on 2017/2/24.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LPlayer.h"
#import <AVFoundation/AVFoundation.h>
@interface LPlayer ()

@property (nonatomic ,assign) BOOL isPlaying;
@property (nonatomic ,strong) AVPlayer *avPlayer;
@property (nonatomic ,strong) NSString *url;
@property (nonatomic ,assign) BOOL playEnd;
@end

@implementation LPlayer

static LPlayer *player = nil;

- (AVPlayer *)avPlayer
{
    if (!_avPlayer) {
        _avPlayer = [[AVPlayer alloc]init];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playDidEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return _avPlayer;
}

+ (LPlayer *)sharedManeger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [[self alloc]init];
    });
    return player;
}

- (void)playWithUrl:(NSString *)url
{
    if (self.playEnd&&self.url == url) {
        [self.avPlayer replaceCurrentItemWithPlayerItem:self.avPlayer.currentItem];
        self.playEnd = NO;
        self.isPlaying = YES;
        return;
    }
    //判断是否正在播放
    if (self.isPlaying) {
        if (self.url == url) {
            return;
        }
    }else{
        if (self.url == url) {
            [self.avPlayer play];
            self.isPlaying = YES;
            return;
        }
    }
    self.url = url;
    AVPlayerItem *newItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]];
    [self.avPlayer replaceCurrentItemWithPlayerItem:newItem];
    [self.avPlayer play];
    self.isPlaying = YES;
}

- (void)pause
{
    [self.avPlayer pause];
    self.isPlaying = NO;
}

- (void)stop
{
    [self.avPlayer pause];
    self.avPlayer = nil;//
    self.isPlaying = NO;
}

/*!
 * @brief 正常播放结束的时候，系统会发出通知
 */
- (void)playDidEnd
{
    self.isPlaying = NO;
    self.playEnd = YES;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(playEnd)]) {
        [self.delegate playEnd];
    }
}

@end
