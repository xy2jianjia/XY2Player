//

//  RCloudMessage
//
//  Created by wjb on 15/6/3.
//  Copyright (c) 2015年 wbj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

+ (void)createUserTableWithSQL:(NSString *)sql tableName:(NSString *)tableName;

@end
