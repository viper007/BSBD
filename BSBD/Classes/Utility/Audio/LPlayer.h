//
//  LPlayer.h
//  BSBD
//
//  Created by lvzhenhua on 2017/2/24.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AVPlayDidEndDelegate <NSObject>

@required
- (void)playEnd;

@end
@interface LPlayer : NSObject

@property (nonatomic ,weak) id<AVPlayDidEndDelegate> delegate;

+ (LPlayer *)sharedManeger;
- (void)playWithUrl:(NSString *)url;
- (void)stop;
- (void)pause;
- (BOOL)isPlaying;

@end
