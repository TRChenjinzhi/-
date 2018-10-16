//
//  MineWordOrderDelegate.m
//  乐速益
//
//  Created by chenjinzhi on 2018/10/12.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "MineWordOrderDelegate.h"

@implementation MineWordOrderDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineWordOrderCell* cell = (MineWordOrderCell*)[MineWordOrderCell cellForTableview:tableView andIdentify:@"MineWordOrderCell"];
    cell.model              = self.dataSource[indexPath.section];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MineWordOrderCell cellForHeight];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kWidth(12);
}

-(BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

@end
