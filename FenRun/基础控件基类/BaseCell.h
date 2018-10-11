//
//  BaseCell.h
//  FenRun
//
//  Created by chenjinzhi on 2018/10/11.
//  Copyright © 2018 chenjinzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCell : UITableViewCell

@property (nonatomic,copy)NSString* identifyCode;

+(CGFloat)cellForHeight;

+(id)cellForTableview:(UITableView*)tableview andIdentify:(NSString*)identify;


@end

NS_ASSUME_NONNULL_END
