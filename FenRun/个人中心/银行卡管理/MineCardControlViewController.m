//
//  MineCardControlViewController.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/13.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "MineCardControlViewController.h"
#import "MineCardControlDelegateModel.h"
#import "MineAddOrEditCardVC.h"

@interface MineCardControlViewController ()

@property (nonatomic,strong)UITableView*        tableview;
@property (nonatomic,strong)MineCardControlDelegateModel* delegateModel;

@property (nonatomic,strong)UIButton*           addCardBtn;
@property (nonatomic,strong)MyEmptyView*        emptyView;

@end

@implementation MineCardControlViewController

-(MineCardControlDelegateModel *)delegateModel{
    if(!_delegateModel){
        _delegateModel  = [MineCardControlDelegateModel new];
    }
    return _delegateModel;
}

-(UITableView *)tableview{
    if(!_tableview){
        _tableview  = [BaseViewHelper getBaseTableview];
        //构建tableview
        _tableview.delegate                     = self.delegateModel;
        _tableview.dataSource                   = self.delegateModel;
        _tableview.bounces                      = YES;
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    IMP_BLOCK_SELF(MineCardControlViewController)
    self.naviView.title     = @"银行卡管理";
    self.naviView.backBlock = ^{
        [block_self.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.naviView.mas_bottom);
    }];
    
    self.tableview.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [InternetHelper CardListBy:[LoginHelper share].ID AndSucess:^(NSDictionary *dic) {
//            if([dic containsObjectForKey:@"content"]){
//                NSArray* array  = [MineCardControlCellModel mj_objectArrayWithKeyValuesArray:dic[@"content"]];
//                if(array.count == 0){
//                    [block_self showEmptyView];
//                }
//                else{
//                    [block_self hideEmpty];
//                }
//                block_self.delegateModel.dataSource = array;
//                [block_self.tableview reloadData];
//                [block_self.tableview.mj_header endRefreshing];
//            }
//        } andFailed:^{
//            [block_self.tableview.mj_header endRefreshing];
//        }];
        
        NSMutableArray* tmp = [NSMutableArray new];
        for(int i=0 ;i<3 ;i++){
            MineCardControlCellModel* model = [MineCardControlCellModel createModelByIndex:i];
            [tmp addObject:model];
        }
        block_self.delegateModel.dataSource = tmp;
        [block_self.tableview reloadData];
        [block_self.tableview.mj_header endRefreshing];
    }];
    
    [self.tableview.mj_header beginRefreshing];
    
    self.delegateModel.cellClickBlock = ^(MineCardControlCellModel *model) {
        if(!block_self.isChoseCard){
            MineAddOrEditCardVC* vc     = [MineAddOrEditCardVC new];
            vc.type                     = CardEdit;
            vc.model                    = model;
            vc.returnBlock = ^(CardDetailModel* model){
                [block_self.tableview.mj_header beginRefreshing];
            };
            [block_self.navigationController pushViewController:vc animated:YES];
        }
        else{
            if(block_self.returnBlock){
                block_self.returnBlock(model);
                [block_self.navigationController popViewControllerAnimated:YES];
            }
        }
    };
    
    UIButton* addCardBtn    = [UIButton new];
    self.addCardBtn         = addCardBtn;
    [addCardBtn setBackgroundImage:UIImageMake(@"img_share_head_bg") forState:UIControlStateNormal];
    [addCardBtn setTitle:@"+ 添加银行卡" forState:UIControlStateNormal];
    [addCardBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addCardBtn.layer setCornerRadius:kWidth(4)];
    addCardBtn.layer.masksToBounds  = YES;
    [addCardBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        
        if(block_self.delegateModel.dataSource.count >= CardCount){
            [QMUITips showInfo:[NSString stringWithFormat:@"最多保存 %ld 张卡",(long)CardCount]];
            return ;
        }
        
        MineAddOrEditCardVC* vc   = [MineAddOrEditCardVC new];
        vc.type                   = CardAdd;
        vc.returnBlock = ^(CardDetailModel* model){
            [block_self.tableview.mj_header beginRefreshing];
        };
        [block_self.navigationController pushViewController:vc animated:YES];
    }];
    [self.view addSubview:addCardBtn];
    [addCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-kWidth(40));
        make.left.equalTo(self.view.mas_left).offset(kWidth(48));
        make.right.equalTo(self.view.mas_right).offset(-kWidth(48));
        make.height.mas_offset(kWidth(44));
    }];
}


-(void)showEmptyView{
    [self hideEmpty];
    self.emptyView  = [[MyEmptyView alloc] initWithImage:UIImageMake(@"img_defect_empty_bank")];
    [self.view addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.naviView.mas_bottom);
    }];
    [self.view bringSubviewToFront:self.addCardBtn];
}

-(void)hideEmpty{
    [self.emptyView removeFromSuperview];
    self.emptyView  = nil;
}

@end
