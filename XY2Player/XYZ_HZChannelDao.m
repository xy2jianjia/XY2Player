//
//  XYZ_HZChannelDao.m
//  XY2Player
//
//  Created by xy2 on 16/4/1.
//  Copyright © 2016年 YSKS.cn. All rights reserved.
//

#import "XYZ_HZChannelDao.h"
#import "DBHelper.h"

static NSString * const CHANNELTABEL = @"CHANNELTABEL";
@implementation XYZ_HZChannelDao

+(instancetype)shareInstance{
    static XYZ_HZChannelDao *dao = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dao = [[XYZ_HZChannelDao alloc]init];
        [dao createTable];
    });
    return dao;
}
- (void)createTable{
    NSString *createTableSQL = @"CREATE TABLE CHANNELTABEL (id text,imageurl text,title text)";
    [XYZ_HZChannelDao createUserTableWithSQL:createTableSQL tableName:CHANNELTABEL];
}
+ (BOOL) checkChannelWithChanneltId:(NSString *)channelId{
    return [[XYZ_HZChannelDao shareInstance] checkChannelWithChanneltId:channelId];
}
- (BOOL) checkChannelWithChanneltId:(NSString *)channelId{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM CHANNELTABEL WHERE id = '%@'",channelId];
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
+ (void) asyncInsertChannelToDbWithItem:(XYZChannel *)item{
    [[XYZ_HZChannelDao shareInstance] asyncInsertChannelToDbWithItem:item];
}
- (void) asyncInsertChannelToDbWithItem:(XYZChannel *)item{
    NSString * insertSql = [NSString stringWithFormat:@"INSERT INTO CHANNELTABEL (id ,imageurl ,title ) VALUES  ('%@','%@','%@')",item.id,item.imageurl,item.title];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:insertSql];
    }];
}
+ (NSMutableArray *)asyncGetChannelList{
    return [[XYZ_HZChannelDao shareInstance] asyncGetChannelList];
}
- (NSMutableArray *)asyncGetChannelList{
    NSMutableArray *allMutableArray = [NSMutableArray array];
    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM CHANNELTABEL"];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            XYZChannel *item = [[XYZChannel alloc] init];
            item.id = [NSNumber numberWithInteger:[[result stringForColumn:@"id"] integerValue]];
//            item.city = [result stringForColumn:@"city"];
            item.imageurl = [result stringForColumn:@"imageurl"];
//            item.subtitle = [result stringForColumn:@"subtitle"];
            item.title = [result stringForColumn:@"title"];
//            item.url = [result stringForColumn:@"url"];
//            item.usericon = [result stringForColumn:@"usericon"];
//            item.username = [result stringForColumn:@"username"];
            [allMutableArray addObject:item];
        }
        [result close];
    }];
    return allMutableArray;
}
@end
