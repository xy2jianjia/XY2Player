//
//  XYZRecommend3Cell.h
//  XY2Player
//
//  Created by zxs on 16/3/28.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYZRecommend3Model;
@class XYZRecom4Model;
@interface XYZRecommend3Cell : UICollectionViewCell {
    UIImageView *_imageiPic;
    UILabel *_titleLabel;
}
- (void)setModelWhitRecom:(XYZRecommend3Model *)recom;
- (void)setModelWhitRecom4:(XYZRecom4Model *)recom;
@end
