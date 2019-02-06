//
//  HMVideo.m
//  主流框架
//
//  Created by WYSD-YTJ-010 on 2017/11/27.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMVideo.h"

@implementation HMVideo

- (NSString *)duration {
    if (!_duration) {
        return @"00:00";
    }
    int videoDuration = [_duration intValue];
    
    int hour = videoDuration / 3600;
    int minute = (videoDuration / 60) % 60;
    int second = videoDuration % 60;
    if (hour > 0) {
        return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second];
    }
    return [NSString stringWithFormat:@"%02d:%02d",minute, second];
}

- (NSString *)videoUrlString {
    if (!_duration) {
        return @"";
    }
    
    NSString *mainUrl = _videoUrlString;
    NSData *data = [[NSData alloc] initWithBase64EncodedString:mainUrl options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

@end
