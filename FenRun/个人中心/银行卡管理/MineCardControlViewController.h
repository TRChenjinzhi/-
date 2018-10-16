//
//  MineCardControlViewController.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/13.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "BaseViewController.h"
#import "MineCardControlCellModel.h"

typedef void(^MineCardVCReturnBLock)(MineCardControlCellModel* model);

@interface MineCardControlViewController : BaseViewController

/**
 是否选择银行卡的属性，点击银行卡要回调返回银行卡信息
 */
@property (nonatomic,assign)BOOL    isChoseCard;

@property (nonatomic,copy)MineCardVCReturnBLock   returnBlock;

@end
