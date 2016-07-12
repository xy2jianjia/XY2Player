//
//  XYZHotViewCell.m
//  XY2Player
//
//  Created by zxs on 16/3/21.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZHotViewCell.h"

@implementation XYZHotViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self imageLayout];
    }
    return self;
}

- (void)imageLayout {
    self.contentView.backgroundColor = [UIColor blackColor];
    _iamgePic = [[UIImageView alloc] init];
    _addreImage = [[UIImageView alloc] init];
    _nickNLabel = [[UILabel alloc] init];
    _titleLabel = [[UILabel alloc] init];
    _addreLabel = [[UILabel alloc] init];
    _watchLabel = [[UILabel alloc] init];
    
    
    _iamgePic.contentMode = UIViewContentModeScaleAspectFill; // 按照比例放大
    _iamgePic.clipsToBounds  = YES; // 放大超过显示屏的地方裁剪掉
    [_iamgePic.layer setMasksToBounds:YES];
    [_iamgePic.layer setCornerRadius:5];
    
    [_titleLabel setNumberOfLines:2.0f];
    [_titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [_nickNLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [_addreLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [_watchLabel setFont:[UIFont systemFontOfSize:10.0f]];
    
    [_titleLabel setLineBreakMode:NSLineBreakByCharWrapping]; // 保留边界
    [_titleLabel setTextColor:[UIColor darkGrayColor]];
    [_nickNLabel setTextColor:kUIColorFromRGB(0x35a3b1)];
    [_addreLabel setTextColor:[UIColor grayColor]];
    [_watchLabel setTextColor:[UIColor grayColor]];
    _watchLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:_iamgePic];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_nickNLabel];
    [self.contentView addSubview:_addreImage];
    [self.contentView addSubview:_addreLabel];
    [self.contentView addSubview:_watchLabel];
    
    _addreImage.image = [UIImage imageNamed:@"icon-gps-n-0"];

}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat nickNameW = [self stringWidth:_nickNLabel.text];
    CGFloat addressW  = [self stringWidth:_addreLabel.text];
    CGFloat watchNumW = [self stringWidth:_watchLabel.text];
    _iamgePic.frame = CGRectMake(10, 10, HeaderImageWidth, HeaderImageWidth);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_iamgePic.frame)+10, 10, WIDTH-20-20-20-HeaderImageWidth, 45);
    _nickNLabel.frame = CGRectMake(CGRectGetMaxX(_iamgePic.frame)+10, CGRectGetMaxY(_titleLabel.frame)+5, nickNameW, 20);
    _addreImage.frame = CGRectMake(CGRectGetMaxX(_iamgePic.frame)+10, CGRectGetMaxY(_nickNLabel.frame)+5, 12, 16);
    _addreLabel.frame = CGRectMake(CGRectGetMaxX(_addreImage.frame)+10, CGRectGetMinY(_addreImage.frame), addressW, 20);
    _watchLabel.frame = CGRectMake(CGRectGetMaxX(_addreLabel.frame)+20, CGRectGetMinY(_addreLabel.frame), watchNumW, 20);
}

- (void)setHotModel:(XYZHotModel *)hotmodel {
    _titleLabel.text = hotmodel.title;
    _addreLabel.text = hotmodel.city;
    _watchLabel.text = [NSString stringWithFormat:@"%@ 人在看",hotmodel.subtitle];
    _nickNLabel.text = hotmodel.username;
    NSString *iamgeUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"httpImageUrl"];
    [_iamgePic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",iamgeUrl,hotmodel.usericon]] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:_watchLabel.text];
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:14.0]
     
                          range:NSMakeRange(0, _watchLabel.text.length-4)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor redColor]
     
                          range:NSMakeRange(0, _watchLabel.text.length-4)];
    
    _watchLabel.attributedText = AttributedStr;
}

#pragma mark ---- 自适应宽度
- (CGFloat)stringWidth:(NSString *)aString{
    CGRect r = [aString boundingRectWithSize:CGSizeMake(320, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil];
    return r.size.width;
}
@end
