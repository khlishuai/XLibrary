//
//  NSString+MyDate.m
//  MyDateDemo
//
//  Created by 学之网研发 on 14-5-13.
//  Copyright (c) 2014年 学之网研发. All rights reserved.
//

#import "NSString+MyDate.h"
#define NS_CALENDAR_UNIT NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitWeekday|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond




@implementation NSString (MyDate)

-(NSString*)timeStamp:(NSDate *)parameterDate
{
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[parameterDate timeIntervalSince1970]];
    return timeStamp;
}

-(NSString*)hourToMinutes:(NSDate*)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger minut = [comp1 minute];
    NSInteger hour = [comp1 hour];
    
    return [NSString stringWithFormat:@"%02d:%02d",(int)hour,(int)minut];
}

-(NSString*)monthToDays:(NSDate*)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger month = [comp1 month];
    NSInteger day = [comp1 day];
    
    return [NSString stringWithFormat:@"%02d月%02d日",(int)month,(int)day];
}

-(NSString*)yearToMonthToDays:(NSDate*)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger year = [comp1 year];
    NSInteger month = [comp1 month];
    NSInteger day = [comp1 day];
    
    return [NSString stringWithFormat:@"%2ld-%02ld-%02ld",(long)year,(long)month,(long)day];

}


-(NSString*)year:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger year = [comp1 year];
    
    return [NSString stringWithFormat:@"%d年",(int)year];
}
-(NSString*)month:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger month = [comp1 month];
    
    return [NSString stringWithFormat:@"%ld月份",(long)month];
}

-(NSString*)week:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger week = [comp1 weekday];
    
    return [NSString stringWithFormat:@"%d",(int)(week-1)];
}

+(NSString*)getWeekName:(int)weekInt
{
    NSString *name=@"";
    switch (weekInt) {
        case 1:
            name= @"星期日";
            break;
        case 2:
            name= @"星期一";
            break;
        case 3:
            name= @"星期二";
            break;
        case 4:
            name= @"星期三";
            break;
        case 5:
            name= @"星期四";
            break;
        case 6:
            name= @"星期五";
            break;
        case 7:
            name= @"星期六";
            break;
            
            
        default:
            name = @"";
            break;
    }
    return name;
}

-(NSString*)day:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger day = [comp1 day];
    
    return [NSString stringWithFormat:@"%d日",(int)day];
}

-(NSString*)hour:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger hour = [comp1 hour];
    
    return [NSString stringWithFormat:@"%d小时",(int)hour];
}

-(NSString*)minuts:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger minuts = [comp1 minute];
    
    return [NSString stringWithFormat:@"%d",(int)minuts];
}

-(NSString*)second:(NSDate *)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger second = [comp1 second];
    
    return [NSString stringWithFormat:@"%d秒",(int)second];
}
- (NSString *)hourAndMinute
{
    NSString *str1 = [NSString stringWithFormat:@"%lld",[self longLongValue]];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str1 longLongValue]];
    NSCalendar *myCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units  = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:confromTimesp];
    NSInteger minit = [comp1 minute];
    NSInteger hour = [comp1 hour];
    return [NSString stringWithFormat:@"%02ld:%02ld",hour,minit];
}

- (NSString *)todayHourAndMinute
{
    NSString *str1 = [NSString stringWithFormat:@"%lld",[self longLongValue]];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str1 longLongValue]];
    NSCalendar *myCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units  = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:confromTimesp];
    NSInteger minit = [comp1 minute];
    NSInteger hour = [comp1 hour];
    return [NSString stringWithFormat:@"今天%02ld:%02ld",hour,minit];
}



-(NSString*)AM_PM_Time
{
    NSString *str1 = [NSString stringWithFormat:@"%lld",[self longLongValue]];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str1 longLongValue]];
    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units  = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:confromTimesp];
    NSInteger minit = [comp1 minute];
    NSInteger hour = [comp1 hour];
    if(hour>12)
    {
        return [NSString stringWithFormat:@"%02ld:%02ldpm",hour-12,minit];
    }
    else
    {
        return [NSString stringWithFormat:@"%02ld:%02ldam",hour,minit];
    }
}

- (NSString *)monthAndDayTimeNO
{
    NSString *str1 = [NSString stringWithFormat:@"%lld",[self longLongValue]];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str1 longLongValue]];
    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units  = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:confromTimesp];
    NSInteger month = [comp1 month];
    NSInteger day = [comp1 day];
    return [NSString stringWithFormat:@"%02d 月 %02d 日",(int)month,(int)day];
}
- (NSString *)yearAndmonthAndDayTimeNO
{
    NSString *str1 = [NSString stringWithFormat:@"%lld",[self longLongValue]];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[str1 longLongValue]];
    NSCalendar *myCal = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units  = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:confromTimesp];
    NSInteger year = [comp1 year];
    NSInteger month = [comp1 month];
    NSInteger day = [comp1 day];
    return [NSString stringWithFormat:@"%d 年%02d 月 %02d 日",(int)year,(int)month,(int)day];
}

-(NSString*)nowMonthDays:(NSDate*)parameterDate
{
    NSCalendar *myCal  = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned units = NS_CALENDAR_UNIT;
    NSDateComponents *comp1 = [myCal components:units fromDate:parameterDate];
    NSInteger year = [comp1 year];
    NSInteger month = [comp1 month];

    
    if(month==1||month==3||month==5||month==7||month==8||month==10||month==12)
    {
        return [NSString stringWithFormat:@"%d",31];
    }
    else if(month ==4||month==6||month==9||month==11)
    {
        return [NSString stringWithFormat:@"%d",30];
    }
    else if((year % 4  == 0 && year % 100 != 0 ) || year % 400 == 0)
    {
        return [NSString stringWithFormat:@"%d",29];
    }
    else
    {
        return [NSString stringWithFormat:@"%d",28];
    }
}



@end
