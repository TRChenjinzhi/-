//
//  AppConfig.m
//  新闻
//
//  Created by 范英强 on 16/9/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "AppConfig.h"

#define UserInfo    @"UserInfo"
#define Bootpage    @"Bootpage"
#define Certificate @"Certificate"
#define LoginModifyTime @"LoginModifyTime"

@implementation AppConfig

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

#pragma mark -------保存用户信息------------
+(void)saveUserInfo:(LoginHelper*)model{
    NSDictionary* dic   = model.mj_keyValues;
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:UserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSDictionary*)getUserInfo{
    NSDictionary *info = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:UserInfo];
    return info;
}

#pragma mark -------重置密码 倒计时时间点------------
+(void)saveLoginModifByTimeByName:(NSString*)name{
    NSString* nowTime   = [[TimeHelper share] getCurrentTime_seconds];
    [[NSUserDefaults standardUserDefaults] setObject:nowTime forKey:[NSString stringWithFormat:@"%@%@",LoginModifyTime,name]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*)getLoginModifByTimeByName:(NSString*)name{
    NSString *timeStr = (NSString*)[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%@",LoginModifyTime,name]];
    return timeStr;
}

#pragma mark -------引导页信息------------
+(void)saveBooyPageIsShow:(BOOL)isShow{
    [[NSUserDefaults standardUserDefaults] setBool:isShow forKey:Bootpage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(BOOL)getBooyPageIsShow{
    NSNumber* boolNumber = (NSNumber*)[[NSUserDefaults standardUserDefaults] objectForKey:Bootpage];
    return [boolNumber boolValue];
}


#pragma mark -------授权书------------
+(void)saveCertificate:(NSDictionary*)dic{
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:[NSString stringWithFormat:@"%@-%ld",Certificate,(long)[LoginHelper share].ID]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSDictionary*)getCertificate{
    NSDictionary* dic   = (NSDictionary*)[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@-%ld",Certificate,(long)[LoginHelper share].ID]];
    return dic;
}

@end
