//
//  HMTopicOneCell.m
//  主流框架
//
//  Created by Temple on 17/11/19.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMTopicOneCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface HMTopicOneCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *commitCountLable;
@property (nonatomic, strong) UIImageView *topicImageView;

@end

@implementation HMTopicOneCell

- (instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HMTopicOneCell"];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.userLabel];
        [self.contentView addSubview:self.commitCountLable];
        [self.contentView addSubview:self.topicImageView];
        [self layoutIfNeeded];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.topicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(18);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.width.mas_equalTo(@110);
        make.height.mas_equalTo(@80);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(12);
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.right.equalTo(self.topicImageView.mas_left).offset(-12);
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topicImageView.mas_bottom).offset(5);
        make.leading.equalTo(self.titleLabel.mas_leading);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.width.greaterThanOrEqualTo(@50);
    }];
    
    [self.commitCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topicImageView.mas_bottom).offset(5);
        make.left.equalTo(self.userLabel.mas_right).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
    }];
    
}

- (void)setTopic:(HMTopic *)topic {
    _topic = topic;
    
    self.titleLabel.text = topic.title;
    self.userLabel.text = topic.userName;
    self.commitCountLable.text = [NSString stringWithFormat:@"%@评论",topic.commitCount];
    
    [self.topicImageView sd_setImageWithURL:[NSURL URLWithString:topic.imageUrls[0]] placeholderImage:[UIImage imageNamed:@"topicPlaceHolder"]];
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

- (UIImageView *)topicImageView {
    if (!_topicImageView) {
        _topicImageView  = [[UIImageView alloc] init];
        _topicImageView.layer.borderWidth = 0.4;
        _topicImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _topicImageView.contentMode = UIViewContentModeScaleAspectFill;
        _topicImageView.clipsToBounds = YES;
    }
    return _topicImageView;
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
