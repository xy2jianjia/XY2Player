//
//  XYZMemberCell.m
//  XY2Player
//
//  Created by zxs on 16/3/28.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZMemberCell.h"

@implementation XYZMemberCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.contentView.backgroundColor = [UIColor blackColor];
         _imageView = [[UIImageView alloc] init];
        _titleLabel = [[UILabel alloc] init];
        [_imageView setFrame:CGRectMake(10, 20, 20, 20)];
        [_titleLabel setFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+10, 15, 100, 30)];
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}
- (void)s_Image:(NSString *)image title:(NSString *)title {
    _titleLabel.text = title;
    _imageView.image = [UIImage imageNamed:image];
}
@end
