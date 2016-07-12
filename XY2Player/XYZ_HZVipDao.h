//
//  XYZ_HZVipDao.h
//  XY2Player
//
//  Created by xy2 on 16/4/5.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "DBManager.h"

@interface XYZ_HZVipDao : DBManager
// 是否vip存在，村子则为vip。
+ (BOOL) checkVipWithUUID:(NSString *)uuId;
+ (void) asyncInsertVipToDbWithItem:(XYZ_HZVipModel *)item;
@end
