//
//  XYZNexChannelCell.m
//  XY2Player
//
//  Created by zxs on 16/3/23.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZNexChannelCell.h"

@implementation XYZNexChannelCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageiPic = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imageiPic];
        _imageiPic.contentMode = UIViewContentModeScaleAspectFill;
        _imageiPic.clipsToBounds = YES;
        _playerImage = [[UIImageView alloc] initWithFrame:CGRectMake(_imageiPic.frame.size.width/2-NEXTCHANNELCELLH/2, _imageiPic.frame.size.height/2-NEXTCHANNELCELLH/2, NEXTCHANNELCELLH, NEXTCHANNELCELLH)];
        [_imageiPic addSubview:_playerImage];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _imageiPic.frame.size.height-25, _imageiPic.frame.size.width, 25)];
        [_titleLabel setAlpha:0.4];
        [_titleLabel setBackgroundColor:[UIColor blackColor]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_titleLabel setNumberOfLines:1.0f];
        [_titleLabel setLineBreakMode:NSLineBreakByCharWrapping]; // 保留边界
        [_imageiPic addSubview:_titleLabel];
    }
    return self;
}
- (void)setModelWithNextChannel:(XYZNextChannel *)nextChannel {
    _titleLabel.text = nextChannel.title;
    if (nextChannel.title.length != 0) {
        [_playerImage setImage:[UIImage imageNamed:@"Play-button"]];
    }
    [_imageiPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XY2HTTP,nextChannel.imageurl]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
- (void)setmodelWITHRemmend:(XYZRecom2Model *)remmend {
    _titleLabel.text = remmend.title;
    if (remmend.title.length != 0) {
        [_playerImage setImage:[UIImage imageNamed:@"Play-button"]];
    }
    [_imageiPic sd_setImageWithURL:[NSURL URLWithString:remmend.imgurl] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
- (void)setModelWithNextRecommend:(XYZNextRecommend4Model *)recommend {
    _titleLabel.text = recommend.title;
    if (recommend.title.length != 0) {
        [_playerImage setImage:[UIImage imageNamed:@"Play-button"]];
    }
    [_imageiPic sd_setImageWithURL:[NSURL URLWithString:recommend.imgUrl1] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
@end
