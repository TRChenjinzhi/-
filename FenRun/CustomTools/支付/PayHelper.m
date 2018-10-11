//
//  PayHelper.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/9/11.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "PayHelper.h"

@implementation PayHelper

static id _instance;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+(void)payWithAliByString:(NSString *)aliStr andSucess:(void(^)(void))sucess andFailed:(void(^)(void))failed{
    [[AlipaySDK defaultService] payOrder:aliStr fromScheme:@"ali" callback:^(NSDictionary *resultDic) {
        NSLog(@"PayHelper resultDic = %@",resultDic);
        if([[PayWithAliResultHelper sharedInstance] dongSomeByAliResult:resultDic]){
            sucess();
        }
        else{
            failed();
        }
    }];
}

-(void)payWithWechatByDic:(NSDictionary*)dic{
    
    self.delegate       = self;
    
    PayReq *request     = [[PayReq alloc] init];
    request.partnerId   = dic[@"partnerid"];
    request.prepayId    = dic[@"prepayid"];
    request.package     = dic[@"package"];
    request.nonceStr    = dic[@"noncestr"];
    NSNumber* number    = dic[@"timestamp"];
    request.timeStamp   = [number unsignedIntValue];
    request.sign        = dic[@"sign"];
    [WXApi sendReq:request];
}


#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
//        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
//                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                if(self.sucessBlock){
                    self.sucessBlock();
                }
                break;
                
            default:
//                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                if(self.failedBlock){
                    self.failedBlock();
                }
                break;
        }
    }else {
        
    }
}

- (void)onReq:(BaseReq *)req {
    NSLog(@"onReq:(BaseReq *)req ");
}

@end
