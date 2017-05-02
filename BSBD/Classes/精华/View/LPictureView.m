//
//  LPictureView.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/11.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LPictureView.h"
#import "LTopicModel.h"
#import <UIImageView+WebCache.h>
#import "LPictureViewController.h"
#import "LProgressView.h"
//#import <UIImage+GIF.h>
//#import <ImageIO/ImageIO.h>
//#import <CoreMedia/CoreMedia.h>
#import <FLAnimatedImageView.h>
#import <FLAnimatedImage.h>
#import <SDImageCache.h>
@interface LPictureView ()
/** 图片 */
@property (weak, nonatomic) IBOutlet FLAnimatedImageView *animatedImage;

/** gif图标 */
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seelargeButton;
/** 进度条 */
@property (weak, nonatomic) IBOutlet LProgressView *progressView;

@end

@implementation LPictureView



- (void)awakeFromNib{
   [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.animatedImage.userInteractionEnabled = YES;
    
    [self.animatedImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
}
- (IBAction)showPicture {
    //
    LPictureViewController *picture = [[LPictureViewController alloc]init];
    picture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picture animated:YES completion:nil];
}


- (void)setTopic:(LTopicModel *)topic{
    
    _topic = topic;
    
    //防止网速慢，循环利用显示其他的进度值
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    
    [self.animatedImage sd_setImageWithURL:[NSURL URLWithString:topic.small_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize ,NSURL *url) {
        self.progressView.hidden = NO;
        topic.pictureProgress = receivedSize * 1.0 /expectedSize;
        [self.progressView setProgress:topic.pictureProgress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        if (topic.isBigPicture) {
            UIGraphicsBeginImageContextWithOptions(topic.pictureFrame.size, YES, 0.0);
            //将图片缩放
            CGFloat width = topic.pictureFrame.size.width;
            CGFloat height = width * image.size.height / image.size.width;
            [image drawInRect:CGRectMake(0, 0, width, height)];
            self.animatedImage.image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //找到存在对应的文件夹下的图片资源播放
                NSData *data = [[SDWebImageManager sharedManager].imageCache diskImageDataBySearchingAllPathsForKey:topic.small_image];
                FLAnimatedImage * AnmImage = [FLAnimatedImage animatedImageWithGIFData:data];
                self.animatedImage.animatedImage = AnmImage;
            });
        }
        //self.animatedImageView.image = image;
    }];
    
    //怎么去判断是否显示图标？？ 还有是否显示点击查看大图的图
    
    //是否为gif图片
    NSString *paht = topic.large_image.pathExtension;
    self.gifImageView.hidden = ![paht.lowercaseString isEqualToString:@"gif"];
    //是否为大图
    if (topic.isBigPicture) {
        self.seelargeButton.hidden = NO;
    }else{
        self.seelargeButton.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame
{
    if (frame.size.width == 0 || frame.size.height == 0) {
        self.gifImageView.hidden = YES;
    }
    [super setFrame:frame];
}
//+ (UIImage *)sd_animatedGIFWithData:(NSData *)data {
//    if (!data) {
//        return nil;
//    }
//    
//    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
//    
//    size_t count = CGImageSourceGetCount(source);
//    
//    UIImage *animatedImage;
//    
//    if (count <= 1) {
//        animatedImage = [[UIImage alloc] initWithData:data];
//    }
//    else {
//        NSMutableArray *images = [NSMutableArray array];
//        
//        NSTimeInterval duration = 0.0f;
//        
//        for (size_t i = 0; i < count; i++) {
//            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
//            
//            duration += [[self class] sd_frameDurationAtIndex:i source:source];
//            
//            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
//            
//            CGImageRelease(image);
//        }
//        
//        if (!duration) {
//            duration = (1.0f / 10.0f) * count;
//        }
//        
//        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
//    }
//    
//    CFRelease(source);
//    
//    return animatedImage;
//}
//
//+ (NSTimeInterval)sd_frameDurationAtIndex:(size_t)index source:(CGImageSourceRef)source
//{
//   NSDictionary *dic = CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source, index,nil));
//    NSLog(@"%@",dic);
//    return  0;
//    
//}
@end
