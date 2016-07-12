//
//  XYZMaskView.m
//  XY2Player
//
//  Created by zxs on 16/3/30.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZMaskView.h"

@implementation XYZMaskView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self s_maskView];
    }
    return self;
}
- (void)s_maskView {
    _playerImage = [[UIImageView alloc] init];
    _stateButton = [[UIButton alloc] init];
    _videoSlider = [[UISlider alloc] init];
    _timeLabel = [[UILabel alloc] init];
    _start_pause = [[UIButton alloc] init];
    [_playerImage setContentMode:UIViewContentModeScaleAspectFit]; // 按照比例放大
    UIImage *dotSlider = [self OriginImage:[UIImage imageNamed:@"dot"] scaleToSize:CGSizeMake(20, 20)]; // 圆点大小
    [_videoSlider setThumbImage:dotSlider forState:UIControlStateNormal];
    [_stateButton setImage:[UIImage imageNamed:@"Play-button"] forState:(UIControlStateNormal)];
    int s_time = (arc4random() % 30) + 20; // 随机产生时间 30~50
    [_timeLabel setText:[NSString stringWithFormat:@"00:00/%d:00",s_time]];
    [_timeLabel setFont:[UIFont systemFontOfSize:13]];
    [_start_pause setImage:[UIImage imageNamed:@"Play-button"] forState:(UIControlStateNormal)];
    // 开始
    [_stateButton addTarget:self action:@selector(stateButtonTouched:) forControlEvents:(UIControlEventTouchUpInside)];
    [_start_pause addTarget:self action:@selector(start_pauseAction:) forControlEvents:(UIControlEventTouchUpInside)];
    // 进度
    [_videoSlider addTarget:self action:@selector(videoSlierChangeValue:) forControlEvents:(UIControlEventTouchUpInside)];
    [_videoSlider addTarget:self action:@selector(videoSlierChangeValueEnd:) forControlEvents:(UIControlEventTouchUpInside)];
    _videoSlider.value = 0;
    [_timeLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:_playerImage];
    [self addSubview:_stateButton];
    [self addSubview:_videoSlider];
    [self addSubview:_timeLabel];
    [self addSubview:_start_pause];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if ([UIDevice currentDevice].orientation != UIDeviceOrientationPortrait) {
        [_playerImage setFrame:CGRectMake(90, 0, WIDTH-90*2, HEIGHT)];
        [_stateButton setFrame:CGRectMake(5, [[UIScreen mainScreen] bounds].size.height-PLAYButtonH-5, PLAYButtonH, PLAYButtonH)];
        [_videoSlider setFrame:CGRectMake(CGRectGetMaxX(_stateButton.frame)+5, [[UIScreen mainScreen] bounds].size.height-30, WIDTH-30-100, 30)];
        [_timeLabel setFrame:CGRectMake(CGRectGetMaxX(_videoSlider.frame)+5, [[UIScreen mainScreen] bounds].size.height-30, TIMELABELW, 30)];
        [_start_pause setFrame:CGRectMake(WIDTH/2-40/2, [[UIScreen mainScreen] bounds].size.height/2-40/2, 40, 40)];
    }else{
        [_playerImage setFrame:CGRectMake(WIDTH/2-250/2, 0, 250, PLAYERhEIGHT)];
        [_stateButton setFrame:CGRectMake(5, PLAYERhEIGHT-PLAYButtonH-5, PLAYButtonH, PLAYButtonH)];
        [_videoSlider setFrame:CGRectMake(CGRectGetMaxX(_stateButton.frame)+5, PLAYERhEIGHT-30, WIDTH-30-100, 30)];
        [_timeLabel setFrame:CGRectMake(CGRectGetMaxX(_videoSlider.frame)+5, PLAYERhEIGHT-30, TIMELABELW, 30)];
        [_start_pause setFrame:CGRectMake(WIDTH/2-40/2, PLAYERhEIGHT/2-40/2, 40, 40)];
    }
}
- (UIImage *)OriginImage:(UIImage*)image scaleToSize:(CGSize)size{
    UIGraphicsBeginImageContext(size); //size为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (void)stateButtonTouched:(UIButton *)sender {
    if ([self.s_maskDelegate respondsToSelector:@selector(clickMine:indexInteger:)]) {
        [self.s_maskDelegate clickMine:self indexInteger:0];
    }
}
- (void)start_pauseAction:(UIButton *)sender {
    if ([self.s_maskDelegate respondsToSelector:@selector(clickMine:indexInteger:)]) {
        [self.s_maskDelegate clickMine:self indexInteger:0];
    }
}
#pragma mark -- Slier滑动事件
- (void)videoSlierChangeValue:(id)sender { //
 _videoSlider.value = 0;
}
- (void)videoSlierChangeValueEnd:(id)sender {
 _videoSlider.value = 0;
    
}
- (void)sets_Image:(NSString *)image {
    [_playerImage sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    }];
}
@end
