//
//  MineCardTvcCell.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/27.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineCardControlCellModel.h"

@interface MineCardTvcCell : UITableViewCell

@property (nonatomic,assign)NSInteger type;

@property (nonatomic,strong)MineCardControlCellModel* model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)HieghtForCell;

@end
