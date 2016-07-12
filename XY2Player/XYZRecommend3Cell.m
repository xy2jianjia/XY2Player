//
//  XYZRecommend3Cell.m
//  XY2Player
//
//  Created by zxs on 16/3/28.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZRecommend3Cell.h"

@implementation XYZRecommend3Cell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor blackColor];
        _imageiPic = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imageiPic];
        _imageiPic.contentMode = UIViewContentModeScaleAspectFill;
        _imageiPic.clipsToBounds = YES;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageiPic.frame.size.height-25, _imageiPic.frame.size.width, 25)];
        [_titleLabel setAlpha:0.3];
        [_titleLabel setBackgroundColor:[UIColor blackColor]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_titleLabel setNumberOfLines:1.0f];
        [_titleLabel setLineBreakMode:NSLineBreakByCharWrapping]; // 保留边界
        [_imageiPic addSubview:_titleLabel];
    }
    return self;
}
- (void)setModelWhitRecom:(XYZRecommend3Model *)recom {
    [_titleLabel setText:recom.name];
    NSLog(@"%@",recom.img);
    [_imageiPic sd_setImageWithURL:[NSURL URLWithString:recom.img] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
- (void)setModelWhitRecom4:(XYZRecom4Model *)recom {
    [_titleLabel setText:recom.title];
    [_imageiPic sd_setImageWithURL:[NSURL URLWithString:recom.imgUrlTb] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
@end
