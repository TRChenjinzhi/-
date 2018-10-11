//
//  LoginRule.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/6.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "LoginRule.h"

@implementation LoginRule

+(BOOL)passwordIsMatch:(NSString*)password{
    
    //由 数字和密码组成，长度 6～12 位
    NSString *phoneRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMacth = [phoneTest evaluateWithObject:password];

    if(isMacth){
        return YES;
    }
    else{
        [QMUITips showError:@"密码由数组和字母组成,长度6~18位"];
        return NO;
    }
}

+(BOOL)checkPhoneNumber:(NSString*)phoneNumber{
    NSString* mobileNum = phoneNumber;
    if (mobileNum.length == 0)
    {
        [QMUITips showInfo:@"手机号码不能为空"];
        return NO;
    }
    if (mobileNum.length != 11)
    {
        [QMUITips showInfo:@"手机号码格式错误"];
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    /**
     25     * 大陆地区固话及小灵通
     26     * 区号：010,020,021,022,023,024,025,027,028,029
     27     * 号码：七位或八位
     28     */
    //  NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        [QMUITips showInfo:@"手机号码格式错误"];
        return NO;
    }
    return YES;
}

+(BOOL)checkNumber:(NSString *)str{
    //是否为数字
    NSString *phoneRegex = @"^[0-9]{1,50}+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMacth = [phoneTest evaluateWithObject:str];
    
    if(isMacth){
        return YES;
    }
    else{
        return NO;
    }
}

+(BOOL)checkMachineNumber:(NSString *)str{
    //是否为设备型号
    if(str.length <= 0){
        [QMUITips showInfo:@"机具编号不能为空"];
        return NO;
    }
    NSString *phoneRegex = @"^[0-9a-zA-Z]{1,50}+$";
    if(str.length < MachineNumberMintLength){
        [QMUITips showInfo:@"机具编号格式不正确"];
        return NO;
    }
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isMacth = [phoneTest evaluateWithObject:str];
    
    if(isMacth){
        return YES;
    }
    else{
        [QMUITips showInfo:@"机具编号格式不正确"];
        return NO;
        
    }
}

+(BOOL)checkName:(NSString *)str{
    if(str.length <= 0){
        [QMUITips showInfo:@"不能为空"];
        return NO;
    }
    BOOL isMatch    = YES;
    for (int i=0; i<str.length; i++) {
        NSRange range =NSMakeRange(i, 1);
        NSString * strFromSubStr=[str substringWithRange:range];
        const char *cStringFromstr = [strFromSubStr UTF8String];
        if (strlen(cStringFromstr)==3) {
            //汉字
        } else if (strlen(cStringFromstr)==1) {
            //字母
            isMatch = NO;
            [QMUITips showInfo:@"只能是汉字"];
        }
        else{
            isMatch = NO;
            [QMUITips showInfo:@"只能是汉字"];
        }
    }
    
    return isMatch;
}

+(NSString*)getCardString:(NSString *)cardPhonenumber{
    //首先卡号至少要大于8位
    if(cardPhonenumber.length < 8){
        [QMUITips showInfo:@"卡号格式有误"];
        return @"*********";
    }
    else{
        NSString* tmp = @"";
        for (int i=0; i<cardPhonenumber.length-7; i++) {
            tmp = [tmp stringByAppendingString:@"*"];
        }
        return [cardPhonenumber stringByReplacingCharactersInRange:NSMakeRange(3, cardPhonenumber.length-7) withString:tmp];
    }
}

+(NSString*)getCardStringByCardList:(NSString*)cardnumber{
    //首先卡号至少要大于8位
    if(cardnumber.length < 8){
        [QMUITips showInfo:@"卡号格式有误"];
        return @"*********";
    }
    else{
        NSString* tmp = @"";
        for (int i=0; i<cardnumber.length-7; i++) {
            if(i % 4 == 0){
                tmp = [tmp stringByAppendingString:@" *"];
            }
            else{
                tmp = [tmp stringByAppendingString:@"*"];
            }
            
            if(i == cardnumber.length -7 -1){
                tmp = [tmp stringByAppendingString:@" "];
            }
        }
        return [cardnumber stringByReplacingCharactersInRange:NSMakeRange(3, cardnumber.length-7) withString:tmp];
    }
}

+(NSString*)getPhoneNumberString:(NSString *)Phonenumber{
    //首先手机号至少要大于8位
    if(Phonenumber.length < 11){
        [QMUITips showInfo:@"手机号码有误"];
        return @"*********";
    }
    else{
        NSString* tmp = @"";
        for (int i=0; i<Phonenumber.length-7; i++) {
            tmp = [tmp stringByAppendingString:@"*"];
        }
        
        return [Phonenumber stringByReplacingCharactersInRange:NSMakeRange(3, Phonenumber.length-7) withString:tmp];
    }
}

+(BOOL)checkIDnumber:(NSString *)IDCardNumber{
    if(IDCardNumber.length <= 0){
        [QMUITips showInfo:@"身份证号码不能为空"];
        return NO;
    }
    
    IDCardNumber = [IDCardNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([IDCardNumber length] != 18)
    {
        [QMUITips showInfo:@"身份证号码格式不正确"];
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:IDCardNumber])
    {
        return NO;
    }
    int summary = ([IDCardNumber substringWithRange:NSMakeRange(0,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([IDCardNumber substringWithRange:NSMakeRange(1,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([IDCardNumber substringWithRange:NSMakeRange(2,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([IDCardNumber substringWithRange:NSMakeRange(3,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([IDCardNumber substringWithRange:NSMakeRange(4,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([IDCardNumber substringWithRange:NSMakeRange(5,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([IDCardNumber substringWithRange:NSMakeRange(6,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [IDCardNumber substringWithRange:NSMakeRange(7,1)].intValue *1 + [IDCardNumber substringWithRange:NSMakeRange(8,1)].intValue *6
    + [IDCardNumber substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    BOOL isMatch = [checkBit isEqualToString:[[IDCardNumber substringWithRange:NSMakeRange(17,1)] uppercaseString]];
    
    if(isMatch){
        
    }
    else{
        [QMUITips showInfo:@"身份证号码格式不正确"];
    }
    return isMatch;
}

+(NSInteger)checkStrIsNumberOrName:(NSString*)str{
    BOOL isMatch    = YES;
    for (int i=0; i<str.length; i++) {
        NSRange range =NSMakeRange(i, 1);
        NSString * strFromSubStr=[str substringWithRange:range];
        const char *cStringFromstr = [strFromSubStr UTF8String];
        if (strlen(cStringFromstr)==3) {
            //汉字
        } else if (strlen(cStringFromstr)==1) {
            //字母
            isMatch = NO;
//            [QMUITips showError:@"姓名只能是汉字"];
        }
        else{
            isMatch = NO;
//            [QMUITips showError:@"姓名只能是汉字"];
        }
    }
    
    if(isMatch == YES){
        return 1;
    }
    else{
        //是否为数字
        NSString *phoneRegex = @"^[0-9]{1,11}+$";
        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
        BOOL isMacth = [phoneTest evaluateWithObject:str];
        
        if(isMacth){
            return 0;
        }
        else{
            return 2;
        }
    }
}


+(BOOL)checkCardNumber:(NSString*)cardNumber{
    if(cardNumber.length == 0){
        [QMUITips showInfo:@"银行卡号不能为空"];
        return NO;
    }
    
    BOOL isNumber   = [LoginRule checkNumber:cardNumber];
    if(isNumber){
        if(16 <= cardNumber.length && cardNumber.length <= 19){
            return YES;
        }
        else{
            [QMUITips showInfo:@"银行卡号长度不对"];
            return NO;
        }
    }
    else{
        [QMUITips showInfo:@"银行卡号只能是数字"];
        return NO;
    }
}


/**
 判断验证码
 
 @param identifyNumber identifyNumber description
 @return return value description
 */
+(BOOL)checkIdentifyNumber:(NSString*)identifyNumber{
    
    if(identifyNumber.length == 0){
        [QMUITips showInfo:@"验证码不能为空"];
        return NO;
    }
    
    if([LoginRule checkNumber:identifyNumber]){
        if(identifyNumber.length == 6){
            return YES;
        }
        else{
            [QMUITips showInfo:@"验证码位数为6"];
            return NO;
        }
    }
    else{
        return NO;
    }
}


/**
 判断推荐码
 
 @param recommendNumber identifyNumber description
 @return return value description
 */
+(BOOL)checkRecommendNumber:(NSString*)recommendNumber{
    if(recommendNumber.length == 0){
        [QMUITips showInfo:@"推荐码不能为空"];
        return NO;
    }
    else{
        if(recommendNumber.length == 10){
            return YES;
        }
        [QMUITips showInfo:@"推荐码长度为10"];
        return NO;
    }
}



/**
 检查身份证信息 是否可用
 */
+(BOOL)checkIDCardIsUserful:(NSDictionary*)frontDic andBack:(NSDictionary*)backDic{
    
//    //test
//    NSArray* borthArray = @[@"20000911",@"20000910",@"20000909",@"19530910",@"19530909"];
//    for(int i=0 ;i<borthArray.count ;i++){
//        NSMutableDictionary* frontDic    = [NSMutableDictionary dictionary];
//        NSMutableDictionary* backDic     = [NSMutableDictionary dictionary];
//        [frontDic setValue:borthArray[i] forKey:@"出生"];
//        [backDic setValue:@"20550602" forKey:@"失效日期"];
//        [LoginRule checkIDCardIsUserful:frontDic andBack:backDic];
//    }
    
    BOOL ageIsOk    = NO;
    BOOL enableIsOk = NO;
    
    //年龄要在 18～60 区间
    NSInteger yearBorth    = [[LoginRule getYear:frontDic[@"出生"]] integerValue];
    NSInteger monthBorth   = [[LoginRule getMonth:frontDic[@"出生"]] integerValue];
    NSInteger dayBorth   = [[LoginRule getDay:frontDic[@"出生"]] integerValue];
    
    NSInteger yearNow      = [[TimeHelper share] GetYear:[NSDate date]];
    NSInteger monthNow     = [[TimeHelper share] GetMonth:[NSDate date]];
    NSInteger dayNow     = [[TimeHelper share] GetDay:[NSDate date]];
    
    
    NSInteger year         = yearNow - yearBorth;
    NSInteger month        = monthNow - monthBorth;
    if(18 < year && year < 65){
        //满足条件
        ageIsOk = YES;
    }
    else if(year == 18 || year == 65){
        if(month >= 0){
            if(month > 0){
                if(year != 65){
                    ageIsOk = YES;
                }
                else{
                    ageIsOk = NO;
                }
            }
            else{
                //例如：2000-09-11。2018-09-10
                NSInteger dayCha    = dayNow - dayBorth;
                if(dayCha > 0){
                    //满足条件
                    if(year != 65){
                        ageIsOk = YES;
                    }
                    else{
                        ageIsOk = NO;
                    }
                }
                else if(dayCha == 0){
                    ageIsOk = YES;
                }
                else{
                    //差一点满足条件
                    ageIsOk = NO;
                }
            }
        }
        else{
            //差一点满足条件
            ageIsOk = NO;
        }
    }
    else{
        //不满足条件
        ageIsOk = NO;
    }
    
    
    //有效期时长：3个月以上 @"失效日期"
    NSInteger unableYear    = [[LoginRule getYear:backDic[@"失效日期"]] integerValue];
    NSInteger unableMonth   = [[LoginRule getMonth:backDic[@"失效日期"]] integerValue];

    if(unableYear - yearNow > 0){
        NSInteger unableMonth_tmp   = (unableYear-yearNow)*12 + unableMonth;
        if(unableMonth_tmp - monthNow >= 3){
            enableIsOk = YES;
        }
        else{
            enableIsOk = NO;
        }
    }
    else if(unableYear - yearNow == 0){
        if(unableMonth - monthNow >= 3){
            //满足条件
            enableIsOk  = YES;
        }
        else{
            //不满足条件
            enableIsOk  = NO;
        }
    }
    else{
        //不满足条件
        enableIsOk  = NO;
    }
    
    if(enableIsOk && ageIsOk){
        return YES;
    }
    else{
        if(!ageIsOk){
            [QMUITips showInfo:@"实名认证年龄 18～60"];
//            NSLog(@"18~60:%@",frontDic[@"出生"]);
            return NO;
        }
        else if(!enableIsOk){
            [QMUITips showInfo:@"身份证有效期时长3个月以上"];
//            NSLog(@"3个月:%@",backDic[@"失效日期"]);
            return NO;
        }
        else{
            return YES;
        }
        
    }
}

+(NSString*)getYear:(NSString*)str{
    //    NSString* str = dic[@"出生"];
    NSString* tmp   = [str substringWithRange:NSMakeRange(0, 4)];
    NSInteger year  = [tmp integerValue];
    return [NSString stringWithFormat:@"%ld",year];
}

+(NSString*)getMonth:(NSString*)str{
    //    NSString* str = dic[@"出生"];
    NSString* tmp   = [str substringWithRange:NSMakeRange(4, 2)];
    NSInteger month = [tmp integerValue];
    return [NSString stringWithFormat:@"%ld",month];
}
+(NSString*)getDay:(NSString*)str{
    //    NSString* str = dic[@"出生"];
    NSString* tmp   = [str substringWithRange:NSMakeRange(6, 2)];
    NSInteger day   = [tmp integerValue];
    return [NSString stringWithFormat:@"%ld",day];
}

@end
