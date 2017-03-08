//
//  LPostTopicController.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/15.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
// 一般查看自身类里面有没有对应的属性或者方法来解决对应的办法，没有继续找父类或者寻找继承的协议是否有对应的方法（属性等）

#import "LPostTopicController.h"
#import "LPlaceholderTextView.h"
#import "LPostTopicView.h"

@interface LPostTopicController ()<UITextViewDelegate>

/** textView  */
@property (nonatomic ,weak) LPlaceholderTextView *textView;
/** 工具条  */
@property (nonatomic ,weak) LPostTopicView *toolBar;

@end

@implementation LPostTopicController

#pragma mark --懒加载


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolbar];
}

/**
 * 监听键盘的弹出和隐藏
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    
    // 键盘最终的frame
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 动画时间
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0,  keyboardF.origin.y - screenH);
    }];
}

- (void)setupToolbar
{
    LPostTopicView *toolbar = [LPostTopicView viewFromXib];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolBar = toolbar;
    //可能是懒加载的问题吧
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupTextView
{
    LPlaceholderTextView *textView = [[LPlaceholderTextView alloc] init];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    textView.frame = self.view.bounds;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
}

- (void)setupNav
{
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO; // 默认不能点击
    // 强制刷新
    [self.navigationController.navigationBar layoutIfNeeded];
}

- (void)cancel
{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    NSLog(@"post");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 先退出之前的键盘
    [self.view endEditing:YES];
    // 再叫出键盘
    [self.textView becomeFirstResponder];
}

#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
