//
//  IdentifyButton.h
//  乐速益
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^IdentifyButtonBlock)(NSInteger count);

@interface IdentifyButton : UIButton

/**
 是否已经开始倒计时
 */
@property (nonatomic,assign)BOOL        isBegin;
/**
 倒计时总时间 默认60s
 */
@property (nonatomic,assign)NSInteger   timeCount;

@property (nonatomic,copy)IdentifyButtonBlock secBlock;

-(void)initData;
-(void)Begin;
-(void)Over;

@end

NS_ASSUME_NONNULL_END
