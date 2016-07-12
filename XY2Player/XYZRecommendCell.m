//
//  XYZRecommendCell.m
//  XY2Player
//
//  Created by zxs on 16/3/21.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZRecommendCell.h"

@implementation XYZRecommendCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _imageiPic = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imageiPic];
        _imageiPic.contentMode = UIViewContentModeScaleAspectFill;
        _imageiPic.clipsToBounds = YES;
        _playerImage = [[UIImageView alloc] initWithFrame:CGRectMake(_imageiPic.frame.size.width/2-NEXTCHANNELCELLH/2, _imageiPic.frame.size.height/2-NEXTCHANNELCELLH/2, NEXTCHANNELCELLH, NEXTCHANNELCELLH)];
        [_imageiPic addSubview:_playerImage];
    }
    return self;
}
- (void)setModelWithRecommend:(XYZRecommendModel *)recommend {
    
    if (recommend.title.length != 0) {
        [_playerImage setImage:[UIImage imageNamed:@"Play-button"]];
    }
    [_imageiPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XY2HTTP,recommend.imageurl]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
@end
