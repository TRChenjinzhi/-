//
//  BaseCell.m
//  FenRun
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

+(CGFloat)cellForHeight{
    return 0;
}

+(BaseCell*)cellForTableview:(UITableView *)tableview andIdentify:(nonnull NSString *)identify{
    BaseCell* cell  = [tableview dequeueReusableCellWithIdentifier:identify];
    if(cell){
        [cell setUI];
    }
    else{
        cell        = [BaseCell new];
    }
    return cell;
}

-(void)setUI{
    
}

@end
