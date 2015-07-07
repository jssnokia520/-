//
//  JSSStatusTool.m
//  高仿微博
//
//  Created by JiShangsong on 15/7/7.
//  Copyright (c) 2015年 JiShangsong. All rights reserved.
//

#import "JSSStatusTool.h"
#import "FMDB.h"

static FMDatabase *_db;

@implementation JSSStatusTool

+ (void)initialize
{
    // 打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 创建表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS statuses(id integer PRIMARY KEY, status blob NOT NULL, idstr text NOT NULL)"];
}

/**
 *  存储缓存数据
 */
+ (void)saveStatusData:(NSArray *)statuses
{
    for (NSDictionary *status in statuses) {
        NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"INSERT INTO statuses (status, idstr) VALUES (%@, %@)", statusData, status[@"idstr"]];
    }
}

/**
 *  获取缓存数据
 */
+ (NSArray *)statusWithParameters:(NSDictionary *)parameters
{
    FMResultSet *set = nil;
    if (parameters[@"since_id"]) {
        set = [_db executeQueryWithFormat:@"SELECT * FROM statuses WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20", parameters[@"since_id"]];
    } else if (parameters[@"max_id"]) {
        set = [_db executeQueryWithFormat:@"SELECT * FROM statuses WHERE idstr <= %@ ORDER BY idstr DESC LIMIT 20", parameters[@"max_id"]];
    } else {
        set = [_db executeQuery:@"SELECT * FROM statuses ORDER BY idstr DESC LIMIT 20"];
    }
    
    NSMutableArray *statuses = [NSMutableArray array];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        [statuses addObject:status];
    }
    
    return statuses;
}

@end
