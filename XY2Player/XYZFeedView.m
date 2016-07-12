//
//  XYZFeedView.m
//  XY2Player
//
//  Created by zxs on 16/3/28.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZFeedView.h"

@implementation XYZFeedView
- (NSArray *)s_titleArray {
    return @[@"推荐专页",@"热门专页",@"频道专页"];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        s_content = [[UILabel alloc] init];
        [s_content setFrame:CGRectMake((WIDTH-(WIDTH-80))/2, 64+20, WIDTH-80, 100)];
        [s_content setNumberOfLines:3];
        [s_content setFont:[UIFont systemFontOfSize:16]];
        [s_content setText:@"欢迎您提出宝贵的意见和建议,我们将认真及时的处理,更好的提升产品和服务质量,非常感谢!您认为以下页面仍需要改进:"];
        [self addSubview:s_content];
        self.s_dotArray = @[].mutableCopy;
        for (int i = 0; i < 3; i ++) {
            s_dot = [[UIButton alloc] init];
            [s_dot setTag:i];
            [s_dot setFrame:CGRectMake(60, CGRectGetMaxY(s_content.frame)+10+30*i, 25, 25)];
            [s_dot setImage:[UIImage imageNamed:@"Choice-normal"] forState:(UIControlStateNormal)];
            [s_dot addTarget:self action:@selector(s_dotAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:s_dot];
            [self.s_dotArray addObject:s_dot];
            
            s_title = [[UILabel alloc] init];
            [s_title setFrame:CGRectMake(CGRectGetMaxX(s_dot.frame)+15, CGRectGetMinY(s_dot.frame), 160, 25)];
            [s_title setText:self.s_titleArray[i]];
            [s_title setFont:[UIFont systemFontOfSize:16]];
            [self addSubview:s_title];
        }
        
        _s_textView = [[UITextView alloc] init];
        [_s_textView setFrame:CGRectMake((WIDTH-(WIDTH-100))/2, CGRectGetMaxY(s_content.frame)+130, WIDTH-100, 120)];
        [_s_textView.layer setMasksToBounds:true];
        [_s_textView.layer setCornerRadius:5.0];
        [_s_textView.layer setBorderWidth:0.5f];
        [_s_textView.layer setBorderColor:[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]CGColor]];
        [self addSubview:_s_textView];
        
        s_submit = [[UIButton alloc] init];
        [s_submit setTag:10];
        [s_submit.layer setMasksToBounds:true];
        [s_submit.layer setCornerRadius:5.0];
        [s_submit.layer setBorderWidth:0.5f];
        [s_submit.layer setBorderColor:[[UIColor colorWithRed:0 green:0 blue:0 alpha:1]CGColor]];
        [s_submit setTitle:@"提交" forState:(UIControlStateNormal)];
        [s_submit addTarget:self action:@selector(s_submitAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [s_submit setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [s_submit setFrame:CGRectMake((WIDTH-140)/2, CGRectGetMaxY(_s_textView.frame)+30, 140, 30)];
        [self addSubview:s_submit];
        
        
    }
    return self;
}
- (void)s_dotAction:(UIButton *)sender {
    for (UIButton *s_dotBut in self.s_dotArray) {
        if (s_dotBut.tag == sender.tag) {
            [s_dotBut setImage:[UIImage imageNamed:@"chosedot"] forState:(UIControlStateNormal)];
        }else {
            [s_dotBut setImage:[UIImage imageNamed:@"Choice-normal"] forState:(UIControlStateNormal)];
        }
    }
}

- (void)s_submitAction:(UIButton *)sender {
    self.s_block(sender.tag);
}
@end
