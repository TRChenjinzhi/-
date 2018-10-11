//
//  PayWithAliResultHelper.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/9/14.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "PayWithAliResultHelper.h"

@implementation PayWithAliResultHelper

static id _instance;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(void)initData{
    self.isOver = YES;
}

-(BOOL)dongSomeByAliResult:(NSDictionary*)result{
    
    if([result containsObjectForKey:@"resultStatus"]){
        NSString* status    = result[@"resultStatus"];
        if([status isEqualToString:@"9000"]){
            NSLog(@"订单支付成功");
            return YES;
        }
        else if([status isEqualToString:@"4000"]){
            NSLog(@"订单支付失败");
        }
        else if([status isEqualToString:@"5000"]){
            NSLog(@"重复请求");
        }
        else if([status isEqualToString:@"6001"]){
            NSLog(@"用户中途取消");
        }
        else if([status isEqualToString:@"6002"]){
            NSLog(@"网络连接出错");
        }
        else if([status isEqualToString:@"6004"]){
            NSLog(@"支付结果未知（可能已经支付成功，请查询商户订单中订单的支付状态）");
        }
    }
    
    self.isOver = NO;
    
    return NO;
}

@end
