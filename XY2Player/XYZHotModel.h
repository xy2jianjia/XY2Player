//
//  XYZHotModel.h
//  XY2Player
//
//  Created by zxs on 16/3/22.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYZHotModel : NSObject
@property (nonatomic, strong) NSString *city;      // 城市
@property (nonatomic, strong) NSNumber *id;        // id
@property (nonatomic, strong) NSString *imageurl;  // 播放图片
@property (nonatomic, strong) NSString *subtitle;  // 观看人数
@property (nonatomic, strong) NSString *title;     // 标题
@property (nonatomic, strong) NSString *url;       // 播放地址
@property (nonatomic, strong) NSString *usericon;  // 头像
@property (nonatomic, strong) NSString *username;  // 昵称
@end
