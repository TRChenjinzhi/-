//
//  ShareHelper.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/16.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface ShareHelper : NSObject

-(void)shareByTitle:(NSString*)title andMessage:(NSString*)message andImageArray:(NSArray*)imageArray andUrl:(NSString*)url;

+ (instancetype)sharedInstance;

@end
