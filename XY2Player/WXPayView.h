//
//  WXPayView.h
//  WXPay
//
//  Created by zxs on 16/4/5.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#define S_DOTWIDTH 25
@class WXPayView;
@protocol WXPayViewDelegate <NSObject>

- (void)clickPay:(WXPayView *)pay indexPay:(NSInteger)indexPay;

@end
@interface WXPayView : UIView  {

    UIImageView *s_image;   // 图片
    UIButton *s_dot;        // 关闭
    UIButton *s_wxbutton;     // 微信支付
    UIImageView *s_wxImage; // 支付图片
    UILabel *s_price;  // 价格
}
@property (nonatomic,weak) id<WXPayViewDelegate>s_payViewDelegate;
@end
