//
//  MineCardControlCellModel.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/13.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineCardControlCellModel : NSObject

/**
 银行卡id
 */
@property (nonatomic,assign)NSInteger       ID;
@property (nonatomic,copy)NSString*         bank_name;
/**
 用户id
 */
@property (nonatomic,copy)NSString*         user_id;
/**
 持卡人姓名
 */
@property (nonatomic,copy)NSString*         user_name;
/**
 预留手机号
 */
@property (nonatomic,copy)NSString*         bank_phone;
/**
 分行行号
 */
@property (nonatomic,copy)NSString*         bank_code;
/**
 用户银行卡号
 */
@property (nonatomic,copy)NSString*         userBankNumber;
/**
 开户银行
 */
@property (nonatomic,copy)NSString*         bank_open;
/**
 1为默认银行卡
 */
@property (nonatomic,assign)BOOL            isDefault;
@property (nonatomic,copy)NSString*         add_time;

+(MineCardControlCellModel*)createModelByIndex:(NSInteger)index;

@end
