//
//  XYZ_HZRecommendDao.m
//  XY2Player
//
//  Created by xy2 on 16/4/1.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZ_HZRecommendDao.h"
#import "DBHelper.h"
static NSString * const RECOMMENDTABLE = @"RECOMMENDTABLE";
@implementation XYZ_HZRecommendDao
+(instancetype)shareInstance{
    static XYZ_HZRecommendDao *dao = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dao = [[XYZ_HZRecommendDao alloc]init];
        [dao createTable];
    });
    return dao;
}
- (void)createTable{
    NSString *createTableSQL = @"CREATE TABLE RECOMMENDTABLE (imgurl text,title text,videoUrl text)";
    [XYZ_HZRecommendDao createUserTableWithSQL:createTableSQL tableName:RECOMMENDTABLE];
}
+ (BOOL) checkRecommendWithRecommendTitle:(NSString *)title{
    return [[XYZ_HZRecommendDao shareInstance] checkRecommendWithRecommendTitle:title];
}
- (BOOL) checkRecommendWithRecommendTitle:(NSString *)title{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM RECOMMENDTABLE WHERE title = '%@'",title];
    __block BOOL flag = NO;
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            flag = YES;
        }
        [rs close];
    }];
    return flag;
}
/**
 *  插入用户数据
 *
 *  @param item
 */
+ (void) asyncInsertRecommendToDbWithItem:(XYZFirstModel *)item{
    [[XYZ_HZRecommendDao shareInstance] asyncInsertRecommendToDbWithItem:item];
}
- (void) asyncInsertRecommendToDbWithItem:(XYZFirstModel *)item{
    NSString * insertSql = [NSString stringWithFormat:@"INSERT INTO RECOMMENDTABLE (imgurl ,title ,videoUrl ) VALUES  ('%@','%@','%@')",item.imgurl,item.title,item.videoUrl];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:insertSql];
    }];
}
+ (NSMutableArray *)asyncGetRecommendList{
    return [[XYZ_HZRecommendDao shareInstance] asyncGetRecommendList];
}
- (NSMutableArray *)asyncGetRecommendList{
    NSMutableArray *allMutableArray = [NSMutableArray array];
    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM RECOMMENDTABLE"];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            XYZFirstModel *item = [[XYZFirstModel alloc] init];
//            item.id = [NSNumber numberWithInteger:[[result stringForColumn:@"id"] integerValue]];
//            item.city = [result stringForColumn:@"city"];
            item.imgurl = [result stringForColumn:@"imgurl"];
//            item.subtitle = [result stringForColumn:@"subtitle"];
            item.title = [result stringForColumn:@"title"];
            item.videoUrl = [result stringForColumn:@"videoUrl"];
//            item.usericon = [result stringForColumn:@"usericon"];
//            item.username = [result stringForColumn:@"username"];
            [allMutableArray addObject:item];
        }
        [result close];
    }];
    return allMutableArray;
}



@end
