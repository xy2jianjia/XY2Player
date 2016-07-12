//
//  XYZReplyCell.h
//  XY2Player
//
//  Created by xy2 on 16/5/15.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZReplyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImageV;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end
