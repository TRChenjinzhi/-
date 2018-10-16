//
//  MineCardControlCellModel.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/13.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MineCardControlCellModel.h"

@implementation MineCardControlCellModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",//前边的是你想用的key，后边的是返回的key
             @"userBankNumber"  :@"user_bank",
             @"isDefault"       :@"status"
             };
}

- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property{
    if ([property.name isEqualToString:@"status"]) {
        if (oldValue) {
            // 格式化时间
            if([oldValue integerValue] == 1){
                return [NSNumber numberWithBool:YES];
            }
            else{
                return [NSNumber numberWithBool:NO];
            }
        }
    }
    else {
        return oldValue;
    }
    return oldValue;
}

+(MineCardControlCellModel*)createModelByIndex:(NSInteger)index{
    
    MineCardControlCellModel* model = [MineCardControlCellModel new];
    model.ID                        = index;
    model.bank_name                 = (index/2 == 1) ? @"招商银行" : @"农业银行";
    model.user_name                 = [NSString stringWithFormat:@"测试姓名%ld",index];
    model.bank_phone                = @"15527747037";
    model.bank_code                 = @"123456798123";
    model.userBankNumber            = @"899764578949";
    model.bank_open                 = [NSString stringWithFormat:@"%@支行",model.bank_name];
    model.isDefault                 = (index==0) ? YES : NO;
    model.add_time                  = @"2018/10/13 16:21";
    
    return model;
}

@end
