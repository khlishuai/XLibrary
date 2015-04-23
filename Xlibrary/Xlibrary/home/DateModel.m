//
//  DateModel.m
//  Xlibrary
//
//  Created by wgl7569 on 15-4-17.
//  Copyright (c) 2015年 mc. All rights reserved.
//

#import "DateModel.h"

@implementation DateModel
{
    NSString *curDay;
    NSString *lastDay;
    NSString *nextDay;
}
-(id)init{
    static id obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ((obj = [super init])!= nil){
            curDay = [NSString string];
            lastDay = [NSString string];
            nextDay = [NSString string];
        }
    });
        self = obj;
        return self;
}
singleton_m(DateModel);
-(NSString *)getCurDay{
    if ([curDay isEqual:@""]){
        [self setCurDay:[NSDate date]];
    }
    return curDay;
}
-(NSString *)getlastDay{
    if ([lastDay isEqual:@""]){
        [self setCurDay:[NSDate date]];
    }
    return lastDay;
}
-(NSString *)getNextDay{
    if ([nextDay isEqual:@""]){
        [self setCurDay:[NSDate date]];
    }
    return nextDay;
}

-(void)setCurDay:(id)date{
    NSDate *nowDate = nil;
    if ([date isKindOfClass:[NSString class]]){
        nowDate = [self transToDate:date];
    }
    else{
        nowDate = (NSDate *)date;
    }
    curDay = [self transToStr:nowDate];
    nextDay = [self transToStr:[NSDate dateWithTimeInterval:24*60*60 sinceDate:nowDate]];
    lastDay = [self transToStr:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:nowDate]];
}
-(NSString *)transToStr:(NSDate*)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setAMSymbol:@"AM"];
    [formatter setPMSymbol:@"PM"];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
-(NSDate *)transToDate:(NSString *)dateStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setAMSymbol:@"AM"];
    [formatter setPMSymbol:@"PM"];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
