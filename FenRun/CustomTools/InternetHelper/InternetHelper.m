//
//  InternetHelper.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/3.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "InternetHelper.h"

@implementation InternetHelper

+(void)showMachineStatus:(NSDictionary*)dic{
    if([dic containsObjectForKey:@"content"]){
        NSNumber* status    = dic[@"content"];
        switch ([status integerValue]) {
            case -1:
                [QMUITips showInfo:@"您没有这个机具"];
                break;
            case 0:
                [QMUITips showInfo:@"机具未出库"];
                break;
            case 1:
                [QMUITips showInfo:@"机具已出库"];
                break;
            case 2:
                [QMUITips showInfo:@"机具已绑定"];
                break;
            case 3:
                [QMUITips showInfo:@"机具已激活"];
                break;
            case 4:
                [QMUITips showInfo:@"机具已返现"];
                break;
            case 5:
                [QMUITips showInfo:@"机具不返现"];
                break;
            case 6:
                [QMUITips showInfo:@"机具已作废"];
                break;
            case 7:
                [QMUITips showInfo:@"机具解绑正在处理"];
                break;
                
            default:
                break;
        }
    }
}

+(NSMutableURLRequest*)getRequestPostByDic:(NSMutableDictionary*)dic andUrl:(NSURL*)url{
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";

    NSString* parameta  = [InternetHelper getBaseParameterByDic:dic];
    parameta            = [parameta stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%<>[\\]^`{|}\"]+"].invertedSet];
    request.HTTPBody = [parameta dataUsingEncoding:NSUTF8StringEncoding];
//    request.HTTPBody = [parameta stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"#%<>[\\]^`{|}\"]+"].invertedSet];
    
//    NSData *data =[parameta dataUsingEncoding:NSUTF8StringEncoding];
//    NSString * str  =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return request;
}

+(NSInteger)getCodeInteger:(NSDictionary*)dic{
    if([dic containsObjectForKey:@"code"]){
        NSNumber* code  = dic[@"code"];
        return [code integerValue];
    }
    return 0;
}

+(NSString*)getBaseParameterByDic:(NSDictionary*)dic{
    //存储设备唯一标识
    static NSString* weiyi  = nil;
    
    if(weiyi == nil){
        weiyi = (NSString*)[MyKeychain queryDataWithService:MyKeychain_server];
        //        NSString* str_IDFA = IDFA;
        if(weiyi == nil || weiyi.length <= 0){
            NSString *uuid = [[NSUUID UUID] UUIDString];
            [MyKeychain addData:[NSString stringWithFormat:@"%@",uuid] forService:MyKeychain_server];
            NSLog(@"uuid:%@",(NSString*)[MyKeychain queryDataWithService:MyKeychain_server] );
            weiyi           = uuid;
        }
    }
    
    NSLog(@"uuid:%@",weiyi);
    
    NSMutableDictionary* tmp    = [NSMutableDictionary dictionaryWithDictionary:dic];
    [tmp setValue:[NSNumber numberWithInteger:1] forKey:@"ClientType"];//1:ios 0:android
    if(![dic containsObjectForKey:@"phone_code"]){
        [tmp setValue:weiyi forKey:@"phone_code"];//uuid
    }
    NSString* tmpStr    = [NSString stringWithFormat:@"jsonData=%@",[InternetHelper dictionaryToJson:tmp]];
//    tmpStr              = [tmpStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    return  tmpStr;
}

//字典转字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+(void)getIdentifyCodeByPhoneNumber:(NSString *)phoneNumber andSucess:(void(^)(void))sucess andFailed:(void(^)(void))failed{
    // 1.创建一个网络路径
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",InternetYuMing,Message]];
    //2.封装参数
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:phoneNumber forKey:@"user_phone"];
    
    NSMutableURLRequest* request= [InternetHelper getRequestPostByDic:dict andUrl:url];
    // 3.获得会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 4.根据会话对象，创建一个Task任务
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(error){
                NSLog(@"验证码获取失败");
                [QMUITips showError: @"验证码获取失败"];
                failed();
                return ;
            }
            
            NSLog(@"验证码取到数据");
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
            if([InternetHelper getCodeInteger:dict] == 200){
                sucess();
            }
            else{
                if([dict containsObjectForKey:@"msg"]){
                        [QMUITips showError: dict[@"msg"]];
                }
                else{
                    [QMUITips showError: @"验证码获取失败"];
                }
                failed();
            }
        });
    }];
    //5.最后一步，执行任务，(resume也是继续执行)。
    [sessionDataTask resume];
}

@end
