//
//  ShareHelper.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/16.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "ShareHelper.h"
 #import <ShareSDKExtension/ShareSDK+Extension.h>

@implementation ShareHelper

static id _instance;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

-(void)shareByTitle:(NSString*)title andMessage:(NSString*)message andImageArray:(NSArray*)imageArray andUrl:(NSString*)url{

    //判断qq 微信是否 安装
    if(![ShareSDK isClientInstalled:SSDKPlatformTypeQQ] && ![ShareSDK isClientInstalled:SSDKPlatformTypeWechat]){
        [QMUITips showInfo:@"您没有安装QQ或者微信，无法分享"];
        return;
    }

    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    //注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传image参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    //将里面的中文进行转换
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [shareParams SSDKSetupShareParamsByText:message
                                     images:imageArray
                                        url:[NSURL URLWithString:url]
                                      title:title
                                       type:SSDKContentTypeAuto];
    
    [shareParams SSDKEnableUseClientShare];
    
    //大家请注意：4.1.2版本开始因为UI重构了下，所以这个弹出分享菜单的接口有点改变，如果集成的是4.1.2以及以后版本，如下调用：
    [ShareSDK showShareActionSheet:theWindow customItems:nil shareParams:shareParams sheetConfiguration:nil onStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
        switch (state) {
            case SSDKResponseStateSuccess:
            {
                //现在分享成功 和 取消分享 都统一 都返回SSDKResponseStateSuccess了
//                [QMUITips showSucceed:@"分享成功"];
                NSLog(@"分享跳转成功");
                break;
            }
            case SSDKResponseStateFail:
            {
//                [QMUITips showError:@"分享失败"];
                break;
            }
            case SSDKResponseStateCancel:
            {
                //                [QMUITips showError:@"分享失败"];
                NSLog(@"分享跳转取消");
                break;
            }
            default:
                break;
        }
    }];

}

@end
