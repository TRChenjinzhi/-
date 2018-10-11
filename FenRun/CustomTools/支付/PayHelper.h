//
//  PayHelper.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/9/11.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MOBFoundation/MOBFoundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import <MOBPaySDK/MOBPay.h>
#import "WXApi.h"

typedef void(^PaySucessBlock)(void);
typedef void(^PayFailedBlock)(void);

@interface PayHelper : NSObject<WXApiDelegate>

@property (nonatomic, weak) id<WXApiDelegate> delegate;
@property (nonatomic, copy) PaySucessBlock sucessBlock;
@property (nonatomic, copy) PayFailedBlock failedBlock;

+ (instancetype)sharedInstance;
+(void)payWithAliByString:(NSString*)aliStr andSucess:(void(^)(void))sucess andFailed:(void(^)(void))failed;

-(void)payWithWechatByDic:(NSDictionary*)dic;

@end
