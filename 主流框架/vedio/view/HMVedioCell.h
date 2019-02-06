//
//  HMVedioCell.h
//  主流框架
//
//  Created by Temple on 2017/12/12.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMVideo.h"

@interface HMVedioCell : UITableViewCell

@property (nonatomic,strong) HMVideo *video;

+ (instancetype)vedioCellWithTableView:(UITableView *)tableview;

@end
