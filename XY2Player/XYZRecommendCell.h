//
//  XYZRecommendCell.h
//  XY2Player
//
//  Created by zxs on 16/3/21.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYZRecommendModel;
@interface XYZRecommendCell : UICollectionViewCell {
    UIImageView *_imageiPic;
    UIImageView *_playerImage;
}
- (void)setModelWithRecommend:(XYZRecommendModel *)recommend;
@end
