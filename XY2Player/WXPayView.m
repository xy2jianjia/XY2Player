//
//  WXPayView.m
//  WXPay
//
//  Created by zxs on 16/4/5.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "WXPayView.h"

@implementation WXPayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self s_wxpayLay];
    }
    return self;
}
- (void)s_wxpayLay {
        s_dot = [[UIButton alloc] init];
      s_image = [[UIImageView alloc] init];
      s_price = [[UILabel alloc] init];
    s_wxbutton = [[UIButton alloc] init];
//    s_wxImage = [[UIImageView alloc] init];
    
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.layer setMasksToBounds:true];
    [self.layer setCornerRadius:7.0];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [[UIColor blackColor]CGColor];
    [s_wxbutton.layer setMasksToBounds:true];
    [s_wxbutton.layer setCornerRadius:5.0];
    [s_wxbutton setTitle:@"微信支付" forState:(UIControlStateNormal)];
    [s_wxbutton addTarget:self action:@selector(s_wxpayAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [s_dot setImage:[UIImage imageNamed:@"close"] forState:(UIControlStateNormal)];
    [s_dot addTarget:self action:@selector(s_dotAction:) forControlEvents:(UIControlEventTouchUpInside)];
    UIImage *image = [UIImage imageNamed:@"s_wxpay.jpg"];
    [s_image setImage:image];
//    [s_wxImage setImage:[UIImage imageNamed:@"wxImage"]];
    [s_wxbutton setBackgroundColor:[UIColor greenColor]];
    [s_price setText:@"会员只需要52元"];
    [s_price setFont:[UIFont systemFontOfSize:15]];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"会员只需要52元"];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:20.0]
     
                          range:NSMakeRange(5, 2)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor redColor]
     
                          range:NSMakeRange(5, 2)];
    
    s_price.attributedText = AttributedStr;
    
    [self addSubview:s_image];
    [s_image addSubview:s_price];
    [self addSubview:s_dot];
    [self addSubview:s_wxbutton];
//    [s_wxbutton addSubview:s_wxImage];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat priceW = [self stringWidth:s_price.text];
    [s_dot setFrame:CGRectMake(self.bounds.size.width-S_DOTWIDTH-5, 5, S_DOTWIDTH, S_DOTWIDTH)];
    [s_image setFrame:CGRectMake(0, 0, self.bounds.size.width, 190)];
    [s_wxbutton setFrame:CGRectMake(15, CGRectGetMaxY(s_image.frame)+8, self.bounds.size.width-30, self.bounds.size.height-190-16)];
//    [s_wxImage setFrame:CGRectMake(20, 5, (self.bounds.size.height-190-16)-10, (self.bounds.size.height-190-16)-10)];
    [s_price setFrame:CGRectMake(self.bounds.size.width-priceW, CGRectGetMaxY(s_image.frame)-35, priceW, 35)];
}
- (void)s_dotAction:(UIButton *)sender {
    [UIView animateWithDuration:0.4 animations:^{
        self.frame = CGRectZero;
    }];
    
}
- (void)s_wxpayAction:(UIButton *)sender {
    [MobClick event:@"btn_wx_pay_clicked"];
    [BlockSort sendPay_demo];
}
#pragma mark ---- 自适应宽度
- (CGFloat)stringWidth:(NSString *)aString{
    CGRect r = [aString boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18.0f]} context:nil];
    return r.size.width;
}
@end
