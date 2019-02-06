//
//  HMTopic.h
//  主流框架
//
//  Created by Temple on 17/11/19.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTopic : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *commitCount;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, copy) NSString *articleUrl;

@property (nonatomic, assign) BOOL hasImage;

@end
