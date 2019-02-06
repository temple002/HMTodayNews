//
//  HMNetworkTool.m
//  主流框架
//
//  Created by Temple on 17/10/28.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMNetworkTool.h"
#import "Const.h"
#import "JSONKit.h"

@implementation HMNetworkTool

+ (HMNetworkTool *)shareTool {
    static dispatch_once_t onceToken;
    static HMNetworkTool *instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", nil];
    });
    return instance;
}

/*******************************************首页*****************************************************/

// 加载首页导航栏的标题
- (void)loadHomeNavBarTitle:(void(^)(BOOL issuccess,NSString *title))completion {
    [self request:HMRequestTypeGET urlString:@"/search/suggest/homepage_suggest/?" parameters:@{@"iid":iid,@"device_id":device_id} completion:^(BOOL issuccess, NSDictionary *json) {
        if (!json) {
            completion(NO,nil);
        } else {
            completion(issuccess,json[@"data"][@"homepage_search_suggest"]);
        }
    }];
}

// 加载订阅的标题们
- (void)loadSubcribed:(void(^)(BOOL issuccess,NSDictionary *subcribes))completion {
    [self request:HMRequestTypeGET urlString:@"/article/category/get_subscribed/v1/?" parameters:@{@"iid":iid,@"device_id":device_id} completion:^(BOOL issuccess, NSDictionary *json) {
        
        if (!json) {
            completion(NO,nil);
        }
        
        NSArray *subcribes = json[@"data"][@"data"];
        if (!subcribes || !issuccess) {
            completion(NO,nil);
        }
        
        NSMutableDictionary *names = [NSMutableDictionary dictionary];
        
        for (NSDictionary *dic in subcribes) {
            if ([dic objectForKey:@"name"] && [dic objectForKey:@"category"]) {
                [names setObject:dic[@"category"] forKey:dic[@"name"]];
            }
        }
        
        if (names && issuccess) {
            completion(YES,names);
        } else {
            completion(NO,nil);
        }
    }];
}

// 文章
- (void)loadArticles:(NSString *)category completion:(void (^)(NSArray<HMTopic *> *))completion {
    
     NSDictionary *params = @{@"iid":iid,
                             @"device_id":device_id,
                             @"category": category,
                             @"device_platform": @"iphone",
                             @"version_code":versionCode
     };
    
    NSMutableArray <HMTopic *>*topics = [NSMutableArray array];
     [self request:HMRequestTypeGET urlString:@"/api/news/feed/v58/?" parameters:params completion:^(BOOL issuccess, NSDictionary *json) {
     
         if (!json) {
             completion(nil);
         }
         // 把斜杠去了
         NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                            options:NSJSONWritingPrettyPrinted
                                                              error:nil];
         NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
         jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\\\\" withString:@""];
         jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\\" withString:@"|^&*|"];
         jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
         jsonString = [jsonString stringByReplacingOccurrencesOfString:@"|^&*|" withString:@"\\"];
         jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
         jsonString = [jsonString stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
         
         NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
         NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         
         NSArray *array = jsonDic[@"data"];
         for (NSDictionary *dict in array) {
             NSDictionary *contentDict = dict[@"content"];
             
             HMTopic *topic = [[HMTopic alloc] init];
             topic.title = contentDict[@"title"];
             topic.userName = contentDict[@"user_info"][@"name"];
             topic.commitCount = contentDict[@"comment_count"];
             topic.time = contentDict[@"cursor"];
             topic.articleUrl = contentDict[@"display_url"];
             BOOL hasImages = [contentDict[@"has_image"] boolValue];
             topic.hasImage = hasImages;
             
             if (hasImages) {
                 NSArray *imageList = contentDict[@"image_list"];
                 NSMutableArray *imageUrls = [NSMutableArray array];
                 for (NSDictionary *dic in imageList) {
                     [imageUrls addObject:dic[@"url"]];
                 }
                 topic.imageUrls = imageUrls;
             }
             [topics addObject:topic];
         }
         completion(topics);
     }];
    
    // 从本地加载json，网络请求多了会被封
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"首页" ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
}

/*******************************************西瓜视频*****************************************************/
// 加载订阅的标题们
- (void)loadVideoSubcribed:(void(^)(BOOL issuccess,NSDictionary *subcribes))completion {
    [self request:HMRequestTypeGET urlString:@"/video_api/get_category/v1/?" parameters:@{@"iid":iid,@"device_id":device_id} completion:^(BOOL issuccess, NSDictionary *json) {
        if (!json) {
            completion(NO,nil);
        }
        
        NSArray *subcribes = json[@"data"];
        if (!subcribes || !issuccess) {
            completion(NO,nil);
        }
        
        NSMutableDictionary *names = [NSMutableDictionary dictionary];
        for (NSDictionary *dic in subcribes) {
            if ([dic objectForKey:@"name"] && [dic objectForKey:@"category"]) {
                [names setObject:dic[@"category"] forKey:dic[@"name"]];
            }
        }
        
        if (names && issuccess) {
            completion(YES,names);
        } else {
            completion(NO,nil);
        }
    }];
}

- (void)loadVideos:(NSString *)category completion:(void (^)(NSArray<HMVideo *> *videos))completion {
    
    NSDictionary *params = @{@"iid":iid,
                             @"device_id":device_id,
                             @"category": @"video",
                             @"device_platform": @"iphone",
                             @"version_code":versionCode
                             };
    [self request:HMRequestTypeGET urlString:@"/api/news/feed/v58/?" parameters:params completion:^(BOOL issuccess, NSDictionary *json) {
        
        // 把斜杠去了
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\\\\" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\\\" withString:@"|^&*|"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"|^&*|" withString:@"\\"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *dataArr = jsonDic[@"data"];
        NSMutableArray *videos = [NSMutableArray array];
        
        for (NSDictionary *dict in dataArr) {
            HMVideo *video = [[HMVideo alloc] init];
            NSDictionary *contentDict = dict[@"content"];
            NSDictionary *userInfo = contentDict[@"user_info"];
            NSDictionary *videoDict = contentDict[@"video_play_info"][@"video_list"][@"video_1"];
            NSString *mainUrl = videoDict[@"main_url"];
            
            video.videoUrlString = mainUrl;
            video.articleUrlString = contentDict[@"article_url"];
            video.title = contentDict[@"title"];
            video.commentCount = contentDict[@"comment_count"];
            video.name = userInfo[@"name"];
            video.nameIconUrlString = userInfo[@"avatar_url"];
            video.playCount = contentDict[@"read_count"];
            video.duration = contentDict[@"video_duration"];
            
            [videos addObject:video];
        }
        completion(videos);
    }];
    
    
    // 取本地
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"视频" ofType:@"json"];
//    NSData *data = [NSData dataWithContentsOfFile:path];
//    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    NSArray *dataArr = resultDic[@"data"];
//
//    NSMutableArray *videos = [NSMutableArray array];
//    for (NSDictionary *dict in dataArr) {
//        HMVideo *video = [[HMVideo alloc] init];
//        NSDictionary *contentDict = dict[@"content"];
//        NSDictionary *userInfo = contentDict[@"user_info"];
//        NSDictionary *videoDict = contentDict[@"video_play_info"][@"video_list"][@"video_1"];
//        NSString *mainUrl = videoDict[@"main_url"];
//
//        video.videoUrlString = mainUrl;
//        video.articleUrlString = contentDict[@"article_url"];
//        video.title = contentDict[@"title"];
//        video.commentCount = contentDict[@"comment_count"];
//        video.name = userInfo[@"name"];
//        video.nameIconUrlString = userInfo[@"avatar_url"];
//        video.playCount = contentDict[@"read_count"];
//        video.duration = contentDict[@"video_duration"];
//
//        [videos addObject:video];
//    }
//    completion(videos);
    
}

/*******************************************封装网络请求*****************************************************/
// 网络请求封装
- (void)request:(HMRequestType)requestType
      urlString:(NSString *)urlString
     parameters:(NSDictionary *)parameters
     completion:(void(^)(BOOL issuccess,NSDictionary *json))completion{
    
    void (^success)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask * task, id  responseObject) {
        completion(YES,responseObject);
    };
    
    void (^failure)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"%@",error);
        completion(NO,nil);
    };
    
    NSString *urlstring = [NSString stringWithFormat:@"%@%@",baseURL,urlString];
    
    if (requestType == HMRequestTypeGET) {
        [self GET:urlstring parameters:parameters progress:nil success:success failure:failure];
    } else if(requestType == HMRequestTypePOST) {
        [self POST:urlstring parameters:parameters progress:nil success:success failure:failure];
    }
}

@end
