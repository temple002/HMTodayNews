//
//  AppDelegate.h
//  主流(scrollView+多VC手势切换)
//
//  Created by Temple on 2017/10/5.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMTabbarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) HMTabbarController *tabVC;

@end

