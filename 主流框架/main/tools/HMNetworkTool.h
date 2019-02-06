//
//  HMNetworkTool.h
//  主流框架
//
//  Created by Temple on 17/10/28.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "HMTopic.h"
#import "HMVideo.h"

typedef enum : NSUInteger {
    HMRequestTypeGET,
    HMRequestTypePOST,
} HMRequestType;

@interface HMNetworkTool : AFHTTPSessionManager

+ (HMNetworkTool *)shareTool;

// 加载首页导航栏的标题
- (void)loadHomeNavBarTitle:(void(^)(BOOL issuccess,NSString *title))completion;

// 加载订阅的标题们
- (void)loadSubcribed:(void(^)(BOOL issuccess,NSDictionary *subcribes))completion;

// 加载文章模型
- (void)loadArticles:(NSString *)category completion:(void (^)(NSArray<HMTopic *> *topics))completion;

// 加载订阅的标题们
- (void)loadVideoSubcribed:(void(^)(BOOL issuccess,NSDictionary *subcribes))completion;

- (void)loadVideos:(NSString *)category completion:(void (^)(NSArray<HMVideo *> *videos))completion;

- (void)request:(HMRequestType)requestType
      urlString:(NSString *)urlString
     parameters:(NSDictionary *)parameters
     completion:(void(^)(BOOL issuccess,NSDictionary *json))completion;

@end
