//
//  LoginHelper.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/4.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginHelper : NSObject

+(void)setInstance:(LoginHelper*)model;

@property (nonatomic,assign)BOOL                            logined;


+(instancetype)share;
+(BOOL)getUserInfo;

-(BOOL)HaveIcon;
-(BOOL)Havename;


@property (nonatomic,assign)NSInteger                       ID;
@property (nonatomic,copy)NSString*                         user_phone;
/**
 登录密码
 */
@property (nonatomic,copy)NSString*                         loginPasswrod;

@property (nonatomic,copy)NSString*                         user_name;


@property (nonatomic,copy)NSString*                         user_pic;

/**
 0位女 1位男
 */
@property (nonatomic,assign)NSInteger                       sex;

@property (nonatomic,copy)NSString*                         address;


@end
