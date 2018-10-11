//
//  MineVC.h
//  FenRun
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^MineVCBlock)(void);

@interface MineVC : BaseViewController

@property (nonatomic,copy)MineVCBlock   loginOutBlock;

@end

NS_ASSUME_NONNULL_END
