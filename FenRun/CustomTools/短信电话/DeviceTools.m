//
//  DeviceTools.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/9.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "DeviceTools.h"

@implementation DeviceTools

+(NSString *)getAPPVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    CFShow(infoDictionary);
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    
    
    //手机序列号
//    NSString* identifierNumber = [[UIDevice currentDevice] uniqueIdentifier];
//    NSLog(@"手机序列号: %@",identifierNumber);
    //手机别名： 用户定义的名称
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    NSLog(@"手机别名: %@", userPhoneName);
    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称: %@",deviceName );
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本: %@", phoneVersion);
    //手机型号
    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSLog(@"手机型号: %@",phoneModel );
    //地方型号  （国际化区域名称）
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"国际化区域名称: %@",localPhoneModel );
    
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用名称
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSLog(@"当前应用名称：%@",appCurName);
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    // 当前应用版本号码   int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@",appCurVersionNum);
    
    return app_Version;
}

+(NSString *)getAPPName{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //    CFShow(infoDictionary);
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    
    
    //手机序列号
    //    NSString* identifierNumber = [[UIDevice currentDevice] uniqueIdentifier];
    //    NSLog(@"手机序列号: %@",identifierNumber);
    //手机别名： 用户定义的名称
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    NSLog(@"手机别名: %@", userPhoneName);
    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称: %@",deviceName );
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本: %@", phoneVersion);
    //手机型号
    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSLog(@"手机型号: %@",phoneModel );
    //地方型号  （国际化区域名称）
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"国际化区域名称: %@",localPhoneModel );
    
    //    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用名称
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleName"];
    NSLog(@"当前应用名称：%@",appCurName);
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    // 当前应用版本号码   int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@",appCurVersionNum);
    
    return app_Name;
}

-(void)sendMessageByMessage:(NSString *)message AndPhoneNumber:(NSString *)phoneNumber{
    NSLog(@"发短信");
    //传入要发送到得电话号码，和短信界面预写入短信的内容，调用此方法即可跳到短信发送界面
    [self showMessageView:@[phoneNumber] title:@"曹操" body:message];
}

//发短信
-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [_superSelf presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        [QMUITips showError:@"不支持短信功能!"];
    }
}

-(void)CallByPhoneNumber:(NSString *)phoneNumber{

    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phoneNumber];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    BaseViewController* vc  = (BaseViewController*)self.superSelf;
    [vc.view addSubview:callWebview];

//    NSMutableString * string = [[NSMutableString alloc] initWithFormat:@"tel://%@",phoneNumber];
//    if (@available(iOS 10.0, *)) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string] options:@{} completionHandler:^(BOOL success) {
//            if(success){
//                NSLog(@"拨打成功");
//            }
//            else{
//                [QMUITips showInfo:@"手机系统版本太低，请升级"];
//            }
//
//        }];
//    } else {
////        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
//        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:string]]) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
//        }
//        else{
//            [QMUITips showInfo:@"手机系统版本太低，请升级"];
//        }
//    }
}


#pragma mark -----------短信协议------------------
//发短信
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self.superSelf dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            NSLog(@"信息传送成功");
            break;
        case MessageComposeResultFailed:
            //信息传送失败
            NSLog(@"信息传送失败");
            [QMUITips showError:@"信息传送失败"];
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            NSLog(@"信息被用户取消传送");
//            [QMUITips showError:@"信息取消"];
            break;
        default:
            break;
    }
}

@end
