//
//  XDatabase.h
//  Xlibrary
//
//  Created by mc on 15/4/23.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "XPIModel.h"




@interface XDatabase : NSObject


@property(nonatomic,strong)FMDatabaseQueue* GeebooQueue;


+(id)shareInstance;

-(void)insertPIDataWithModel:(XPIModel*)xpimodel;

-(void)updateUserInformationWithModel:(XPIModel*)xpimodel;

- (NSMutableArray *)getDataarrayFrome:(NSString*)begindate toEnd:(NSString*)enddate;


-(void)deleteData:(XPIModel*)model;


@end
