//
//  ViewController.m
//  test
//
//  Created by WYSD-YTJ-010 on 2017/11/27.
//  Copyright © 2017年 WYSD-YTJ-010. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString *mainUrl = @"aHR0cDovL3Y2LXR0Lml4aWd1YS5jb20vdmlkZW8vbS8yMjA5OTA1ZDYyMjlhM2U0NjRmYjQ4NjNkNTcwYjU4MjUwNjExNTJkZjZmMDAwMDIxZTUwOGVlMjI0Mi8/RXhwaXJlcz0xNTEzNTA2MTM5JkFXU0FjY2Vzc0tleUlkPXFoMGg5VGRjRU1vUzJvUGo3YUtYJlNpZ25hdHVyZT1mMENhaDY3SllBaklzWkZEYVBGUW9tOVIzTUklM0Q=";
    NSData *data = [[NSData alloc] initWithBase64EncodedString:mainUrl options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",string);
    
}


@end
