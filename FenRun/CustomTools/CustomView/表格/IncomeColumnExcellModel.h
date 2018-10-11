//
//  IncomeColumnExcellModel.h
//  FenRun
//
//  Created by chenjinzhi on 2018/9/26.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IncomeColumnExcellModel : NSObject

/**
 直营收益
 */
@property (nonatomic,assign)CGFloat direct_money;
/**
 代理收益
 */
@property (nonatomic,assign)CGFloat agent_money;
/**
 机具返现收益
 */
@property (nonatomic,assign)CGFloat pos_money;
/**
 推广收益
 */
@property (nonatomic,assign)CGFloat return_money;
@property (nonatomic,assign)NSInteger day;

@end

NS_ASSUME_NONNULL_END
