//
//  HMTopic.m
//  主流框架
//
//  Created by Temple on 17/11/19.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMTopic.h"

@implementation HMTopic

- (NSString *)description {
    return [NSString stringWithFormat:@"title:%@, userName:%@, commitCount:%@, time:%@, images:%@, articleUrls:%@",self.title,self.userName,self.commitCount,self.time,self.imageUrls,self.articleUrl];
}

@end
