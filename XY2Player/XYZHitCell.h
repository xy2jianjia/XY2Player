//
//  XYZHitCell.h
//  XY2Player
//
//  Created by zxs on 16/3/25.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYZHitModel;
@interface XYZHitCell : UICollectionViewCell {
    UIImageView *_imageiPic;
    UIImageView *_playerImage;
}
- (void)setModelWithNextChannel:(XYZHitModel *)nextChannel;

@end
