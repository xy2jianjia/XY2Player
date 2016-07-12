//
//  XYZ_HZHotDao.m
//  XY2Player
//
//  Created by xy2 on 16/4/1.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZ_HZHotDao.h"
#import "DBHelper.h"
static NSString * const HOTTABLE = @"HOTTABLE";
@implementation XYZ_HZHotDao

+(instancetype)shareInstance{
    static XYZ_HZHotDao *dao = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dao = [[XYZ_HZHotDao alloc]init];
        [dao createTable];
    });
    return dao;
}
- (void)createTable{
    NSString *createTableSQL = @"CREATE TABLE HOTTABLE (id text,city text,imageurl text,subtitle text,title text,url text,usericon text,username text)";
    [XYZ_HZHotDao createUserTableWithSQL:createTableSQL tableName:HOTTABLE];
}
+ (BOOL) checkHotWithHottId:(NSString *)hotId{
    return [[XYZ_HZHotDao shareInstance] checkHotWithHottId:hotId];
}
- (BOOL) checkHotWithHottId:(NSString *)hotId{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM HOTTABLE WHERE id = '%@'",hotId];
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
+ (void) asyncInsertHotToDbWithItem:(XYZHotModel *)item{
    [[XYZ_HZHotDao shareInstance] asyncInsertHotToDbWithItem:item];
}
- (void) asyncInsertHotToDbWithItem:(XYZHotModel *)item{
    NSString * insertSql = [NSString stringWithFormat:@"INSERT INTO HOTTABLE (id ,city ,imageurl ,subtitle ,title ,url ,usericon ,username ) VALUES  ('%@','%@','%@','%@','%@','%@','%@','%@')",item.id,item.city,item.imageurl,item.subtitle,item.title,item.url,item.usericon,item.username];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:insertSql];
    }];
}
+ (NSMutableArray *)asyncGetHotList{
    return [[XYZ_HZHotDao shareInstance] asyncGetHotList];
}
- (NSMutableArray *)asyncGetHotList{
    NSMutableArray *allMutableArray = [NSMutableArray array];
    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM HOTTABLE"];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            XYZHotModel *item = [[XYZHotModel alloc] init];
            item.id = [NSNumber numberWithInteger:[[result stringForColumn:@"id"] integerValue]];
            item.city = [result stringForColumn:@"city"];
            item.imageurl = [result stringForColumn:@"imageurl"];
            item.subtitle = [result stringForColumn:@"subtitle"];
            item.title = [result stringForColumn:@"title"];
            item.url = [result stringForColumn:@"url"];
            item.usericon = [result stringForColumn:@"usericon"];
            item.username = [result stringForColumn:@"username"];
            [allMutableArray addObject:item];
        }
        [result close];
    }];
    return allMutableArray;
}


@end
