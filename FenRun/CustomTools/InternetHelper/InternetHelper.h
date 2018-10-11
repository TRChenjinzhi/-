//
//  InternetHelper.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/3.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//
typedef enum : NSInteger {
    LoginTypePassword = 0, //手机号码 密码 登录
    LoginTypeIdentifyCode //手机号码 验证码 登录
} LoginType;

#import <Foundation/Foundation.h>

@interface InternetHelper : NSObject


/**
检查版本更新
 */
+(void)getVersionSucess:(void(^)(NSDictionary* dic))sucess andFailed:(void(^)(void))failed;

/**
 获取 code 码
 */
+(NSInteger)getCodeInteger:(NSDictionary*)dic;

/**
 获取验证码

 @param phoneNumber 电话号码
 */
+(void)getIdentifyCodeByPhoneNumber:(NSString *)phoneNumber andSucess:(void(^)(void))sucess andFailed:(void(^)(void))failed;


@end
