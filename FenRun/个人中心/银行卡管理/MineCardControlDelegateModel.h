//
//  MineCardControlDelegateModel.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/27.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineCardTvcCell.h"

typedef void(^MineCardControlCellBlock)(MineCardControlCellModel* model);

@interface MineCardControlDelegateModel : BaseTableviewDelegate

@property (nonatomic,strong)NSArray*    dataSource;
@property (nonatomic,copy)MineCardControlCellBlock cellClickBlock;

@end
