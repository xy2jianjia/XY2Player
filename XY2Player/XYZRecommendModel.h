//
//  XYZRecommendModel.h
//  XY2Player
//
//  Created by zxs on 16/3/23.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZRecommendModel : NSObject
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *imageurl;
@property (nonatomic, strong) NSString *subtitle; // 时间
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;    // .mp4
@end
