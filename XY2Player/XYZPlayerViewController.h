//
//  XYZPlayerViewController.h
//  XY2Player
//
//  Created by zxs on 16/3/22.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYZReplyCell.h"
@interface XYZPlayerViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic, strong) NSString *mp4Url;     // 片源
@property (nonatomic, strong) NSString *picImage;   // 图片
@property (nonatomic, strong) NSString *indexMask;  // 遮罩的一个标识
@property (nonatomic, strong) NSString *iamgePic;   // 请求图片是否需要http前缀
@property (nonatomic, strong) NSString *nomp4Url;   // 暂无影片
/**
 *   上一个页面的视图
 */
@property (nonatomic, strong) id viewController;

@end
