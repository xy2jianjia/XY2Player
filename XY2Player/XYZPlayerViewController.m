//
//  XYZPlayerViewController.m
//  XY2Player
//
//  Created by zxs on 16/3/22.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZPlayerViewController.h"
#import "PlayerView.h"
#import "XYZMaskView.h"
@interface XYZPlayerViewController ()<maskViewDelegate,UITableViewDataSource,UITableViewDelegate> {
    BOOL _played;
    NSInteger _screen;
    NSDateFormatter *_dateFormatter;
    UITableView *tempTable; // 下半部分
    BOOL foundVip;
    UILabel *s_animation;  // 动画提示
}
@property (nonatomic ,strong) AVPlayer *player;
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic ,strong) id playbackTimeObserver;
@property (nonatomic ,strong) PlayerView *playerView;
@property (nonatomic ,strong) UIButton *stateButton;
@property (nonatomic ,strong) UILabel *timeLabel;
@property (nonatomic ,strong) UISlider *videoSlider;
@property (nonatomic ,strong) UIProgressView *videoProgress;
@property (nonatomic ,strong) NSString *totalTime;
@property (nonatomic ,strong) UIButton *start_pause;  // 居中按钮
@property (nonatomic, strong) XYZMaskView *s_mask;  // 遮罩
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *timer_anamation;

@property (nonatomic, strong) NSMutableArray *dateArray;

@property (nonatomic, strong) NSMutableArray *tempArray;
@end

@implementation XYZPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",_viewController);
    self.tabBarController.tabBar.hidden = YES;
    self.dateArray = @[].mutableCopy;
    NSInteger indexYear = arc4random()%6;
    NSInteger indexMonth = arc4random()%11+1;
    NSInteger indexday = arc4random()%30+1;
    NSString *upload = @"上传人: Night Team";
    NSString *uploadTIime = [NSString stringWithFormat:@"上传时间: 201%ld年%ld月%ld日",indexYear,indexMonth,indexday];
    NSString *sources = @"片源: 未知";
    NSString *suitableCrowd = @"适合人群: 18周岁以上(未成年人不得观看)"; // 适合人群
    NSString *upLoaddree;
    if (foundVip) {
        upLoaddree = self.mp4Url;
    }else {
        upLoaddree = @"下载地址: 你还不是会员,无法下载";
    }
    [self.dateArray addObject:upload];
    [self.dateArray addObject:uploadTIime];
    [self.dateArray addObject:sources];
    [self.dateArray addObject:suitableCrowd];
    [self.dateArray addObject:upLoaddree];
    
    [self s_AVPlayer];
    if ([self.indexMask isEqualToString:INDEXMASKNO]) {
        [self s_maskView];  // 遮罩
    }
    [self animationDrow];
    [self s_navigationItem];
    [self s_AVPlayer_alloc];
    [self layoutTempTable];
}
#pragma mark -- 蒙版代理(这里判断VIP)
- (void)clickMine:(XYZMaskView *)mask indexInteger:(NSInteger)index {
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *idstr = [NSString stringWithFormat:@"%@%@",@"video",identifierForVendor];
    BOOL VIP = [XYZ_HZVipDao checkVipWithUUID:idstr];
    if (VIP) { // 判断是否是VIP
        [UIView animateWithDuration:0.3 animations:^{
            [self.s_mask setFrame:CGRectMake(0, -TOPHEIGHT-PLAYERhEIGHT, WIDTH, PLAYERhEIGHT)];
        }];
        [self start_pauseAVPlayer]; // 开始播放
    }else {
        [BlockSort alertPayView:self.view];
        //        NSLog(@"你还不是VIP");
    }
}

#pragma mark --  创建蒙版
- (void)s_maskView {
    self.s_mask = [[XYZMaskView alloc] init];
    [self.s_mask setFrame:CGRectMake(0, TOPHEIGHT, WIDTH, PLAYERhEIGHT)];
    [self.s_mask setBackgroundColor:[UIColor blackColor]];
    [self.s_mask setS_maskDelegate:self];
    
    NSString *url_Image;
    if ([self.iamgePic isEqualToString:@"sec"]) { // 是否需要前缀
        url_Image = self.picImage;
    }else {
        url_Image = [NSString stringWithFormat:@"%@%@",XY2HTTP,self.picImage];
    }
    [self.s_mask sets_Image:url_Image];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(catchTapMask:)];
    [self.s_mask addGestureRecognizer:tap];
    [self.view addSubview:self.s_mask];
}
#pragma mark -- 蒙版手势
-(void)catchTapMask:(UITapGestureRecognizer *)tap{
    if (self.navigationController.navigationBar.isHidden) {
        [self maskshowControlsWithAnimation];
        [_timer fire];
        if(!_timer){ // 定时加载防止进入空白页面
            _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(maskhideControlsWithDelay) userInfo:nil repeats:YES];
        }
    }else{
        [self maskhideControlsWithDelay:0.0];
        if (_timer) {   //关闭定时器
            if ([self.timer isValid]) {
                [self.timer invalidate];
                _timer = nil;
            }
        }
    }
}
#pragma mark -- 定时隐藏控件
- (void)maskhideControlsWithDelay {
    [self maskhideControlsWithDelay:0.0];
    if (_timer) {   //关闭定时器
        if ([self.timer isValid]) {
            [self.timer invalidate];
            _timer = nil;
        }
    }
}
-(void)maskshowControlsWithAnimation{ // 出现
    [UIView animateWithDuration:0.4
                     animations:^{
                         self.navigationController.navigationBar.hidden = false;
                         self.s_mask.start_pause.hidden = false;
                         self.s_mask.stateButton.hidden = false;
                         self.s_mask.videoSlider.alpha = 1.0;
                         self.s_mask.timeLabel.alpha = 1.0;
                     }];
}
-(void)maskhideControlsWithDelay:(NSTimeInterval)delay{  // 隐藏
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4
                         animations:^{
                             self.navigationController.navigationBar.hidden = true;
                             self.s_mask.start_pause.hidden = true;
                             self.s_mask.stateButton.hidden = true;
                             self.s_mask.videoSlider.alpha = 0.0;
                             self.s_mask.timeLabel.alpha = 0.0;
                         }];
    });
}
// ============= 上面是蒙版部分 ()
- (void)s_AVPlayer_alloc {
    NSURL *videoUrl = [NSURL URLWithString:self.mp4Url];
    self.playerItem = [AVPlayerItem playerItemWithURL:videoUrl];
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [self.playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];// 监听loadedTimeRanges属性
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerView.player = _player;
    self.stateButton.enabled = NO;
    // 添加视频播放结束通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:_playerItem];
}

- (void)s_navigationItem {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backIcon"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(leftAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fullScreen"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(rightAction:)];
}
#pragma mark -- 导航事件
- (void)leftAction:(UIBarButtonItem *)sender {  // 左边
    if (_screen == 1) { // 退出全屏状态
        _screen = 0;
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        [self.playerView setFrame:CGRectMake(0, TOPHEIGHT, WIDTH, PLAYERhEIGHT)];
        [self.s_mask setFrame:CGRectMake(0, TOPHEIGHT, WIDTH, PLAYERhEIGHT)];
        [self s_controlFrame];
    }else{
        [self.playerView.player pause]; // 退出关闭播放器
        [self.stateButton setImage:[UIImage imageNamed:@"Play-button"] forState:(UIControlStateNormal)];
        [self.start_pause setImage:[UIImage imageNamed:@"Play-button"] forState:(UIControlStateNormal)];
        [self dismissViewControllerAnimated:true completion:nil];
        if (_timer_anamation) {   // 关闭横幅定时器
            if ([self.timer isValid]) {
                [self.timer invalidate];
                _timer_anamation = nil;
            }
        }
    }
}
#pragma mark -- 全屏
- (void)rightAction:(UIBarButtonItem *)sender { // 全屏
    if ([UIDevice currentDevice].orientation != UIDeviceOrientationPortrait) {
        _screen = 0;
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        [self.playerView setFrame:CGRectMake(0, TOPHEIGHT, WIDTH, PLAYERhEIGHT)];
        [self.s_mask setFrame:CGRectMake(0, TOPHEIGHT, WIDTH, PLAYERhEIGHT)];
        [self layoutTempTable];
        [self s_controlFrame];
    }else{
        _screen = 1;
        NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
        [self.playerView setFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        [self.s_mask setFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        [tempTable removeFromSuperview];
        [self s_controlFrame];
    }
}

- (void)s_controlFrame {
    [self.stateButton setFrame:CGRectMake(5, self.playerView.frame.size.height-PLAYButtonH-5, PLAYButtonH, PLAYButtonH)];
    [self.videoProgress setFrame:CGRectMake(CGRectGetMaxX(self.stateButton.frame)+5, self.playerView.frame.size.height-16, WIDTH-30-100, 30)];
    [self.videoSlider setFrame:CGRectMake(CGRectGetMaxX(self.stateButton.frame)+5, self.playerView.frame.size.height-30, WIDTH-30-100, 30)];
    [self.timeLabel setFrame:CGRectMake(CGRectGetMaxX(self.videoSlider.frame)+5, self.playerView.frame.size.height-30, TIMELABELW, 30)];
    [self.start_pause setFrame:CGRectMake(WIDTH/2-40/2, self.playerView.frame.size.height/2-40/2, 40, 40)];
}

- (void)s_AVPlayer {
    self.playerView = [[PlayerView alloc] init];
    self.stateButton = [[UIButton alloc] init];
    self.videoProgress = [[UIProgressView alloc] init];
    self.videoSlider = [[UISlider alloc] init];
    self.timeLabel = [[UILabel alloc] init];
    self.start_pause = [[UIButton alloc] init];
    [self.playerView setFrame:CGRectMake(0, 0, WIDTH, PLAYERhEIGHT)];
    [self s_controlFrame];
    [self.playerView setBackgroundColor:[UIColor blackColor]];
    UIImage *dotSlider = [self OriginImage:[UIImage imageNamed:@"dot"] scaleToSize:CGSizeMake(20, 20)]; // 圆点大小
    [self.videoSlider setThumbImage:dotSlider forState:UIControlStateNormal];
    [self.stateButton setImage:[UIImage imageNamed:@"Play-button"] forState:(UIControlStateNormal)];
    int s_time = (arc4random() % 30) + 20; // 随机产生时间 30~50
    [self.timeLabel setText:[NSString stringWithFormat:@"00:00/%d:00",s_time]];
    [self.timeLabel setFont:[UIFont systemFontOfSize:13]];
    [self.start_pause setImage:[UIImage imageNamed:@"Play-button"] forState:(UIControlStateNormal)];
    // 开始
    [self.stateButton addTarget:self action:@selector(stateButtonTouched:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.start_pause addTarget:self action:@selector(start_pauseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    // 进度
    [self.videoSlider addTarget:self action:@selector(videoSlierChangeValue:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.videoSlider addTarget:self action:@selector(videoSlierChangeValueEnd:) forControlEvents:(UIControlEventTouchUpInside)];
    self.videoSlider.value = 0;
    [self.timeLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:self.playerView];
    [self.playerView addSubview:self.stateButton];
    [self.playerView addSubview:self.videoProgress];
    [self.playerView addSubview:self.videoSlider];
    [self.playerView addSubview:self.timeLabel];
    [self.playerView addSubview:self.start_pause];
    // 添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(catchTap:)];
    [self.playerView addGestureRecognizer:tap];
}

#pragma mark -- 手势
-(void)catchTap:(UITapGestureRecognizer *)tap{
    
    if (self.navigationController.navigationBar.isHidden) {
        [self showControlsWithAnimation];
        [_timer fire];
        if(!_timer){ // 定时加载防止进入空白页面
            _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hideControlsWithDelay) userInfo:nil repeats:YES];
        }
    }else{
        [self hideControlsWithDelay:0.0];
        if (_timer) {   //关闭定时器
            if ([self.timer isValid]) {
                [self.timer invalidate];
                _timer = nil;
            }
        }
    }
}
#pragma mark -- 定时隐藏控件
- (void)hideControlsWithDelay {
    [self hideControlsWithDelay:0.0];
    if (_timer) {   //关闭定时器
        if ([self.timer isValid]) {
            [self.timer invalidate];
            _timer = nil;
        }
    }
}
-(void)showControlsWithAnimation{ // 出现
    [UIView animateWithDuration:0.4
                     animations:^{
                         self.navigationController.navigationBar.hidden = false;
                         self.start_pause.hidden = false;
                         self.stateButton.hidden = false;
                         self.videoProgress.alpha = 1.0;
                         self.videoSlider.alpha = 1.0;
                         self.timeLabel.alpha = 1.0;
                     }];
}
-(void)hideControlsWithDelay:(NSTimeInterval)delay{  // 隐藏
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4
                         animations:^{
                             self.navigationController.navigationBar.hidden = true;
                             self.start_pause.hidden = true;
                             self.stateButton.hidden = true;
                             self.videoProgress.alpha = 0.0;
                             self.videoSlider.alpha = 0.0;
                             self.timeLabel.alpha = 0.0;
                         }];
    });
}
#pragma mark -- 中间的开始按钮点击事件(这里判断VIP)
- (void)start_pauseAction:(UIButton *)sender {
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *idstr = [NSString stringWithFormat:@"%@%@",@"video",identifierForVendor];
    BOOL VIP = [XYZ_HZVipDao checkVipWithUUID:idstr];
    if (VIP) {
        [MobClick event:@"vip_btn_play_clicked"];
       [self start_pauseAVPlayer];
    }else{
        [MobClick event:@"no_vip_btn_play_clicked"];
        [BlockSort alertPayView:self.view];
    }
    
}
#pragma mark -- 下面的开始按钮(这里判断VIP)
- (void)stateButtonTouched:(id)sender {
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *idstr = [NSString stringWithFormat:@"%@%@",@"video",identifierForVendor];
    BOOL VIP = [XYZ_HZVipDao checkVipWithUUID:idstr];
    if (VIP) {
        [MobClick event:@"vip_btn_play_clicked"];
        [self start_pauseAVPlayer];
    }else{
        [MobClick event:@"no_vip_btn_play_clicked"];
        [BlockSort alertPayView:self.view];
    }
    
}
- (void)start_pauseAVPlayer {
    if (!_played) {
        [self hideControlsWithDelay:0.0];
        [self.playerView.player play];
        [self.stateButton setImage:[UIImage imageNamed:@"stopSmall"] forState:(UIControlStateNormal)];
        [self.start_pause setImage:[UIImage imageNamed:@"stopSmall"] forState:(UIControlStateNormal)];
    } else {
        [self.playerView.player pause];
        [self.stateButton setImage:[UIImage imageNamed:@"Play-button"] forState:(UIControlStateNormal)];
        [self.start_pause setImage:[UIImage imageNamed:@"Play-button"] forState:(UIControlStateNormal)];
    }
    _played = !_played;
}
/**
 *  控制图片大小
 *
 *  @param image 图片
 *  @param size  CGSizeMake(width,height)
 *
 *  @return 图片
 */
- (UIImage *)OriginImage:(UIImage*)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

#pragma mark -- Slier滑动事件
- (void)videoSlierChangeValue:(id)sender { //
    UISlider *slider = (UISlider *)sender;
    NSLog(@"value change:%f",slider.value);
    if (slider.value == 0.000000) {
        __weak typeof(self) weakSelf = self;
        [self.playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
            [weakSelf.playerView.player play];
        }];
    }
}
- (void)videoSlierChangeValueEnd:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSLog(@"value end:%f",slider.value);
    CMTime changedTime = CMTimeMakeWithSeconds(slider.value, 1);
    __weak typeof(self) weakSelf = self;
    [self.playerView.player seekToTime:changedTime completionHandler:^(BOOL finished) {
        [weakSelf.playerView.player play];
        [self.stateButton setImage:[UIImage imageNamed:@"stopSmall"] forState:(UIControlStateNormal)];
        [self.start_pause setImage:[UIImage imageNamed:@"stopSmall"] forState:(UIControlStateNormal)];
    }];
}
#pragma mark --- 视频结束通知
- (void)moviePlayDidEnd:(NSNotification *)notification {
    NSLog(@"Play end");
    __weak typeof(self) weakSelf = self;
    [self.playerView.player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        [weakSelf.videoSlider setValue:0.0 animated:YES];
        [self.stateButton setImage:[UIImage imageNamed:@"Play-button"] forState:(UIControlStateNormal)];
        [self.start_pause setImage:[UIImage imageNamed:@"Play-button"] forState:(UIControlStateNormal)];
        
    }];
}

#pragma mark -- 监听视频播放状况
- (void)monitoringPlayback:(AVPlayerItem *)playerItem {
    __weak typeof(self) weakSelf = self;
    self.playbackTimeObserver = [self.playerView.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat currentSecond = playerItem.currentTime.value/playerItem.currentTime.timescale;// 计算当前在第几秒
        [weakSelf.videoSlider setValue:currentSecond animated:YES];
        NSString *timeString = [weakSelf convertTime:currentSecond];
        weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@/%@",timeString,weakSelf.totalTime];
    }];
}

#pragma mark -- KVO方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    AVPlayerItem *playerItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            self.stateButton.enabled = YES;
            CMTime duration = self.playerItem.duration;// 获取视频总长度
            CGFloat totalSecond = playerItem.duration.value / playerItem.duration.timescale;// 转换成秒
            _totalTime = [self convertTime:totalSecond];// 转换成播放时间
            [self customVideoSlider:duration];// 自定义UISlider外观
            NSLog(@"movie total duration:%f",CMTimeGetSeconds(duration));
            [self monitoringPlayback:self.playerItem];// 监听播放状态
        } else if ([playerItem status] == AVPlayerStatusFailed) {
            NSLog(@"AVPlayerStatusFailed");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSTimeInterval timeInterval = [self availableDuration];// 计算缓冲进度
        NSLog(@"Time Interval:%f",timeInterval);
        
        CMTime duration = _playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.videoProgress setProgress:timeInterval / totalDuration animated:YES];
    }
}
#pragma mark -- 缓冲
- (NSTimeInterval)availableDuration { //
    NSArray *loadedTimeRanges = [[self.playerView.player currentItem] loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}
#pragma mark -- 同步slider
- (void)customVideoSlider:(CMTime)duration { //
    self.videoSlider.maximumValue = CMTimeGetSeconds(duration);
    UIGraphicsBeginImageContextWithOptions((CGSize){ 1, 1 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.videoSlider setMinimumTrackImage:transparentImage forState:UIControlStateNormal];
    [self.videoSlider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
}
#pragma mark -- 计算视频时间
- (NSString *)convertTime:(CGFloat)second{  //
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    if (second/3600 >= 1) {
        [[self dateFormatter] setDateFormat:@"HH:mm:ss"];
    } else {
        [[self dateFormatter] setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [[self dateFormatter] stringFromDate:d];
    return showtimeNew;
}
- (void)updateVideoSlider:(CGFloat)currentSecond {
    [self.videoSlider setValue:currentSecond animated:YES];
}
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
    }
    return _dateFormatter;
}

- (void)dealloc {
    [self.timer invalidate];
    [self.timer_anamation invalidate];
    // 删除通知
    [self.playerItem removeObserver:self forKeyPath:@"status" context:nil];
    [self.playerItem removeObserver:self forKeyPath:@"loadedTimeRanges" context:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    [self.playerView.player removeTimeObserver:self.playbackTimeObserver];
}
- (void)layoutTempTable {
    
    self.tempArray = [NSMutableArray array];
    NSDictionary *temp1 = @{@"name":@"明天",@"time":@"20分钟前",@"image":@"http://wanzao2.b0.upaiyun.com/system/pictures/35434407/original/1462001320_600x771.png",@"count":@"2021",@"content":@"文爱约我。"};
    NSDictionary *temp2 = @{@"name":@"孤狼",@"time":@"1小时34分钟前",@"image":@"http://images.yeyou.com/2016/news/2016/04/26/z0426B02s.jpg",@"count":@"368",@"content":@"好诱惑，好想舔。"};
    NSDictionary *temp3 = @{@"name":@"似乎从来都不平静",@"time":@"2小时22分钟前",@"image":@"http://img55.it168.com/ArticleImages/fnw/2016/0424/c7713409-54e1-4e24-a282-04913a2bbb7f.jpg",@"count":@"517",@"content":@"文ai私信我，保证让你爽。"};
    NSDictionary *temp4 = @{@"name":@"我迷惘",@"time":@"50分钟前",@"image":@"http://www.5uzw.com/d/file/xxhh/5627bf9632aad101.jpg",@"count":@"126",@"content":@"还有没有老司机带路。"};
    NSDictionary *temp5 = @{@"name":@"月亮的距离",@"time":@"1小时10分钟前",@"image":@"http://images.yeyou.com/2016/news/2016/04/26/z0426B01s.jpg",@"count":@"390",@"content":@"感谢共享，已收藏。"};
    NSDictionary *temp6 = @{@"name":@"老司机",@"time":@"49分钟前",@"image":@"http://pic.anfensi.com/Uploads/Editor/2016-04-12/570cc1ed2d716.jpg",@"count":@"3420",@"content":@"赞赞赞。"};
    [_tempArray addObject:temp1];
    [_tempArray addObject:temp2];
    [_tempArray addObject:temp3];
    [_tempArray addObject:temp4];
    [_tempArray addObject:temp5];
    [_tempArray addObject:temp6];
    
    tempTable = [[UITableView alloc] initWithFrame:CGRectMake(0, PLAYERhEIGHT+50, WIDTH, HEIGHT-PLAYERhEIGHT-50-20)];
    tempTable.separatorStyle = UITableViewCellEditingStyleNone;
//    tempTable.allowsSelection = NO;
    tempTable.delegate = self;
    tempTable.dataSource = self;
//    [tempTable registerClass:[XYZReplyCell class] forCellReuseIdentifier:@"cell_1"];
    [self.view addSubview:tempTable];
}

#pragma mark - UITabelView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tempArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"热门评论";
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"开通vip回复评论" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:@"开通永久vip", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        return;
    }else{
        [self vipbuttonAction:nil];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_1" forIndexPath:indexPath];
//    if (indexPath.row == 5) {
//        UIButton *vip_button = [[UIButton alloc] initWithFrame:CGRectMake(70, 20, WIDTH-70*2, 30)];
//        [vip_button.layer setMasksToBounds:true];
//        [vip_button.layer setCornerRadius:5.0];
//        [vip_button.layer setBorderWidth:0.5];
//        [vip_button.layer setBorderColor:[[UIColor blackColor]CGColor]];
//        [vip_button setTitle:@"成为会员" forState:(UIControlStateNormal)];
//        [vip_button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
//        [vip_button addTarget:self action:@selector(vipbuttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
//        [cell addSubview:vip_button];
//        
//        UIButton *stroy_button = [[UIButton alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(vip_button.frame)+20, WIDTH-70*2, 30)];
//        [stroy_button.layer setMasksToBounds:true];
//        [stroy_button.layer setCornerRadius:5.0];
//        [stroy_button.layer setBorderWidth:0.5];
//        [stroy_button.layer setBorderColor:[[UIColor blackColor]CGColor]];
//        [stroy_button setTitle:@"下载小说" forState:(UIControlStateNormal)];
//        [stroy_button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
//        [stroy_button addTarget:self action:@selector(stroy_buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
//        [cell addSubview:stroy_button];
//        [tempTable setRowHeight:120];
//    }else {
//        cell.textLabel.text = self.dateArray[indexPath.row];
//        [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
//        [tempTable setRowHeight:30];
//    }
//    [cell setSelectedBackgroundView:[BlockSort view_bgscells:cell.frame]];
//    return cell;
    NSDictionary *temp = [_tempArray objectAtIndex:indexPath.row];
    NSString *url = [temp objectForKey:@"image"];
    NSString *name = [temp objectForKey:@"name"];
    NSString *time = [temp objectForKey:@"time"];
    NSString *count = [temp objectForKey:@"count"];
    NSString *content = [temp objectForKey:@"content"];
    
    XYZReplyCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"XYZReplyCell" owner:self options:nil] lastObject];
   
    
    [cell.headerImageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
    cell.nameLabel.text = name;
    cell.timeLabel.text = time;
    cell.countLabel.text = count;
    cell.contentLabel.text = content;
    return cell;
    
}
#pragma mark  -- 进入支付 
- (void)vipbuttonAction:(UIButton *)sender {
    [BlockSort alertPayView:self.view];
}
#pragma mark  -- 下载小说 （不是会员不允许下载）
- (void)stroy_buttonAction:(UIButton *)sender {  // 下载
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    NSString *idstr = [NSString stringWithFormat:@"%@%@",@"video",identifierForVendor];
    BOOL VIP = [XYZ_HZVipDao checkVipWithUUID:idstr];
    if (VIP) {
#warning 2016年04月05日17:04:41 -dh，加上小说url
        NSString *downURL = nil;
        NSString *url = [downURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *URL = [NSURL URLWithString:url];
        [[UIApplication sharedApplication] openURL:URL];
    }else{
        [BlockSort alertPayView:self.view];
        
    }
}
- (void)animationDrow {
    s_animation = [[UILabel alloc] init];
    [s_animation setText:@"您是当前第 87957 位访客，已有87313人注册会员。成为会员享受更多资讯与优惠、还可在视频下方下载最新免费情爱小说更多优惠等你来拿!~"];
    [s_animation setTextColor:[UIColor redColor]];
    CGFloat s_animationW = [BlockSort stringWidth:s_animation.text];
    [s_animation setFrame:CGRectMake(-s_animationW, CGRectGetMaxY(self.playerView.frame)+30, s_animationW, 30)];
    [self.view addSubview:s_animation];
    [self setkeyAnimation];
    if(!_timer_anamation){ // 定时加载防止进入空白页面
        _timer_anamation = [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(s_animationTime) userInfo:nil repeats:YES];
    }
}
#pragma mark -- 定时隐藏控件
- (void)s_animationTime {
    [self setkeyAnimation];
}
- (void)setkeyAnimation {
    CGFloat s_animationW = [BlockSort stringWidth:s_animation.text];
    [BlockSort setKeyframeValue:CGPointMake(s_animationW+30, CGRectGetMaxY(self.playerView.frame)+30) sValue:CGPointMake(-s_animationW, CGRectGetMaxY(self.playerView.frame)+30) time:15 layer:s_animation.layer];
    s_animation.layer.position = CGPointMake(-700, CGRectGetMaxY(self.playerView.frame));   // 移动后设置值
}

@end
