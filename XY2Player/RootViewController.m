//
//  RootViewController.m
//  YSTiele
//
//  Created by zxs on 16/3/9.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "RootViewController.h"
#import "RootScrollView.h"

@interface RootViewController ()<UIScrollViewDelegate> {
    UIView *mask;
}
@property (nonatomic, strong) RootScrollView *scr;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (strong, nonatomic) UIScrollView *titleScrollView;
@end

@implementation RootViewController
- (NSArray *)titleArray {
    return @[@"热播",@"明星",@"直播",@"大片",@"电影"];
}
- (void)loadView {
    self.scr = [[RootScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = self.scr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    self.view.backgroundColor = [UIColor colorWithWhite:0.980 alpha:1];
    self.view.backgroundColor = [UIColor blackColor];
    self.labelArray = @[].mutableCopy;
    [self scrollViewLayOut];
    [self setupChildVc];
    [self setupTitle];
    [self navigationChil];
    [self scrollViewDidEndScrollingAnimation:self.scr.contentScrollView]; // 默认显示第0个子控制器
}

- (void)scrollViewLayOut {
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 64+SCROLLER, WIDTH, 0.5)];
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,64,WIDTH, SCROLLER)];
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    [line setBackgroundColor:[UIColor grayColor]];
    [self.scr addSubview:line];
    [self.scr addSubview:self.titleScrollView];
    self.titleScrollView.delegate = self;
    self.scr.contentScrollView.delegate = self;
}

- (void)navigationChil { //
    UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    releaseButton.frame = CGRectMake(0, 0, 65, 30);
    [releaseButton setTitle:@"精品推荐" forState:normal];
    [releaseButton setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"me_resizeable_background.png"]] forState:UIControlStateNormal];
    [releaseButton addTarget:self action:@selector(releaseInfo:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:releaseButton];
    self.navigationItem.rightBarButtonItem = releaseButtonItem;
}
#pragma mark -- 导航点击事件
- (void)releaseInfo:(UIButton *)tag {
    XYZRecommend *player = [[XYZRecommend alloc] init];
    UINavigationController *nac = [[UINavigationController alloc] initWithRootViewController:player];
    nac.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xy2_navagation.png"]];
    [nac.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self presentViewController:nac animated:YES completion:nil];
}
#pragma mark -- 添加控制器
- (void)setupChildVc {
    DHFirstViewController *social0 = [[DHFirstViewController alloc] init];  
    [self addChildViewController:social0];
    XYZHitViewController *social1 = [[XYZHitViewController alloc] init];
    [self addChildViewController:social1];
    XYZRecommend2 *social2 = [[XYZRecommend2 alloc] init];
    [self addChildViewController:social2];
    XYZRecommend3 *social3 = [[XYZRecommend3 alloc] init];
    [self addChildViewController:social3];
    XYZRecommend4 *social4 = [[XYZRecommend4 alloc] init];
    [self addChildViewController:social4];
}
#pragma mark -- 添加label
- (void)setupTitle {
    
    // 定义临时变量
    CGFloat labelW = LABELW;
    CGFloat labelY = 0;
    CGFloat labelH = 35;  //
    // 添加label
    for (NSInteger i = 0; i<self.titleArray.count; i++) {
        UILabel *labelxy = [[UILabel alloc] init];
        labelxy.text = self.titleArray[i];
        CGFloat labelX = i * labelW;
        labelxy.frame = CGRectMake(labelX, labelY, labelW, labelH);
        labelxy.textAlignment = NSTextAlignmentCenter;
        [labelxy setFont:[UIFont systemFontOfSize:14]];
        labelxy.textColor = [UIColor grayColor];
        [labelxy addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        labelxy.userInteractionEnabled = YES;
        labelxy.tag = i;
        [self.labelArray addObject:labelxy];
        
        [self.titleScrollView addSubview:labelxy];
        if (i == 0) {
            [labelxy setTextColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"me_resizeable_background.png"]]];
            [labelxy setFont:[UIFont systemFontOfSize:16]];
        }
    }
    // 设置contentSize
    self.titleScrollView.bounces = NO;
    self.titleScrollView.contentSize = CGSizeMake(self.titleArray.count * labelW, SCROLLER);
    self.scr.contentScrollView.contentSize = CGSizeMake(self.titleArray.count * [UIScreen mainScreen].bounds.size.width, 0);
}
/**
 * 监听顶部label点击
 */
- (void)labelClick:(UITapGestureRecognizer *)tap {
    // 取出被点击label的索引
    NSInteger index = tap.view.tag;
    // 让底部的内容scrollView滚动到对应位置
    CGPoint offset = self.scr.contentScrollView.contentOffset;
    offset.x = index * self.scr.contentScrollView.frame.size.width;
    [self.scr.contentScrollView setContentOffset:offset animated:YES];
    
    // 让对应的顶部标题居中显示
    UILabel *label = self.titleScrollView.subviews[index];
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    
    CGFloat width = self.titleScrollView.frame.size.width;
    titleOffset.x = label.center.x - width * 0.5;
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - width;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    [self labelColorTag:tap.view.tag];
}
- (void)labelColorTag:(NSInteger)tag {

    for (UILabel *label in self.labelArray) {
        if (tag == label.tag) {
//            [label setTextColor:[UIColor redColor]];
            [label setTextColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"me_resizeable_background.png"]]];
            [label setFont:[UIFont systemFontOfSize:16]];
        }else {
            [label setTextColor:[UIColor darkGrayColor]];
            [label setFont:[UIFont systemFontOfSize:14]];
        }
    }
}

#pragma mark - <UIScrollViewDelegate>
/**
 * scrollView结束了滚动动画以后就会调用这个方法（比如- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;方法执行的动画完毕后）
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 一些临时变量
    CGFloat width = scrollView.frame.size.width;
    CGFloat height = scrollView.frame.size.height;
    CGFloat offsetX = scrollView.contentOffset.x;
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    // 取出需要显示的控制器
    UIViewController *willShowVc = self.childViewControllers[index];
    // 如果当前位置的位置已经显示过了，就直接返回
    if ([willShowVc isViewLoaded]) return;
    // 添加控制器的view到contentScrollView中;
    willShowVc.view.frame = CGRectMake(offsetX, 0, width, height);
    [scrollView addSubview:willShowVc.view];
}

/**
 * 手指松开scrollView后，scrollView停止减速完毕就会调用这个
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    CGFloat width = scrollView.frame.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 当前位置需要显示的控制器的索引
    NSInteger index = offsetX / width;
    // 让对应的顶部标题居中显示
    UILabel *label = self.titleScrollView.subviews[index];
    CGPoint titleOffset = self.titleScrollView.contentOffset;
    
    CGFloat widths = self.titleScrollView.frame.size.width;
    titleOffset.x = label.center.x - widths * 0.5;
    // 左边超出处理
    if (titleOffset.x < 0) titleOffset.x = 0;
    // 右边超出处理
    CGFloat maxTitleOffsetX = self.titleScrollView.contentSize.width - widths;
    if (titleOffset.x > maxTitleOffsetX) titleOffset.x = maxTitleOffsetX;
    [self.titleScrollView setContentOffset:titleOffset animated:YES];
    [self labelColorTag:index];
}

@end
