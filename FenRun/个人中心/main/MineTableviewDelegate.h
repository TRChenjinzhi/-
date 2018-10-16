//
//  MineTableviewDelegate.h
//  乐速益
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineModel.h"
#import "MineCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MineDelegateBlock)(NSInteger section,NSInteger index);

@interface MineTableviewDelegate : BaseTableviewDelegate

@property (nonatomic,strong)NSArray* dataSource;
@property (nonatomic,copy)MineDelegateBlock returnBlock;

@end

NS_ASSUME_NONNULL_END
