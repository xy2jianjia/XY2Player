//
//  XYZTabbar.m
//  XY2Player
//
//  Created by zxs on 16/3/21.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZTabbar.h"

@interface XYZTabbar ()

@end

@implementation XYZTabbar
- (UIView *)startUpLaunchVideo{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];
    view.transform = CGAffineTransformMakeRotation(M_PI/2);//旋转180度
    view.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetMidY([UIScreen mainScreen].bounds));
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"launchVideo" ofType:@"mp4"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = view.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [view.layer addSublayer:playerLayer];
    [self.view addSubview:view];
    [player play];
    
    return view;
    
}
- (void)configNovel{
    NSString *downURL = @"itms-services://?action=download-manifest&url=https://mimishuwu.applinzi.com/stroy-resigned.plist";
    NSString *url = [downURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *URL = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL:URL];
}
- (void)viewDidLoad {  // 推荐 热门 频道 会员  nav.navigationBar.translucent = NO;
    [super viewDidLoad];
    
    UIView *playerView = [self startUpLaunchVideo];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self configNovel];
        });
        [playerView removeFromSuperview];
        self.tabBar.selectedImageTintColor = [UIColor colorWithRed:236/255.0 green:49/255.0 blue:88/255.0 alpha:1];
        [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        self.tabBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xy2_navagation.png"]];
        RootViewController *commend = [[RootViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:commend];
        navigation.tabBarItem.title = @"推荐";
        navigation.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xy2_navagation.png"]];
        [navigation.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        navigation.tabBarItem.image=[UIImage imageNamed:@"icon_left_homepage_a.png"];
        
        XYZHotTableController *hot = [[XYZHotTableController alloc] init];
        UINavigationController *navigation1 = [[UINavigationController alloc] initWithRootViewController:hot];
        navigation1.tabBarItem.title = @"热门";
        navigation1.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xy2_navagation.png"]];
        [navigation1.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        navigation1.tabBarItem.image = [UIImage imageNamed:@"burn_selected.png"];
        
        
        XYZChannelController *channe = [[XYZChannelController alloc] init];
        UINavigationController *navigation2 = [[UINavigationController alloc] initWithRootViewController:channe];
        navigation2.tabBarItem.title = @"两性";
        navigation2.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xy2_navagation.png"]];
        [navigation2.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        navigation2.tabBarItem.image =[UIImage imageNamed:@"icon_left_addfriend_a.png"];
        
        
        XYZMemberController *member = [[XYZMemberController alloc] initWithStyle:(UITableViewStyleGrouped)];
        UINavigationController *navigation3 = [[UINavigationController alloc] initWithRootViewController:member];
        navigation3.tabBarItem.title = @"会员";
        navigation3.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"xy2_navagation.png"]];
        [navigation3.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        navigation3.tabBarItem.image=[UIImage imageNamed:@"icon_tab_add_friends.png"];
        self.viewControllers = @[navigation,navigation1,navigation2,navigation3];
        
    });
}


@end
