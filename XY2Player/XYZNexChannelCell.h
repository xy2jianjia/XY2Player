//
//  XYZNexChannelCell.h
//  XY2Player
//
//  Created by zxs on 16/3/23.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYZNextChannel;
@class XYZRecom2Model;
@interface XYZNexChannelCell : UICollectionViewCell {
    UIImageView *_imageiPic;
    UIImageView *_playerImage;
    UILabel *_titleLabel;
}
- (void)setModelWithNextChannel:(XYZNextChannel *)nextChannel;
- (void)setmodelWITHRemmend:(XYZRecom2Model *)remmend;
- (void)setModelWithNextRecommend:(XYZNextRecommend4Model *)recommend;
@end
