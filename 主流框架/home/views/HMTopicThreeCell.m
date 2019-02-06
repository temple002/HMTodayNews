//
//  HMTopicThreeCell.m
//  主流框架
//
//  Created by Temple on 17/11/19.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMTopicThreeCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface HMTopicThreeCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *commitCountLable;
@property (nonatomic, strong) UIView *imageContent;

@end

@implementation HMTopicThreeCell

- (instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HMTopicThreeCell"];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.userLabel];
        [self.contentView addSubview:self.commitCountLable];
        [self.contentView addSubview:self.imageContent];
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
    
    [self.imageContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.leading.equalTo(self.titleLabel.mas_leading);
        make.trailing.equalTo(self.titleLabel.mas_trailing);
        make.height.mas_equalTo(@80);
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageContent.mas_bottom).offset(5);
        make.leading.equalTo(self.titleLabel.mas_leading);
        make.width.greaterThanOrEqualTo(@50);
    }];
    
    [self.commitCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageContent.mas_bottom).offset(5);
        make.left.equalTo(self.userLabel.mas_right).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
    }];
}

- (void)setTopic:(HMTopic *)topic {
    _topic = topic;
    
    self.titleLabel.text = topic.title;
    self.userLabel.text = topic.userName;
    self.commitCountLable.text = [NSString stringWithFormat:@"%@评论",topic.commitCount];
    
    [self setupImageContent:topic.imageUrls];
}

- (void)setupImageContent:(NSArray *)imageUrls {
    for (int i=0; i<imageUrls.count; i++) {
        UIImageView *imageview = [[UIImageView alloc] init];
        [self.imageContent addSubview:imageview];
        [imageview sd_setImageWithURL:[NSURL URLWithString:imageUrls[i]] placeholderImage:[UIImage imageNamed:@"topicPlaceHolder"]];
        imageview.layer.borderWidth = 0.4;
        imageview.layer.borderColor = [UIColor lightGrayColor].CGColor;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        imageview.clipsToBounds = YES;
        
        CGFloat imageContentWidth = [UIScreen mainScreen].bounds.size.width - 24;
        CGFloat width = (imageContentWidth - (imageUrls.count-1)*5) / imageUrls.count;
        imageview.frame = CGRectMake(i*(width+5), 0, width, 80);
    }
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

- (UIView *)imageContent {
    if (!_imageContent) {
        _imageContent = [[UIView alloc] init];
        _imageContent.backgroundColor = [UIColor whiteColor];
    }
    return _imageContent;
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
