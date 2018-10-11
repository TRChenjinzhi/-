//
//  TimeHelper.h
//  新闻
//
//  Created by chenjinzhi on 2018/1/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeHelper : NSObject
+(instancetype)share;

-(NSString*)GetDateFromString_yyMMDD_HHMMSS:(NSTimeInterval)timeSecond;
-(NSString*)GetDateFromString_yyMMDD_HHMM:(NSTimeInterval)timeSecond;
-(NSString*)GetDateFromString_yyMMDD:(NSTimeInterval)timeSecond;
-(NSString*)GetDateFromString_MMDD:(NSTimeInterval)timeSecond;

//年
-(NSInteger)GetYear:(NSDate*)date;
//月
-(NSInteger)GetMonth:(NSDate*)date;
//日
-(NSInteger)GetDay:(NSDate*)date;
//hour
-(NSInteger)GetHour:(NSDate*)date;
//分
-(NSInteger)GetMin:(NSDate*)date;

-(NSNumber *)getCurrentTime_number;
-(NSString*)getCurrentTime_seconds;
-(NSString*)getCurrentTime_YYYYMMDD;
-(NSString*)getCurrentTime_YYYYMMDDHHSS;
-(NSString*)getCurrentTime_YYYYMMDDHHMMSS;
-(BOOL)compareTimes_ori_time:(NSNumber*)oriTime dest_time:(NSNumber*)destTime time:(NSInteger)seconds;
/*
 *比较2个时间的差 结果返回天数
 */
-(NSInteger)compareTimes_ori_time_YYMMDD:(NSString*)oriTime dest_time:(NSString*)destTime;
-(BOOL)compareTimes_ori_time:(NSString*)oriTime dest_time:(NSString*)destTime;

//日期转时间戳
-(NSTimeInterval)dateChangeToTimeSecond:(NSString*)time_date;

//日期转日期
-(NSString*)dataChangeToYYMMDD:(NSString*)time_date;


@end
