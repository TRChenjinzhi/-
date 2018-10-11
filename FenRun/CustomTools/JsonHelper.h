//
//  JsonHelper.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/30.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonHelper : NSObject

+(NSString*)DicChangeToJson:(NSMutableDictionary*)dic;

+(NSString*)ArrayDicChangeToJson:(NSArray*)array;

@end
