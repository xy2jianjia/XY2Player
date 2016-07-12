//
//  XYZHotViewCell.h
//  XY2Player
//
//  Created by zxs on 16/3/21.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZHotModel.h"
@interface XYZHotViewCell : UITableViewCell {
    UILabel *_titleLabel;  // 标题
    UILabel *_addreLabel;  // 地址
    UILabel *_nickNLabel;  // 昵称
    UILabel *_watchLabel;  // 观看人数
    UIImageView *_addreImage; // 地址图片
}
@property (nonatomic, strong) UIImageView *iamgePic; // 发帖人头像

- (void)setHotModel:(XYZHotModel *)hotmodel;
@end
