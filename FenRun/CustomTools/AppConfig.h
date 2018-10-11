//
//  AppConfig.h
//  新闻
//
//  Created by 范英强 on 16/9/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfig : NSObject

+ (instancetype)sharedInstance;

+(void)saveUserInfo:(LoginHelper*)model;
+(NSDictionary*)getUserInfo;

/**
 是否加载过引导页
 */
+(void)saveBooyPageIsShow:(BOOL)isShow;
+(BOOL)getBooyPageIsShow;

/**
 重置密码 倒计时 时间点
 */
+(void)saveLoginModifByTimeByName:(NSString*)name;
+(NSString*)getLoginModifByTimeByName:(NSString*)name;

/**
 授权书
 */
+(void)saveCertificate:(NSDictionary*)dic;
+(NSDictionary*)getCertificate;

@end
