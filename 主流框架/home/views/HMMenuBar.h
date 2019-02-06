//
//  HMMenuBar.h
//  主流(scrollView+多VC手势切换)
//
//  Created by Temple on 17/10/23.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMMenuBar;

@protocol MenuBarDelegate <NSObject>

- (void)clickMenuBtnAtIndex:(int)index;

@end

@interface HMMenuBar : UIScrollView

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, weak) id<MenuBarDelegate> menuBarDelegate;

- (void)selectMenuBtnWithTitle:(NSString *)title;

@end
