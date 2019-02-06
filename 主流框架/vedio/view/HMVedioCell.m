//
//  HMVedioCell.m
//  主流框架
//
//  Created by Temple on 2017/12/12.
//  Copyright © 2017年 Temple. All rights reserved.
//

#import "HMVedioCell.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>

@interface HMVedioCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *commetCountBtn;
@property (weak, nonatomic) IBOutlet UILabel *videoLenghLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *backView;

@property (nonatomic,strong) AVPlayer *player;

@end

@implementation HMVedioCell

+ (instancetype)vedioCellWithTableView:(UITableView *)tableview {
    static NSString *cellID = @"vedioCell";
    HMVedioCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [HMVedioCell vedioCell];
    }
    return cell;
}

+ (HMVedioCell *)vedioCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"HMVedioCell" owner:nil options:nil] lastObject];
}

- (void)setVideo:(HMVideo *)video {
    _video = video;
    self.userIcon.layer.cornerRadius = self.userIcon.bounds.size.width / 2;
    self.userIcon.layer.masksToBounds = YES;
    
    self.titleLabel.text = video.title;
    self.playCountLabel.text = [NSString stringWithFormat:@"播放%@次",video.playCount];
    self.userNameLabel.text = video.name;
    self.videoLenghLabel.text = video.duration;
    [self.commetCountBtn setTitle:[NSString stringWithFormat:@" %@",video.commentCount] forState:UIControlStateNormal];
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:video.nameIconUrlString] placeholderImage:[UIImage imageNamed:@"topicPlaceHolder"]];
    
    [self addAVPlayer];
}

- (void)addAVPlayer {
    NSString *urlString = self.video.videoUrlString;
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlString]];
    self.player = [AVPlayer playerWithPlayerItem:item];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    playerLayer.frame = CGRectMake(0, 0, width, 181);
    
    [self.contentView.layer insertSublayer:playerLayer below:self.backView.layer];
}

- (IBAction)videoClick:(id)sender {
    self.playBtn.hidden = NO;
    [self.player pause];
}

- (IBAction)playClick:(id)sender {
    [self.player play];
    self.playBtn.hidden = YES;
}

@end
