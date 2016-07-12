//
//  XYZ_HZChannelDao.h
//  XY2Player
//
//  Created by xy2 on 16/4/1.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "DBManager.h"

@interface XYZ_HZChannelDao : DBManager

/**
 *  检测是否存在
 *
 *  @param hotId
 *
 *  @return
 */
+ (BOOL) checkChannelWithChanneltId:(NSString *)hotId;
/**
 *  插入数据
 *
 *  @param item
 */
+ (void) asyncInsertChannelToDbWithItem:(XYZHotModel *)item;
/**
 *  查询列表
 *
 *  @return
 */
+ (NSMutableArray *)asyncGetChannelList;

@end
