//
//  XYZChannelCell.h
//  XY2Player
//
//  Created by zxs on 16/3/22.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYZChannel;
@interface XYZChannelCell : UICollectionViewCell {
    UIView *_view;
    UIImageView *_imageiPic;
    UILabel *_title;
}
- (void)setModelWithXYZChannel:(XYZChannel *)channelModel;
@end
