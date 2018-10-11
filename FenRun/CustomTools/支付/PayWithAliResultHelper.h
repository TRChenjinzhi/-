//
//  PayWithAliResultHelper.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/9/14.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayWithAliResultHelper : NSObject

/**
 因为有app支付，回调以appDelegate结果为主。网页支付 回调以方法回调结果为主，所以这里做一个开关，只允许执行一次结果处理
 */
@property (nonatomic,assign)BOOL isOver;

+ (instancetype)sharedInstance;

-(void)initData;
-(BOOL)dongSomeByAliResult:(NSDictionary*)result;

@end
