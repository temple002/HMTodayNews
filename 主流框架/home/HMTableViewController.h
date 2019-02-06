//
//  HMTableViewController.h
//  主流(scrollView+多VC手势切换)
//
//  Created by Temple on 2017/10/6.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMTopic.h"

@interface HMTableViewController : UITableViewController

@property (nonatomic, strong) NSArray <HMTopic *>* topics;
@property (nonatomic, copy) NSString *category;

@end
