//
//  JsonHelper.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/30.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "JsonHelper.h"

@implementation JsonHelper

+(NSString *)DicChangeToJson:(NSMutableDictionary *)dic{
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data == nil) {
        return @"{}";
    }
    
    NSString *string = [[NSString alloc] initWithData:data
                                             encoding:NSUTF8StringEncoding];
    return string;
}

+(NSString *)ArrayDicChangeToJson:(NSArray *)array{

    NSError *error = nil;
    //    NSMutableArray *muArray = [NSMutableArray array];
    //    for (NSString *userId in array) {
    //        [muArray addObject:[NSString stringWithFormat:@"\"%@\"", userId]];
    //    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    NSLog(@"json array is: %@", jsonResult);
    return jsonString;
}

@end
