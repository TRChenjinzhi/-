//
//  MachineStatusHelper.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/9/1.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MachineStatusHelper.h"

@implementation MachineStatusHelper

+(NSString*)getTypeStringByInt:(NSInteger)type{
    NSString* str = nil;
    switch (type) {
        case 0:{
            str = MachineStatusNotOutStr;
            break;
        }
        case 1:{
            str = MachineStatusOutStr;
            break;
        }
        case 2:{
            str = MachineStatusTogetherStr;
            break;
        }
        case 3:{
            str = MachineStatusActivityStr;
            break;
        }
        case 4:{
            str = @"已达标";//已返现
            break;
        }
        case 5:{
            str = MachineStatusNotGiveMmoneyStr;
            break;
        }
        case 6:{
            str = MachineStatusBrokenStr;
            break;
        }
        case 7:{
            str = MachineStatusNotTogatheringStr;
            break;
        }
            
        default:
            NSLog(@"没有");
            break;
    }
    
    return str;
}

+(NSString*)getTypeStringByType:(MachineStatusType)type{
    NSString* str = nil;
    switch (type) {
        case MachineStatusNotOut:{
            str = MachineStatusNotOutStr;
            break;
        }
        case MachineStatusOut:{
            str = MachineStatusOutStr;
            break;
        }
        case MachineStatusTogether:{
            str = MachineStatusTogetherStr;
            break;
        }
        case MachineStatusActivity:{
            str = MachineStatusActivityStr;
            break;
        }
        case MachineStatusGiveMmoney:{
            str = @"已达标";//已返现
            break;
        }
        case MachineStatusNotGiveMmoney:{
            str = MachineStatusNotGiveMmoneyStr;
            break;
        }
        case MachineStatusBroken:{
            str = MachineStatusBrokenStr;
            break;
        }
        case MachineStatusNotTogathering:{
            str = MachineStatusNotTogatheringStr;
            break;
        }
            
        default:
            NSLog(@"没有");
            break;
    }
    
    return str;
}

@end
