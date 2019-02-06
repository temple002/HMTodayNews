//
//  HMTabbarController.m
//  主流框架
//
//  Created by huangmin on 2017/10/26.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMTabbarController.h"
#import "HMVedioController.h"
#import "HMShortVedioController.h"
#import "HMHomeViewController.h"
#import "HMMineController.h"
#import "HMTabbar.h"
#import "HMNetworkTool.h"

@interface HMTabbarController ()

@property (nonatomic, strong) HMHomeViewController *homeVC;
@property (nonatomic, strong) HMTabbar *tabbar;

@end

@implementation HMTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 让资源加载完再显示界面
    __block UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LaunchImage"]];
    imageView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:imageView];
    
    [[HMNetworkTool shareTool] loadSubcribed:^(BOOL issuccess, NSDictionary *subcribes) {
        if (subcribes && issuccess) {
            self.homeVC = [HMHomeViewController new];
            self.homeVC.homeSubcribes = subcribes;
            [imageView removeFromSuperview];
            [self setupUI];
        }
    }];
}

- (void)setupUI {
    
    self.tabbar = [HMTabbar new];
    [self setValue:self.tabbar forKey:@"tabBar"];
    
    [self addChildViewController:self.homeVC title:@"首页" normalImage:[UIImage imageNamed:@"home_tabbar"] selectImage:[UIImage imageNamed:@"home_tabbar_press"]];
    [self addChildViewController:[HMVedioController new] title:@"西瓜视频" normalImage:[UIImage imageNamed:@"video_tabbar"] selectImage:[UIImage imageNamed:@"video_tabbar_press"]];
    [self addChildViewController:[HMShortVedioController new] title:@"小视频" normalImage:[UIImage imageNamed:@"huoshan_tabbar"] selectImage:[UIImage imageNamed:@"huoshan_tabbar_press"]];
    [self addChildViewController:[HMMineController new] title:@"我的" normalImage:[UIImage imageNamed:@"mine_tabbar"] selectImage:[UIImage imageNamed:@"mine_tabbar_press"]];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage {
    
    childController.title = title;
    
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor]} forState:UIControlStateNormal];
    [childController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor]} forState:UIControlStateSelected];
    
    childController.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childController.tabBarItem.selectedImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}

- (void)hideTabView{
    self.tabbar.hidden = YES;
}

- (void)showTabView{
    self.tabbar.hidden = NO;
}

@end
