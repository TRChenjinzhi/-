//
//  BaseViewController.m
//  瑞众盟
//
//  Created by chenjinzhi on 2018/8/3.
//  Copyright © 2018年 chenjinzhi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()



@end

@implementation BaseViewController

-(NaviView *)naviView{
    if(!_naviView){
        IMP_BLOCK_SELF(BaseViewController)
        _naviView   = [[NaviView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, SCREEN_WIDTH, NavigationBarHeight)];
        _naviView.backgroundColor   = [Color_Image_Helper ImageChangeToColor:UIImageMake(@"img_share_head_bg") AndNewSize:CGSizeMake(SCREEN_WIDTH, NavigationBarHeight)];
        _naviView.title = @"标题";
        _naviView.backBlock = ^{
            [block_self.navigationController popViewControllerAnimated:YES];
        };
    }
    return _naviView;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = APPThemeGray;
    [self initView];
    
    if (@available(iOS 11.0, *)) {
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)initView {
    //状态栏背景
    UIImageView* titileView  = [UIImageView new];
    self.statusImaV          = titileView;
    [titileView setImage:UIImageMake(@"img_share_head_bg")];
    [self.view addSubview:titileView];
    [titileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.equalTo(self.view);
        make.height.mas_offset(StatusBarHeight);
    }];
    
    //navi
    [self.view addSubview:self.naviView];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
