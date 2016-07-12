//
//  XYZChannelCell.m
//  XY2Player
//
//  Created by zxs on 16/3/22.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZChannelCell.h"

@implementation XYZChannelCell
- (instancetype)initWithFrame:(CGRect)frame {
    self.contentView.backgroundColor = [UIColor blackColor];
    self = [super initWithFrame:frame];
    if (self) {
        _view = [[UIView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_view];
        _imageiPic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _view.frame.size.width, _view.frame.size.height-30)];
        _imageiPic.contentMode = UIViewContentModeScaleAspectFill;
        _imageiPic.clipsToBounds = YES;
        
        [_view addSubview:_imageiPic];
        _title = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_imageiPic.frame), CGRectGetMaxY(_imageiPic.frame), _view.frame.size.width, 30)];
        _title.numberOfLines = 1;
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor = [UIColor darkGrayColor];
        _title.lineBreakMode = NSLineBreakByCharWrapping; // 保留边界
        [_view addSubview:_title];
    }
    return self;
}
- (void)setModelWithXYZChannel:(XYZChannel *)channelModel { 
    _title.text = channelModel.title;
    [_imageiPic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",XY2HTTP,channelModel.imageurl]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
@end
