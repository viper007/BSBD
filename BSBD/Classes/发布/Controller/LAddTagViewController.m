//
//  LAddTagViewController.m
//  BSBD
//
//  Created by lvzhenhua on 2017/1/21.
//  Copyright © 2017年 lvzhenhua. All rights reserved.
//

#import "LAddTagViewController.h"
#import "LAddTagButton.h"
#import "LAddTagTextField.h"
@interface LAddTagViewController ()<UITextFieldDelegate>

/** contentView  */
@property (nonatomic ,weak) UIView *tagsView;

/** 占位文字  */
@property (nonatomic ,weak) LAddTagTextField *textFiled;

/** 添加按钮  */
@property (nonatomic ,weak) UIButton *addButton;

/** 标签数组  */
@property (nonatomic ,strong) NSMutableArray *tags;
@end

@implementation LAddTagViewController

#pragma mark --懒加载

/**
 * 数组（添加的标签）
 */
-(NSMutableArray *)tags
{
    if (!_tags) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}

/**
 * 添加按钮懒加载
 */
- (UIButton *)addButton
{
    if (!_addButton) {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.height = 35;
        addButton.width = self.tagsView.width;
        //
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addButton.backgroundColor = LVZHRGEColor(68, 180, 251);
        addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        addButton.titleEdgeInsets = UIEdgeInsetsMake(0, addTags_margin, 0, addTags_margin);
        [addButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        addButton.hidden = YES;
        [self.tagsView addSubview:addButton];
        self.addButton = addButton;
    }
    return _addButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTagsView];
}

/** 
  *  设置导航栏
  */
- (void)setupNav
{
    self.title = @"添加标签";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

/**
 * 添加标签view的基本配置
 */
- (void)setupTagsView
{
    UIView *tagsView = [[UIView alloc]init];
    tagsView.backgroundColor = [UIColor yellowColor];
    tagsView.x = addTags_margin;
    tagsView.width = screenW - 2 * tagsView.x;
    tagsView.y = 64;
    tagsView.height = screenH - tagsView.y;
    [self.view addSubview:tagsView];
    self.tagsView = tagsView;
    //添加占位文字
    
    typeof(self) weakSelf = self;
    LAddTagTextField *textField = [[LAddTagTextField alloc]init];
    textField.deleteBlock = ^{
        LAddTagButton *tagButton = [weakSelf.tags lastObject];
        [tagButton removeFromSuperview];
        [weakSelf.tags removeLastObject];
        [UIView animateWithDuration:0.25 animations:^{
            [weakSelf createTags];
        }];
    };
    textField.placeholder = @"点击逗号或者完成添加标签";
    textField.x = 0;
    textField.y = 0;
    textField.width = tagsView.width;
    textField.height = 30;
    textField.delegate = self;
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [tagsView addSubview:textField];
    self.textFiled = textField;
}


#pragma mark --Method

/**
 * 创建标签按钮
 */
- (void)createTags
{
    for (int i = 0; i<self.tags.count; i++) {
        LAddTagButton *button = self.tags[i];
        if (i == 0) {
            button.x = 0;
            button.y = 0;
        }else{
            //上一个按钮
            LAddTagButton *lastButton = self.tags[i-1];
            //计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastButton.frame)+addTags_margin;
            //计算当前行右边的宽度
            CGFloat rightWidth = self.tagsView.width - leftWidth;
            if (rightWidth >= button.width) {//放到当前行
                button.x = leftWidth;
                button.y = lastButton.y;
            }else{//放到下一行
                button.x = 0;
                button.y = CGRectGetMaxY(lastButton.frame)+addTags_margin;
            }
        }
        [self.tagsView addSubview:button];
    }
    [self updataTextFieldFrame];
}

/**
 * 点击完成返回上一个页面
 */
- (void)done
{
    !self.completeBlock ? : self.completeBlock(self.tags);
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * 点击添加标签
 */
- (void)addButtonClick:(UIButton *)button
{
    [self addTags];
}

/**
 * 添加标签
 */
- (void)addTags
{
    if (self.tags.count == 5) {
        [SVProgressHUD showInfoWithStatus:@"最多只能添加五个标签"];
        return;
    }
    
    //1.添加对应的标签
    LAddTagButton *tagButton = [[LAddTagButton alloc]init];
    //判断标点符号
    NSString *lastWordd = [self.textFiled.text substringWithRange:NSMakeRange(self.textFiled.text.length-1, 1)];
    if ([lastWordd isEqualToString:@","]||[lastWordd isEqualToString:@"，"]) {
        [tagButton setTitle:[self.textFiled.text substringWithRange:NSMakeRange(0, self.textFiled.text.length-1)] forState:UIControlStateNormal];
    }else{
        [tagButton setTitle:self.textFiled.text forState:UIControlStateNormal];
    }
    [tagButton addTarget:self action:@selector(deleteTagButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.tags addObject:tagButton];
    //2.排列按钮
    [self createTags];
    //3.隐藏
    self.addButton.hidden = YES;
    self.textFiled.text = nil;
}
- (void)deleteTagButton:(LAddTagButton *)sender
{
    [sender removeFromSuperview];
    [self.tags removeObject:sender];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self createTags];
    }];
}
#pragma mark --<UITextFieldDelegate>
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self addTags];
    return YES;
}
- (void)textDidChange
{
    if (![self.textFiled hasText])
    {
//        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签：%@",self.textFiled.text] forState:UIControlStateNormal];
//        [self updateAddButtonFrame];
        self.addButton.hidden = YES;
        return;
    }
    [self updataTextFieldFrame];
    //判断标点符号
    NSString *lastWordd = [self.textFiled.text substringWithRange:NSMakeRange(self.textFiled.text.length-1, 1)];
    if ([lastWordd isEqualToString:@","]||[lastWordd isEqualToString:@"，"]) {
        [self addTags];
    }else{
        //修改对应的addButton
        self.addButton.hidden = NO;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签：%@",self.textFiled.text] forState:UIControlStateNormal];
    }
    [self updateAddButtonFrame];
}



/**
 * 更新textField->frame
 */
- (void)updataTextFieldFrame
{
    LAddTagButton *lastButton = [self.tags lastObject];
    //计算当前行左边的宽度
    CGFloat leftWidth = CGRectGetMaxX(lastButton.frame)+addTags_margin;
    //计算当前行右边的宽度
    CGFloat rightWidth = self.tagsView.width - leftWidth;
    if (rightWidth >= 100) {
        self.textFiled.x = leftWidth;
        self.textFiled.y = lastButton.y;
    }else{
        self.textFiled.x = 0;
        self.textFiled.y = CGRectGetMaxY(lastButton.frame)+addTags_margin;
    }
    [self updateAddButtonFrame];
}

/**
 * 修改对应的添加标签的按钮的frame
 */
- (void)updateAddButtonFrame
{
    self.addButton.y = CGRectGetMaxY(self.textFiled.frame);
}

@end
