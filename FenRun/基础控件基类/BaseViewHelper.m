//
//  BaseViewHelper.m
//  FenRun
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "BaseViewHelper.h"

@implementation BaseViewHelper

+(UITableView *)getBaseTableview{
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.showsVerticalScrollIndicator      = NO;
    tableView.showsHorizontalScrollIndicator    = NO;
    tableView.bounces                           = NO;
    tableView.estimatedRowHeight                = 1.1;
    tableView.estimatedSectionFooterHeight      = 1.1;
    tableView.estimatedSectionHeaderHeight      = 1.1;
    tableView.separatorStyle                    = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor                   = [UIColor clearColor];
    
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior    = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    return tableView;
}

@end
