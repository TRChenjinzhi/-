//
//  MineAddCardVC.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/27.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "BaseViewController.h"
#import "CardDetailModel.h"
#import "MineCardControlCellModel.h"

typedef void(^MineAddCardVCReturnBlock)(CardDetailModel* model);

@interface MineAddOrEditCardVC : BaseViewController

@property (nonatomic,assign)CardAddOrEditType type;

@property (nonatomic,copy)MineAddCardVCReturnBlock  returnBlock;


@property (nonatomic,strong)MineCardControlCellModel*  model;

@end
