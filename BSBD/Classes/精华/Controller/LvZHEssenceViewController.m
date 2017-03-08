//
//  LvZHEssenceViewController.m
//  BSBD
//
//  Created by lvzhenhua on 2016/12/31.
//  Copyright © 2016年 lvzhenhua. All rights reserved.
//

#import "LvZHEssenceViewController.h"
#import "LvZHRecmomentTagController.h"
#import "LTopicTableViewController.h"
@interface LvZHEssenceViewController ()<UIScrollViewDelegate>
/*! @brief 指示器  */
@property (nonatomic ,weak) UIView *indicator;
/*! @brief titlesView  */
@property (nonatomic ,strong) UIView *titlesView;
/*! @brief 上一个选中的按钮  */
@property (nonatomic ,strong) UIButton *previousButton;

/*! @brief scrollView  */
@property (nonatomic ,strong) UIScrollView *sc;

/** 得到子类的类型  */
@property (nonatomic ,copy) NSString *reqestType;
@end

@implementation LvZHEssenceViewController

- (NSString *)getRequestType
{
    return @"list";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    //
    [self setupChildVC];
    //
    [self setupTitlesView];
    //
    [self setupScrollView];
}
- (void)setupChildVC{
    
    LTopicTableViewController *all = [[LTopicTableViewController alloc]init];
    all.title = @"全部";
    all.type = TopicTypeAll;
    all.a = [self getRequestType];
    [self addChildViewController:all];
    
    LTopicTableViewController *video = [[LTopicTableViewController alloc]init];
    video.title = @"视频";
    video.type = TopicTypeVideo;
    video.a = [self getRequestType];
    [self addChildViewController:video];
    
    LTopicTableViewController *voice = [[LTopicTableViewController alloc]init];
    voice.title = @"声音";
    voice.type = TopicTypeVoice;
    voice.a = [self getRequestType];
    [self addChildViewController:voice];
    
    LTopicTableViewController *pic = [[LTopicTableViewController alloc]init];
    pic.title = @"图片";
    pic.type = TopicTypePicture;
    pic.a = [self getRequestType];
    [self addChildViewController:pic];
    
    LTopicTableViewController *topic = [[LTopicTableViewController alloc]init];
    topic.title = @"段子";
    topic.type = TopicTypeWord;
    topic.a = [self getRequestType];
    [self addChildViewController:topic];
}

/**
 * 设置scrollView
 */
- (void)setupScrollView{
    //
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *sc = [[UIScrollView alloc]init];
    sc.delegate = self;
    sc.frame = self.view.bounds;
    sc.pagingEnabled = YES;
    sc.contentSize = CGSizeMake(self.view.width*self.childViewControllers.count, 0);
    [self.view insertSubview:sc atIndex:0];
    self.sc = sc;
    
    //添加第一个控制器
    [self scrollViewDidEndScrollingAnimation:sc];
}
/**
 * 设置标签
 */
- (void)setupTitlesView{
    
    UIView *titlesView = [[UIView alloc]init];
    titlesView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
    titlesView.frame = CGRectMake(0, TitlesViewY, self.view.width, TitlesViewH);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    //指示器
    UIView *indicator = [[UIView alloc]init];
    indicator.backgroundColor = [UIColor redColor];
    indicator.y = titlesView.height-1.5;
    indicator.tag = -1;
    indicator.height = 1.5;
    self.indicator = indicator;
    //添加子控件
    float height = titlesView.height;
    float width = self.view.width/self.childViewControllers.count;
    for (NSInteger i=0; i<self.childViewControllers.count;i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.width = width;
        button.height = height;
        button.x = i*button.width;
        button.tag = i;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [titlesView addSubview:button];
        if (i == 0) {//计算选中的第一个view
            button.enabled = NO;
            self.previousButton = button;
            [button.titleLabel sizeToFit];//计算得到对应的文字的大小
            self.indicator.width = button.titleLabel.width;
            self.indicator.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicator];
}
    
- (void)buttonClick:(UIButton *)button{
    
    //修改文字的状态
    button.enabled = NO;
    self.previousButton.enabled = YES;
    self.previousButton = button;
    
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.width = button.titleLabel.width;
        self.indicator.centerX = button.centerX;
    }];
    //滑动到对应的控制器
    CGPoint offSet = self.sc.contentOffset;
    offSet.x = button.tag*self.view.width;
    [self.sc setContentOffset:offSet animated:YES];
}
/**
 * 设置导航栏
 */
- (void)setupNav{
    //设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //左边按钮 (出现相同代码的时候需要抽调)
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWith:@"MainTagSubIcon" HighImage:@"MainTagSubIconClick" target:self sel:@selector(tagClick)];
    
    self.view.backgroundColor = LVZHGlobalBgColor;

}
- (void)tagClick{
    LvZHRecmomentTagController *tag = [[LvZHRecmomentTagController alloc]init];
    [self.navigationController pushViewController:tag animated:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIScrollView delegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //添加自控制器的view
    //1.获得索引
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    //2.得到对应的控制器
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;//默认为20（会有20的间距记得调整）
    vc.view.height = scrollView.height;
    //
    [self.sc addSubview:vc.view];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    [self buttonClick:self.titlesView.subviews[index]];
}
@end
