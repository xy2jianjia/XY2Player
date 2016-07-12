//
//  XYZHeaderReusableView.m
//  XY2Player
//
//  Created by zxs on 16/3/21.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZHeaderReusableView.h"

@implementation XYZHeaderReusableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WIDTH-10-20, 30)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)titleLabel {
    _titleLabel.text = titleLabel;
}
@end
