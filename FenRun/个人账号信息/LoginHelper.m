//
//  LoginHelper.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/4.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "LoginHelper.h"

@implementation LoginHelper

static id _instance;

+(instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[LoginHelper alloc] init];
    });
    return _instance;
}

+(void)setInstance:(LoginHelper*)model{
    if(!_instance){
        [LoginHelper share];
    }
    _instance   = model;
}

-(BOOL)HaveIcon{
    if(self.user_pic.length <= 0){
        return NO;
    }
    return YES;
}
-(BOOL)Havename{
    if(self.user_name.length <= 0){
        return NO;
    }
    return YES;
}


+(BOOL)getUserInfo{
    NSDictionary* info  = [AppConfig getUserInfo];
    if(info == nil) return NO;
    [LoginHelper setInstance:[LoginHelper mj_objectWithKeyValues:info]];
    if([LoginHelper share].user_phone.length <= 0){
        return NO;
    }
    else{
        [LoginHelper setInstance:[LoginHelper mj_objectWithKeyValues:info]];
        return YES;
    }
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"realNamType" : @"card_ok",//前边的是你想用的key，后边的是返回的key
             @"totalIncome" : @"all_profit",
             @"IDNumber"    : @"personal_card",
             @"recommentCode" : @"improt_code",
             @"delegaterLocal": @"user_local",
             @"erweimaStr"  : @"personal_code",
             @"defaultAddress": @"user_address",
             @"ID"          : @"id",
             @"defaultCard" : @"bank"
             };
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"bank" : @"MineCardControlCellModel"};//前边，是属性数组的名字，后边就是类名
}

@end
