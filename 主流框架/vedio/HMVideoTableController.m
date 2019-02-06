//
//  HMVideoTableController.m
//  主流框架
//
//  Created by WYSD-YTJ-010 on 2017/11/27.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMVideoTableController.h"
#import "HMVedioCell.h"
#import "HMNetworkTool.h"

@interface HMVideoTableController ()

@property (nonatomic,strong) NSArray<HMVideo *> *videos;

@end

@implementation HMVideoTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 170;
    self.tableView.panGestureRecognizer.delaysTouchesBegan = YES;
}

- (void)setCategory:(NSString *)category {
    _category = category;
    
    [[HMNetworkTool shareTool] loadVideos:category completion:^(NSArray<HMVideo *> *videos) {
        self.videos = videos;
        [self.tableView reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMVedioCell *cell = [HMVedioCell vedioCellWithTableView:tableView];
    cell.video = self.videos[indexPath.row];
    return cell;
}

@end
