//
//  HMHomeNavBar.m
//  主流框架
//
//  Created by Temple on 17/10/28.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMHomeNavBar.h"

@interface HMHomeNavBar ()

@property (nonatomic, strong) UIButton *barTitle;

@end

@implementation HMHomeNavBar

- (instancetype)init {
    if (self = [super init]) {
        UIImage *image = [UIImage imageNamed:@"search_background_375_logo"];
        [image setValue:@(2) forKey:@"scale"];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
        [self addSubview:self.barTitle];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //注意导航栏及状态栏高度适配（ios 11）
    self.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 64);
    for (UIView *view in self.subviews) {
        if([NSStringFromClass([view class]) containsString:@"Background"]) {
            view.frame = self.bounds;
        }
        else if ([NSStringFromClass([view class]) containsString:@"ContentView"]) {
            CGRect frame = view.frame;
            frame.origin.y = 20;
            frame.size.height = self.bounds.size.height - frame.origin.y;
            view.frame = frame;
        }
    }
    
    self.barTitle.frame = CGRectMake(140, 32, 200, 20);
}

- (void)titleClick {
    NSLog(@"点击了barTitle");
}

- (void)setTitleString:(NSString *)titleString {
    _titleString = titleString;
    [self.barTitle setTitle:titleString forState:UIControlStateNormal];
}

- (UIButton *)barTitle {
    if (!_barTitle) {
        _barTitle = [[UIButton alloc] init];
        _barTitle.titleLabel.font = [UIFont systemFontOfSize:14];
        [_barTitle setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _barTitle.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [_barTitle addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _barTitle;
}

@end
