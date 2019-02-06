//
//  HMMenuBar.m
//  主流(scrollView+多VC手势切换)
//
//  Created by Temple on 17/10/23.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMMenuBar.h"

const CGFloat margin = 20;
const CGFloat itemWidth = 52;

@implementation HMMenuBar

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
    }
    return self;
}

- (void)setRootViewController:(UIViewController *)rootViewController {
    _rootViewController = rootViewController;
    
    [self setupUI];
}

- (void)setupUI {
    
    CGFloat offsetX = 0.0;
    
    for (int i=0; i<self.rootViewController.childViewControllers.count; i++) {
        UIViewController *vc = self.rootViewController.childViewControllers[i];
        
        UIButton *menuBtn = [[UIButton alloc] init];
        [menuBtn setTitle:vc.title forState:UIControlStateNormal];
        [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        menuBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        CGSize size = [vc.title boundingRectWithSize:CGSizeMake(MAXFLOAT, 40)
                                             options:NSStringDrawingUsesFontLeading
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}
                                             context:nil].size;
        
        menuBtn.frame = CGRectMake(offsetX + margin, 7, size.width, size.height);
        offsetX += size.width + margin;
        
        [self addSubview:menuBtn];
        
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.contentSize = CGSizeMake(offsetX + margin, 0);
    self.panGestureRecognizer.delaysTouchesBegan = YES;
}

// 当手拽tableview至下一个时，更新menuBar上的按钮
- (void)selectMenuBtnWithTitle:(NSString *)title {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *menuBtn = (UIButton *)view;
            if ([menuBtn.titleLabel.text isEqualToString:title]) {
                [self menuBtnClick:menuBtn];
            }
        }
    }
}

// 点击菜单按钮
- (void)menuBtnClick:(UIButton *)btn {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *menuBtn = (UIButton *)view;
            [menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    // 转换坐标系
    CGPoint point = [self convertPoint:btn.frame.origin toView:self.rootViewController.view];
    
    // 如果下一个按钮超出显示范围，则自动滚动适配
    CGFloat offset = 0.0;
    if (point.x+itemWidth > self.bounds.size.width) {
        offset = point.x + itemWidth + margin - self.bounds.size.width;
    } else if(point.x < 0) {
        offset = point.x - margin;
    }
    [self setContentOffset:CGPointMake(self.contentOffset.x + offset, 0) animated:YES];
    
    // 让控制器的子控制器滚动
    for (int i=0; i<self.rootViewController.childViewControllers.count; i++) {
        if ([self.rootViewController.childViewControllers[i].title isEqualToString:btn.titleLabel.text]) {
            if ([self.menuBarDelegate respondsToSelector:@selector(clickMenuBtnAtIndex:)]) {
                [self.menuBarDelegate clickMenuBtnAtIndex:i];
            }
        }
    }
}


@end
