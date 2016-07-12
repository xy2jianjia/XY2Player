//
//  XYZ_HZVipDao.m
//  XY2Player
//
//  Created by xy2 on 16/4/5.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZ_HZVipDao.h"
#import "DBHelper.h"
#import "XYZ_HZVipModel.h"
static NSString * const VIPTABLE = @"VIPTABLE";
@implementation XYZ_HZVipDao

+(instancetype)shareInstance{
    static XYZ_HZVipDao *dao = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dao = [[XYZ_HZVipDao alloc]init];
        [dao createTable];
    });
    return dao;
}
- (void)createTable{
    NSString *createTableSQL = @"CREATE TABLE VIPTABLE (uuId text,vipDate text,money text)";
    [XYZ_HZVipDao createUserTableWithSQL:createTableSQL tableName:VIPTABLE];
}
+ (BOOL) checkVipWithUUID:(NSString *)uuId{
    return [[XYZ_HZVipDao shareInstance] checkVipWithUUID:uuId];
}
- (BOOL) checkVipWithUUID:(NSString *)uuId{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM VIPTABLE WHERE uuId = '%@'",uuId];
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
+ (void) asyncInsertVipToDbWithItem:(XYZ_HZVipModel *)item{
    [[XYZ_HZVipDao shareInstance] asyncInsertVipToDbWithItem:item];
}
- (void) asyncInsertVipToDbWithItem:(XYZ_HZVipModel *)item{
    NSString * insertSql = [NSString stringWithFormat:@"INSERT INTO VIPTABLE (uuId ,vipDate ,money ) VALUES  ('%@','%@','%@')",item.uuid,item.vipDate,item.money];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:insertSql];
    }];
}
+ (NSMutableArray *)asyncGetVipList{
    return [[XYZ_HZVipDao shareInstance] asyncGetVipList];
}
- (NSMutableArray *)asyncGetVipList{
    NSMutableArray *allMutableArray = [NSMutableArray array];
    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM VIPTABLE"];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            XYZ_HZVipModel *item = [[XYZ_HZVipModel alloc] init];
            item.uuid = [result stringForColumn:@"uuId"];
            item.vipDate = [result stringForColumn:@"vipDate"];
            item.money = [result stringForColumn:@"money"];
            [allMutableArray addObject:item];
        }
        [result close];
    }];
    return allMutableArray;
}

@end
