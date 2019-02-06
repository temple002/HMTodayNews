//
//  Const.h
//  主流框架
//
//  Created by Temple on 17/10/28.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import <Foundation/Foundation.h>

// 今日头条的iid，通过Charles抓包获取
const NSString *iid = @"5034850950";//@"14763812456";
const NSString *device_id = @"6096495334";//@"37653148468";

// 请求开头部分
const NSString *baseURL = @"https://is.snssdk.com";

#define versionCode [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]
