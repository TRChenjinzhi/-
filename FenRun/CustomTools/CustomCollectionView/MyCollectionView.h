//
//  MyCollectionView.h
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/3.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeMachineMyShopCollectionViewCell.h"

@interface MyCollectionView : UIView

typedef enum : NSInteger {
    CollectionHome = 0,     //首页collectionView
    CollectionMachineShop   //机具产品collectionView
} CollectionType;

typedef void(^ clickBlock)(NSInteger index);

/**
 周边的边距
 */
@property (nonatomic,assign)UIEdgeInsets        edgeInsets;
/**
 item大小
 */
@property (nonatomic,assign)CGSize              size;
/**
 行间距
 */
@property (nonatomic,assign)CGFloat              lineSpace;
/**
 列间距
 */
@property (nonatomic,assign)CGFloat              itemSpace;

@property (nonatomic,strong)NSArray*             dataSource;

@property (nonatomic,strong)clickBlock              clickItemBlock;

@property (nonatomic,assign)CollectionType          collectionType;

-(void)setUI;
-(void)refresh;

@end
