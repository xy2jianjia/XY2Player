//
//  RCloudMessage
//
//  Created by wbj on 15/6/3.
//  Copyright (c) 2015年 wbj. All rights reserved.
//

#import "DBManager.h"
#import "DBHelper.h"
@implementation DBManager




//static NSString * const ROBOTTABLE = @"ROBOTTABLE";

#pragma mark - Singleton
+ (instancetype)shareInstance{
    static DBManager* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
//创建用户存储表
+ (void)createUserTableWithSQL:(NSString *)sql tableName:(NSString *)tableName{
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![DBHelper isTableOK: tableName withDB:db]) {
            [db executeUpdate:sql];
        }
    }];
}
@end
