//
//  XDatabase.m
//  Xlibrary
//
//  Created by mc on 15/4/23.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "XDatabase.h"

@implementation XDatabase


#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

#define GeebooDB @"GB.db"

static XDatabase *dbConnection;

+(id)shareInstance
{
    if(!dbConnection)
    {
        static dispatch_once_t token;
        dispatch_once(&token, ^{
            dbConnection = [[XDatabase alloc]init];
        });
    }
    return dbConnection;
}
-(id)init{
    self=[super init];
    if (self) {
        // accountId = [UserInfor getInstanceUser].accountId;
        self.GeebooQueue= [FMDatabaseQueue databaseQueueWithPath:[self documentsDirectoryWithFileName:GeebooDB]];

    }
    
    return self;
}
-(NSString*)documentsDirectoryWithFileName:(NSString*)fileName
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    NSString *directoryString = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    return directoryString;
}


#pragma mark public

//添加数据
-(void)insertPIDataWithModel:(XPIModel *)xpimodel
{
    [self.GeebooQueue inDatabase:^(FMDatabase * db){
        [db beginTransaction];
        [db executeUpdate:@"insert into maintable (createtime,cyear,cmonth,cday,typestr,spendcount,describe,type,spendorincome) values(?,?,?,?,?,?,?,?,?)",xpimodel.createtime,xpimodel.cyear,xpimodel.cmonth,xpimodel.cday,xpimodel.typestr,xpimodel.spendcount,xpimodel.describe,xpimodel.type,xpimodel.spendorincome];
        FMDBQuickCheck(![db hadError]);
        [db commit];
    }];

}

//更新数据内容
-(void)updateUserInformationWithModel:(XPIModel*)xpimodel
{
    NSString *sqlOne;
    sqlOne = [NSString stringWithFormat:@"update maintable set typestr = '%@',spendcount = '%@', describe = '%@',type = '%@',spendincome = '%@' where createtime = '%@'",xpimodel.typestr,xpimodel.spendcount,xpimodel.describe,xpimodel.type,xpimodel.spendorincome,xpimodel.createtime];
    [self.GeebooQueue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        [db executeUpdate:sqlOne];
        FMDBQuickCheck(![db hadError]);
        NSLog(@"更新用户信息");
        [db commit];
    }];
    
}

//获得一个时间范围内的数据
- (NSMutableArray *)getDataarrayFrome:(NSString*)begindate toEnd:(NSString*)enddate
{
    NSString *sql = [NSString stringWithFormat:@"select * from maintable where createtime > '%@' and createtime < '%@'",begindate,enddate];
    
    NSMutableArray *registArr =[[NSMutableArray alloc]init];
    
    [self.GeebooQueue inDatabase:^(FMDatabase*db){
        FMResultSet* set=[db executeQuery:sql];
        while ([set next]) {
            
            XPIModel *model = [[XPIModel alloc]init];
            model.createtime =[set stringForColumn:@"createtime"];
            model.cyear = [set stringForColumn:@"cyear"];
            model.cmonth = [set stringForColumn:@"cmonth"];
            model.cday = [set stringForColumn:@"cday"];
            model.typestr = [set stringForColumn:@"typestr"];
            model.spendcount = [set stringForColumn:@"spendcount"];
            model.describe = [set stringForColumn:@"describe"];
            model.type = [set stringForColumn:@"type"];
            model.spendorincome = [set stringForColumn:@"spendorincome"];
            
            [registArr addObject:model];
        }
        
    }];
    
    
    return registArr;
    
}

//删除某条数据
-(void)deleteData:(XPIModel*)model
{
    [self.GeebooQueue inDatabase:^(FMDatabase *db) {
        [db beginTransaction];
        [db executeUpdate:@"DELETE FROM maintable where createtime = ?",model.createtime];
        FMDBQuickCheck(![db hadError]);
        LOG_ME_DEBUG(@"清除当前用户所有消息");
        [db commit];
    }];
}












@end
