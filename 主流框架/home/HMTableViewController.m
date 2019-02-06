//
//  HMTableViewController.m
//  主流(scrollView+多VC手势切换)
//
//  Created by Temple on 2017/10/6.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMTableViewController.h"
#import "HMTopicNoneCell.h"
#import "HMTopicOneCell.h"
#import "HMTopicThreeCell.h"
#import "HMTopicDetailViewController.h"
#import "HMNetworkTool.h"

@interface HMTableViewController ()

@end

@implementation HMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
}

- (void)setCategory:(NSString *)category {
    _category = category;
    
    // 不能多用，会被封
    [[HMNetworkTool shareTool] loadArticles:category completion:^(NSArray<HMTopic *> *topics) {
        self.topics = topics;
        [self.tableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HMTopic *topic = self.topics[indexPath.row];
    if (topic.imageUrls.count == 0) {
        HMTopicNoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HMTopicNoneCell"];
        if (!cell) cell = [[HMTopicNoneCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.topic = topic;
        return cell;
    } else if(topic.imageUrls.count == 1) {
        HMTopicOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HMTopicOneCell"];
        if (!cell) cell = [[HMTopicOneCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.topic = topic;
        return cell;
    } else {
        HMTopicThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HMTopicThreeCell"];
        if (!cell) cell = [[HMTopicThreeCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.topic = topic;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HMTopic *topic = self.topics[indexPath.row];
    
    HMTopicDetailViewController *vc = [[HMTopicDetailViewController alloc] init];
    vc.displayUrl = topic.articleUrl;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
