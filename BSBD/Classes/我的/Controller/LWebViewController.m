//
//  LWebViewController.m
//  BSBD
//
//  Created by lvzhenhua on 2017/3/1.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LWebViewController.h"

@interface LWebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation LWebViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.webView.delegate = self;
    [self.toolBar layoutIfNeeded];//需要强制刷新一下，不然barButton上的按钮不会按照正常的颜色来显示
}

- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}
- (IBAction)refreshItem:(id)sender {
    [self.webView reload];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.progressView.hidden = NO;
    [UIView animateWithDuration:1.0 animations:^{
        [self.progressView setProgress:0.95 animated:YES];
    }];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIView animateWithDuration:0.05 animations:^{
        [self.progressView setProgress:1.0 animated:YES];
    } completion:^(BOOL finished) {
        self.progressView.hidden = YES;
        self.progressView.progress = 0.0;
        
        //判断是否可以返回或者前进
        self.goBackItem.enabled = webView.canGoBack;
        self.goForwardItem.enabled = webView.canGoForward;
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
