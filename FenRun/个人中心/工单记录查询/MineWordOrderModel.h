//
//  MineWordOrderModel.h
//  乐速益
//
//  Created by chenjinzhi on 2018/10/12.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineWordOrderModel : NSObject

@property (nonatomic,copy)NSString*     number;
@property (nonatomic,copy)NSString*     date;
@property (nonatomic,assign)MineWordOrderStateType     state; //处理状态
@property (nonatomic,assign)MineWordOrderActionType    type;//类型 例：调单手刷

@end

NS_ASSUME_NONNULL_END
