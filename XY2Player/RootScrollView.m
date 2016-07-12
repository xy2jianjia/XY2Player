//
//  RootScrollView.m
//  YSTiele
//
//  Created by zxs on 16/3/9.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "RootScrollView.h"

@implementation RootScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,SCROLLER,WIDTH, HEIGHT-SCROLLER)];
        self.contentScrollView.pagingEnabled = true;
        self.contentScrollView.showsHorizontalScrollIndicator = false;
        [self addSubview:self.contentScrollView];
        
    }
    return self;
}
@end
