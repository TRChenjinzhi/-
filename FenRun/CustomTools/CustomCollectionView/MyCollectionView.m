//
//  MyCollectionView.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/3.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MyCollectionView.h"
#import "MyCutomCollectionViewCell.h"
@interface MyCollectionView () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UICollectionView* collectv;

@end

static NSString* identify = @"MyCutomCollectionViewCell";
@implementation MyCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
    }
    return self;
}

-(void)layoutSubviews{
    
}

-(void)setUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 1.设置列间距
    layout.minimumInteritemSpacing  = self.itemSpace;
    // 2.设置行间距
    layout.minimumLineSpacing       = self.lineSpace;
    // 3.设置每个item的大小
    layout.itemSize                 = self.size;
    // 4.设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
//    layout.estimatedItemSize = CGSizeMake(320, 60);
    // 5.设置布局方向
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 6.设置头视图尺寸大小
//    layout.headerReferenceSize = CGSizeMake(50, 50);
    // 7.设置尾视图尺寸大小
//    layout.footerReferenceSize = CGSizeMake(50, 50);
    // 8.设置分区(组)的EdgeInset（四边距）
//    layout.sectionInset             = self.edgeInsets;
    // 9.10.设置分区的头视图和尾视图是否始终固定在屏幕上边和下边
//    layout.sectionFootersPinToVisibleBounds = YES;
//    layout.sectionHeadersPinToVisibleBounds = YES;
    
    UICollectionView* colletV       = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectv                   = colletV;
    colletV.backgroundColor         = [UIColor clearColor];
    colletV.delegate                = self;
    colletV.dataSource              = self;
    colletV.scrollsToTop            = NO;
    colletV.bounces                 = NO;
    if (@available(iOS 11.0, *)) {
        colletV.contentInsetAdjustmentBehavior  = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    if(self.collectionType == CollectionHome){
        [colletV registerClass:[MyCutomCollectionViewCell class] forCellWithReuseIdentifier:identify];
    }
    else if(self.collectionType == CollectionMachineShop){
        [colletV registerClass:[HomeMachineMyShopCollectionViewCell class] forCellWithReuseIdentifier:@"HomeMachineMyShopCollectionViewCell"];
    }
    [self addSubview:colletV];
    [colletV reloadData];
}

-(void)refresh{
    [self.collectv reloadData];
}

//设置分区数（必须实现）
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//设置每个分区的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

//设置返回每个item的属性必须实现）
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.collectionType == CollectionMachineShop){
        HomeMachineMyShopCollectionViewCell* cell   = [HomeMachineMyShopCollectionViewCell getCellBy:collectionView AndIdentify:@"HomeMachineMyShopCollectionViewCell" AndIndexpath:indexPath];
        cell.tag    = indexPath.row;
        cell.model  = self.dataSource[indexPath.row];
        return cell;
    }
    else if(self.collectionType == CollectionHome){
        MyCutomCollectionViewCell *cell = [MyCutomCollectionViewCell getCellBy:collectionView AndIdentify:identify AndIndexpath:indexPath];
        cell.tag = indexPath.row;
        cell.image = self.dataSource[indexPath.row];
        return cell;
    }
    else{
        return nil;
    }
}

//对头视图或者尾视图进行设置
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    NSString *identifier;
//
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        identifier = @"headerView";
//    } else {
//        identifier = @"footerView";
//    }
//    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 120, 30)];
//    [view addSubview:label];
//
//    if (indexPath.section == 0) {
//        label.text = @"section1";
//    }else {
//        label.text = @"section2";
//    }
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        view.backgroundColor = [UIColor redColor];
//    } else {
//        view.backgroundColor = [UIColor purpleColor];
//
//    }
//    return view;
    return nil;
}

//是否允许移动Item
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0){
    return NO;
}

//移动Item时触发的方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0); {
    
}


#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  self.size;
}



#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.edgeInsets;
}


#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.itemSpace;
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.lineSpace;
}

#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.clickItemBlock){
        self.clickItemBlock(indexPath.row);
    }
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end
