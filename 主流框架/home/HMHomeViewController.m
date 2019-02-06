//
//  HMHomeViewController.m
//  主流(scrollView+多VC手势切换)
//
//  Created by Temple on 2017/10/5.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMHomeViewController.h"
#import "HMTableViewController.h"
#import "HMMenuBar.h"
#import "HMHomeNavBar.h"
#import "HMNetworkTool.h"
#import "AppDelegate.h"

@interface HMHomeViewController ()<UIScrollViewDelegate,MenuBarDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) HMMenuBar *menuBar;
@property (nonatomic, strong) HMHomeNavBar *navigationBar;
@property (nonatomic, copy) NSString *barTitle;
// 底部线条
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation HMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    for (int i = 0; i<self.homeSubcribes.count; i++) {
        HMTableViewController *tableVC = [[HMTableViewController alloc] init];
        tableVC.tableView.contentInset = UIEdgeInsetsMake(84.5, 0, 0, 0);
        tableVC.tableView.scrollIndicatorInsets = tableVC.tableView.contentInset;
        tableVC.title = [self.homeSubcribes allKeys][i];
        tableVC.category = [self.homeSubcribes allValues][i];
        [self addChildViewController:tableVC];
    }
    
    // 设置scrollview
    [self setupScrollView];
    // 设置菜单栏
    [self setupMenuBar];
    // 设置底部线条
    [self setupBottomLine];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.tabVC showTabView];
    
    [self.tabBarController.tabBar setHidden:NO];
    
    // 设置导航栏
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    
    [[HMNetworkTool shareTool] loadHomeNavBarTitle:^(BOOL issuccess, NSString *title) {
        if (issuccess) {
            self.navigationBar.titleString = title;
        }
    }];
    
    [self.view addSubview:self.navigationBar];
    
    self.navigationController.navigationBar.hidden = YES;
    
    CGRect rect = self.navigationBar.frame;
    rect.size.width = [UIScreen mainScreen].bounds.size.width;
    self.navigationBar.frame = rect;
    
}

- (void)setupMenuBar {
    self.menuBar.rootViewController = self;
    self.menuBar.frame = CGRectMake(0, 64, self.view.bounds.size.width, 34);
    [self.view addSubview:self.menuBar];
    self.menuBar.menuBarDelegate = self;
    
    [self.menuBar selectMenuBtnWithTitle:self.childViewControllers[0].title];
    
}

- (void)setupScrollView {
    self.scrollView.frame = self.view.bounds;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * self.childViewControllers.count, 0);
    [self.view addSubview:self.scrollView];
    
    // 添加第一个view
    [self scrollViewDidEndDecelerating:self.scrollView];
}

- (void)setupBottomLine {
    [self.view addSubview:self.bottomLine];
    self.bottomLine.frame = CGRectMake(0, 97, self.view.bounds.size.width, 0.5);
}

# pragma mark -MenuBarDelegate
- (void)clickMenuBtnAtIndex:(int)index {
    [self.scrollView setContentOffset:CGPointMake(index * self.view.bounds.size.width, self.scrollView.contentOffset.y) animated:YES];
}

// 这个是自动动起来的时候调用,(点击menuBtn)
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    int index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(index * scrollView.bounds.size.width, 0, scrollView.bounds.size.width, scrollView.bounds.size.height - 64);
    
    // 这里不会造成重复加入
    [self.scrollView addSubview:vc.view];
}

// 这个是用手拽的时候调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    int index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    UIViewController *vc = self.childViewControllers[index];
    [self.menuBar selectMenuBtnWithTitle:vc.title];
}

- (HMMenuBar *)menuBar {
    if (!_menuBar) {
        _menuBar = [[HMMenuBar alloc] init];
    }
    return _menuBar;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor lightGrayColor];
    }
    return _scrollView;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomLine;
}

-(HMHomeNavBar *)navigationBar{
    if(!_navigationBar){
        _navigationBar=[[HMHomeNavBar alloc] init];
    }
    
    return _navigationBar;
}

@end
