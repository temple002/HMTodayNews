//
//  HMTopicNoneCell.m
//  主流框架
//
//  Created by Temple on 17/11/19.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMTopicNoneCell.h"
#import "Masonry.h"

@interface HMTopicNoneCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *commitCountLable;

@end

@implementation HMTopicNoneCell

- (instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HMTopicNoneCell"];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.userLabel];
        [self.contentView addSubview:self.commitCountLable];
        [self layoutIfNeeded];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.leading.equalTo(self.titleLabel.mas_leading);
        make.width.greaterThanOrEqualTo(@50);
    }];

    [self.commitCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.userLabel.mas_right).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
    }];
}

- (void)setTopic:(HMTopic *)topic {
    _topic = topic;
    
    self.titleLabel.text = topic.title;
    self.userLabel.text = topic.userName;
    self.commitCountLable.text = [NSString stringWithFormat:@"%@评论",topic.commitCount];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:19];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)userLabel {
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] init];
        _userLabel.font = [UIFont systemFontOfSize:12];
        _userLabel.textColor = [UIColor lightGrayColor];
    }
    return _userLabel;
}

- (UILabel *)commitCountLable {
    if (!_commitCountLable) {
        _commitCountLable = [[UILabel alloc] init];
        _commitCountLable.font = [UIFont systemFontOfSize:13];
        _commitCountLable.textColor = [UIColor lightGrayColor];
    }
    return _commitCountLable;
}

@end
