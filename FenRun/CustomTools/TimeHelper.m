//
//  TimeHelper.m
//  新闻
//
//  Created by chenjinzhi on 2018/1/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "TimeHelper.h"

@implementation TimeHelper
static id _instance;
+(instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}
//string转换时间
-(NSString*)GetDateFromString_yyMMDD_HHMMSS:(NSTimeInterval)timeSecond{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSecond];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}

-(NSString*)GetDateFromString_YYYYMMDD:(NSTimeInterval)timeSecond{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSecond];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

-(NSString*)GetDateFromString_yyMMDD_HHMM:(NSTimeInterval)timeSecond{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSecond];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [formatter stringFromDate:date];
}

-(NSString*)GetDateFromString_yyMMDD:(NSTimeInterval)timeSecond{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSecond];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:date];
}

-(NSString*)GetDateFromString_MMDD:(NSTimeInterval)timeSecond{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSecond];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd"];
    NSString* str = [formatter stringFromDate:date];
    return str;
}

//获取当地时间
- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//年
-(NSInteger)GetYear:(NSDate*)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:date];
    return [components year];
}
//月
-(NSInteger)GetMonth:(NSDate*)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitMonth fromDate:date];
    return [components month];
}
//日
-(NSInteger)GetDay:(NSDate*)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:date];
    return [components day];
}
//hour
-(NSInteger)GetHour:(NSDate*)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour fromDate:date];
    return [components hour];
}
//分
-(NSInteger)GetMin:(NSDate*)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitMinute fromDate:date];
    return [components minute];
}

-(NSNumber*)getCurrentTime_number{
    NSDate* date_now = [NSDate date];
    NSTimeInterval second = [date_now timeIntervalSince1970];
    return [NSNumber numberWithDouble:second];
}

-(NSString*)getCurrentTime_seconds{
    NSDate* date_now = [NSDate date];
    NSTimeInterval second = [date_now timeIntervalSince1970];
    return [NSString stringWithFormat:@"%f",second];
}

-(NSString*)getCurrentTime_YYYYMMDD{
    NSDate* date_now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    return [formatter stringFromDate:date_now];
}

-(NSString*)getCurrentTime_YYYYMMDDHHSS{
    NSDate* date_now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:SS";
    return [formatter stringFromDate:date_now];
}
-(NSString*)getCurrentTime_YYYYMMDDHHMMSS{
    NSDate* date_now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    return [formatter stringFromDate:date_now];
}

//比较时间差
-(BOOL)compareTimes_ori_time:(NSNumber*)oriTime dest_time:(NSNumber*)destTime time:(NSInteger)seconds{
    NSInteger ori = [oriTime integerValue];
    NSInteger dest = [destTime integerValue];
    NSInteger shijiancha = dest - ori;
    if(shijiancha >= seconds){
        return YES;
    }else{
        return NO;
    }
}

-(NSInteger)compareTimes_ori_time_YYMMDD:(NSString*)oriTime dest_time:(NSString*)destTime{
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd"];//设置时间格式//很重要
    NSDate *oriDate=[date dateFromString:oriTime];
    
    NSDateFormatter *date_tmp=[[NSDateFormatter alloc] init];
    [date_tmp setDateFormat:@"yyyy-MM-dd"];//设置时间格式//很重要
    NSDate *destDate=[date_tmp dateFromString:destTime];
    
    NSTimeInterval ori_timeSecond   = [oriDate timeIntervalSince1970]*1;
    NSTimeInterval dest_timeSecond  = [destDate timeIntervalSince1970]*1;
    
    NSTimeInterval cha  = dest_timeSecond - ori_timeSecond;
    return cha/86400;
}

-(BOOL)compareTimes_ori_time:(NSString*)oriTime dest_time:(NSString*)destTime{
    NSTimeInterval oriTimeSecond = [[TimeHelper share] dateChangeToTimeSecond:oriTime];
    NSTimeInterval destTimeSecond = [[TimeHelper share] dateChangeToTimeSecond:oriTime];
    if(oriTimeSecond >= destTimeSecond){
        return YES;
    }
    else{
        return NO;
    }
}

//日期转时间戳
-(NSTimeInterval)dateChangeToTimeSecond:(NSString*)time_date{
    // 1.创建一个时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
//    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8*60*60]];//东8区
    
    // 3.利用时间格式化对象让字符串转换成时间 (自动转换0时区/东加西减)
    NSDate *date = [formatter dateFromString:time_date];
    NSTimeInterval second = [date timeIntervalSince1970];
//    second += 8*60*60;//东8区
    return second;
}


-(NSString*)dataChangeToYYMMDD:(NSString*)time_date{
    // 1.创建一个时间格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";

    NSDate* date = [formatter dateFromString:time_date];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString* time = [formatter stringFromDate:date];
    return time;
}

@end
