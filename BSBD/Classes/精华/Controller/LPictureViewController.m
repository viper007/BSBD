//
//  LPictureViewController.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/13.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LPictureViewController.h"
#import "LProgressView.h"
#import "LTopicModel.h"
#import <FLAnimatedImageView.h>
#import <FLAnimatedImage.h>
@interface LPictureViewController ()
/**  滑动view */
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** 进度条 */
@property (weak, nonatomic) IBOutlet LProgressView *progressView;

/** imageView  */
@property (nonatomic ,weak) FLAnimatedImageView *imageView;
@end

@implementation LPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.progressView setProgress:self.topic.pictureProgress animated:NO];
    //添加imageView
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.backgroundColor = [UIColor yellowColor];
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    //判断下载的图片的大小()
    CGFloat imageW = screenW;
    CGFloat imageH = self.topic.height * screenW /self.topic.width;
    CGFloat macHeight = 19000;
    if (imageH > screenH && imageH < macHeight) {//大于屏幕的宽度，计算对应的图片的高度
        self.imageView.frame = CGRectMake(0, 0, imageW, imageH);
        self.scrollView.contentSize = CGSizeMake(0, imageH) ;//等比例压缩，后期改进为服务器传的对应的值
    }else if(imageH <= screenH){//小于屏幕的高度
        self.imageView.size = CGSizeMake(imageW, imageH);
        self.imageView.centerX = screenW * 0.5;
        self.imageView.centerY = screenH *0.5;
    }else{
        self.imageView.frame = CGRectMake(0, 0, imageW, macHeight);
        self.scrollView.contentSize = CGSizeMake(0, macHeight);
    }
    
    //就以真实的来显示
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.middle_image] placeholderImage:nil options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *url) {
        CGFloat progress = receivedSize * 1.0 /expectedSize;
        [self.progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
            if ([self.topic.middle_image hasSuffix:@"gif"]) {
                NSData *data = [[SDWebImageManager sharedManager].imageCache diskImageDataBySearchingAllPathsForKey:self.topic.middle_image];
                FLAnimatedImage * AnmImage = [FLAnimatedImage animatedImageWithGIFData:data];
                self.imageView.animatedImage = AnmImage;
            }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 * 返回
 */
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
/** 保存图片  */
- (IBAction)savePicture {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);
}
/** 保存图片回调方法  */
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功"];
    }
}
/** 分享图片  */
- (IBAction)repostPicture {
    [SVProgressHUD showInfoWithStatus:@"该功能暂未开放"];
}


@end
