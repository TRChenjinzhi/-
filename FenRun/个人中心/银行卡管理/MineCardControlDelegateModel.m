//
//  MineCardControlDelegateModel.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/27.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MineCardControlDelegateModel.h"

@implementation MineCardControlDelegateModel

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCardTvcCell* cell = [MineCardTvcCell cellWithTableView:tableView];
    cell.tag                = indexPath.row;
    cell.model              = self.dataSource[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MineCardTvcCell HieghtForCell];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MineCardControlCellModel* model      = self.dataSource[indexPath.row];
    if(self.cellClickBlock){
        self.cellClickBlock(model);
    }
}

@end
