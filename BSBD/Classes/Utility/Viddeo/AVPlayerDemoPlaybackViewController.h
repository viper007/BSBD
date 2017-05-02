

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class AVPlayer;
@class AVPlayerDemoPlaybackView;

@interface AVPlayerDemoPlaybackViewController : UIViewController
{
@private
	IBOutlet AVPlayerDemoPlaybackView* mPlaybackView;
	
	IBOutlet UISlider* mScrubber;
    IBOutlet UIToolbar *mToolbar;
    IBOutlet UIBarButtonItem *mPlayButton;
    IBOutlet UIBarButtonItem *mStopButton;

    __weak IBOutlet UIButton *startTime;
    __weak IBOutlet UIButton *totalTime;
	float mRestoreAfterScrubbingRate;
	BOOL seekToZeroBeforePlay;
	id mTimeObserver;
	BOOL isSeeking;

	NSURL* mURL;
    
	AVPlayer* mPlayer;
    AVPlayerItem * mPlayerItem;
}

@property (nonatomic, copy) NSURL* URL;
@property (readwrite, strong, setter=setPlayer:, getter=player) AVPlayer* mPlayer;
@property (strong) AVPlayerItem* mPlayerItem;
@property (nonatomic, strong) IBOutlet AVPlayerDemoPlaybackView *mPlaybackView;
@property (nonatomic, strong) IBOutlet UIToolbar *mToolbar;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *mPlayButton;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *mStopButton;
@property (nonatomic, strong) IBOutlet UISlider* mScrubber;

- (IBAction)play:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)showMetadata:(id)sender;

@end
