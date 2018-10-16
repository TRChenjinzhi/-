//
//  CardDetailModel.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/13.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardDetailModel : NSObject

/**
 开户行
 */
@property (nonatomic,copy)NSString*     bank_name;
/**
 开户名
 */
@property (nonatomic,copy)NSString*     user_name;
/**
分行联行号
 */
@property (nonatomic,copy)NSString*     bank_code;
/**
卡号
 */
@property (nonatomic,copy)NSString*     user_bank;

@end
