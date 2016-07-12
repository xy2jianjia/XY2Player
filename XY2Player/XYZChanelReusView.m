//
//  XYZChanelReusView.m
//  XY2Player
//
//  Created by zxs on 16/3/22.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZChanelReusView.h"

@implementation XYZChanelReusView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WIDTH-10-20, 30)];
        [self addSubview:_titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)titleLabel {
    _titleLabel.text = titleLabel;
}
@end
