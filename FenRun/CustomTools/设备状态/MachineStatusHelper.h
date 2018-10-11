//
//  MachineStatusHelper.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/9/1.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MachineStatusHelper : NSObject

+(NSString*)getTypeStringByInt:(NSInteger)type;
+(NSString*)getTypeStringByType:(MachineStatusType)type;

@end
