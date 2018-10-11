//
//  LoginRule.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/6.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginRule : NSObject
/**
 密码只能是数组和字母组成，大于8位小于12位

 @param password 密码字符串
 @return yes:满足调教 NO：不满足条件
 */
+(BOOL)passwordIsMatch:(NSString*)password;

/**
检查手机号码格式
 
 @param phoneNumber phoneNumber description
 @return return value description
 */
+(BOOL)checkPhoneNumber:(NSString*)phoneNumber;


/**
 检查是否是数字

 @param str 检查的内容
 @return return value description
 */
+(BOOL)checkNumber:(NSString*)str;

/**
 检查设备型号

 @param str 检查的内容
 @return return value description
 */
+(BOOL)checkMachineNumber:(NSString*)str;

/**
 检查是否是纯汉字

 @param str 检查的内容
 @return return value description
 */
+(BOOL)checkName:(NSString*)str;

/**
 将卡号 转变为 6222********444

 @param cardPhonenumber 卡号
 @return 隐藏卡号
 */
+(NSString*)getCardString:(NSString*)cardPhonenumber;

/**
 将卡号 转变为 6222 **** **** 444
 
 @param cardnumber 卡号
 @return 隐藏卡号
 */
+(NSString*)getCardStringByCardList:(NSString*)cardnumber;

/**
  将手机号 转变为 155****2774
 @return return 隐藏手机号
 */
+(NSString*)getPhoneNumberString:(NSString *)Phonenumber;

/**
 检查身份证号码格式

 @param IDCardNumber IDStr description
 @return return value description
 */
+(BOOL)checkIDnumber:(NSString*)IDCardNumber;

/**
 判断字符串 是 纯数字 还是纯汉字

 @param str str description
 @return return 0:数字 1:汉字 2:型号
 */
+(NSInteger)checkStrIsNumberOrName:(NSString*)str;

/**
 判断银行卡号码 长度是否合法 （16-19）

 @param cardNumber cardNumber description
 @return return value description 
 */
+(BOOL)checkCardNumber:(NSString*)cardNumber;


/**
判断验证码

 @param identifyNumber identifyNumber description
 @return return value description
 */
+(BOOL)checkIdentifyNumber:(NSString*)identifyNumber;


/**
 判断推荐码
 
 @param recommendNumber identifyNumber description
 @return return value description
 */
+(BOOL)checkRecommendNumber:(NSString*)recommendNumber;

/**
 检查身份证信息 是否可用

 @param frontDic 身份证正面信息 backDic 身份证背面信息
 @return yes:有用 NO：没用
 */
+(BOOL)checkIDCardIsUserful:(NSDictionary*)frontDic andBack:(NSDictionary*)backDic;


@end
