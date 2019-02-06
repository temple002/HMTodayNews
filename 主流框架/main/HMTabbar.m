//
//  HMTabbar.m
//  自定义tabbar
//
//  Created by huangmin on 2017/10/16.
//  Copyright © 2017年 huangmin. All rights reserved.
//

#import "HMTabbar.h"

@interface HMTabbar()

@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, strong) UIButton *publishBtn;

@end

@implementation HMTabbar

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.publishBtn];
        self.tabBarButtons = [NSMutableArray array];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.tabBarButtons.count == 0) {
        for (int i = 0; i<self.subviews.count; i++) {
            if([self.subviews[i] isKindOfClass:[NSClassFromString(@"UITabBarButton") class]]) {
                [self.tabBarButtons addObject:self.subviews[i]];
            }
        }
    }
    // 计算每个button宽
    CGFloat width = self.bounds.size.width / 5;
    
    for (int i = 0; i<self.tabBarButtons.count; i++) {
        UIView *tabbarBtn = self.tabBarButtons[i];
        CGRect frame = tabbarBtn.frame;

        frame.origin.x = ((i<2) ? i : i + 1)* width;
        
        frame.size.width = width;
        tabbarBtn.frame = frame;
    }
    
    self.publishBtn.frame = CGRectMake(2 * width, -20, width, width);
    [self bringSubviewToFront:self.publishBtn];
}

// 让发布按钮超出tabbar的地方也能点击到
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *result = [super hitTest:point withEvent:event];

    CGPoint buttonPoint = [self convertPoint:point toView:self.publishBtn];
    UIView *result2 = [self.publishBtn hitTest:buttonPoint withEvent:event];
    
    return (result2) ? result2 : result;
}

// 发布按钮点击事件
- (void) publishClick {
    NSLog(@"点击了发布按钮");
}

- (UIButton *)publishBtn {
    if (!_publishBtn) {
        _publishBtn = [[UIButton alloc] init];
        [_publishBtn setImage:[UIImage imageNamed:@"feed_publish"] forState:UIControlStateNormal];
        [_publishBtn setImage:[UIImage imageNamed:@"feed_publish_press"] forState:UIControlStateHighlighted];
        [_publishBtn addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishBtn;
}

@end
