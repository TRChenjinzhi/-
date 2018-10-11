//
//  IdentifyButton.m
//  乐速益
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "IdentifyButton.h"

#define TotalCount  60

@interface IdentifyButton ()

@property (nonatomic,strong)NSTimer*    timer;

@end

@implementation IdentifyButton

-(void)dealloc{
    NSLog(@"IdentifyButton dealloc");
    [self.timer invalidate];
    self.timer = nil;
}

-(void)initData{
    self.isBegin    = NO;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self setTitleColor:APPThemeBlue forState:UIControlStateNormal];
    [self.titleLabel setFont:kFONT(14)];
}

-(void)Begin{
    
    [self setTitle:[NSString stringWithFormat:@"剩余 %lds",self.timeCount] forState:UIControlStateNormal];
    self.timer  = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(btnAction) userInfo:nil repeats:YES];
    self.enabled    = NO;
    self.isBegin    = YES;
}

-(void)btnAction{
    IMP_BLOCK_SELF(IdentifyButton)
    if(self.timeCount > 0){
        self.timeCount--;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [block_self setTitle:[NSString stringWithFormat:@"剩余 %lds",self.timeCount] forState:UIControlStateNormal];
        }];
    }
    else{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [block_self setTitle:@"获取验证码" forState:UIControlStateNormal];
            [block_self Over];
        }];
    }
    
    if(self.secBlock){
        self.secBlock(self.timeCount);//记录倒计时 剩余时间
    }
}

-(void)Over{
    [self.timer invalidate];
    self.timer      = nil;
    self.enabled    = YES;
    self.timeCount  = TotalCount;
    self.isBegin    = NO;
}

@end
