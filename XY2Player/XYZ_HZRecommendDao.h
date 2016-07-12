//
//  XYZ_HZRecommendDao.h
//  XY2Player
//
//  Created by xy2 on 16/4/1.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "DBManager.h"

@interface XYZ_HZRecommendDao : DBManager

+ (BOOL) checkRecommendWithRecommendTitle:(NSString *)title;

+ (void) asyncInsertRecommendToDbWithItem:(XYZFirstModel *)item;

+ (NSMutableArray *)asyncGetRecommendList;
@end
