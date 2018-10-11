//
//  DeviceTools.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/9.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceTools : NSObject <MFMessageComposeViewControllerDelegate>

@property (nonatomic,weak)id superSelf;

-(void)sendMessageByMessage:(NSString*)message AndPhoneNumber:(NSString*)phoneNumber;

-(void)CallByPhoneNumber:(NSString *)phoneNumber;

+(NSString*)getAPPVersion;
+(NSString *)getAPPName;

@end
