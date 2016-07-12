//
//  XYZHitCell.m
//  XY2Player
//
//  Created by zxs on 16/3/25.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZHitCell.h"

@implementation XYZHitCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor blackColor];
        _imageiPic = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imageiPic];
     }
    return self;
}
- (void)setModelWithNextChannel:(XYZHitModel *)nextChannel {

    [_imageiPic sd_setImageWithURL:[NSURL URLWithString:nextChannel.imgUrl] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
@end
