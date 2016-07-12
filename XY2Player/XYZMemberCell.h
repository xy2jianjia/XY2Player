//
//  XYZMemberCell.h
//  XY2Player
//
//  Created by zxs on 16/3/28.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZMemberCell : UITableViewCell {
    UIImageView *_imageView;
    UILabel *_titleLabel;
}
- (void)s_Image:(NSString *)image title:(NSString *)title;
@end
