//
//  AboutMe.m
//  HelenOlhausen
//
//  Created by Helen Olhausen on 4/22/15.
//  Copyright (c) 2015 Helen Olhausen. All rights reserved.
//

#import "AboutMe.h"
#import "HelenHTTPSessionManager.h"
#import "Constants.h"
#import "RSPlayPauseButton.h"

@interface AboutMe()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *waveFormImageView;
@property (nonatomic,strong) RSPlayPauseButton *playPauseButton;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (strong, nonatomic) NSDictionary * track;
@property (strong, nonatomic) NSData * trackStream;
@property (weak, nonatomic) IBOutlet UIView *playPauseView;

@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;

@end

@implementation AboutMe

#pragma mark - Lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    [self fetchTrack];
    [self fetchStream];
    [self fetchWaveform];
    
    // song view
    self.playPauseButton = [[RSPlayPauseButton alloc] init];
    self.playPauseButton.animationStyle = RSPlayPauseButtonAnimationStyleSplitAndRotate;
    self.playPauseButton.tintColor = [UIColor whiteColor];
    
    self.playPauseButton.alpha = 0.5f;
    
    self.playPauseButton.enabled = false;
    [self.playPauseButton addTarget:self action:@selector(playPauseButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.playPauseView addSubview:self.playPauseButton];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player stop];
}

-(void)viewDidAppear:(BOOL)animated {
    float constant = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) ? self.view.frame.size.width/3 : self.view.frame.size.width/5;
    
    if ([self.titleForStory isEqualToString:@"DEVELOPMENT + ME"]) {
        [UIView animateWithDuration:0.5
                         animations:^{
                             if (self.leadingSpaceTitle.constant != constant) {
                                 self.leadingSpaceTitle.constant = constant;
                             } else {
                                 self.leadingSpaceTitle.constant = 16;
                             }
                             [self.view setNeedsLayout];
                             [self.view layoutIfNeeded];
                         }
                         completion:nil];
    }
}

- (void)viewDidLayoutSubviews
{
    [self.playPauseButton sizeToFit];
    self.titleLabel.text = self.titleForStory;
}

#pragma mark - Setters

-(void)setTitleForStory:(NSString *)titleForStory {
    _titleForStory = titleForStory;
    self.titleLabel.text = titleForStory;
}

-(void)fetchTrack {
    [[HelenHTTPSessionManager sharedClient] getTrackWithURL:@"http://api.soundcloud.com/resolve.json?url=https://soundcloud.com/helen-olhausen/me-haces-bien-jorge-drexler-by-helen&client_id=18a54722bf90fb2d9723570ccefa02b3"
        success:^(NSURLSessionDataTask *operation, id responseObject) {
            self.track = (NSDictionary *)responseObject;
            self.songNameLabel.text = [self.track objectForKey:@"title"];
    }
         failure:^(NSURLSessionDataTask *operation, NSError *error) {
             [[[UIAlertView alloc] initWithTitle:@"Ops! There was an error loading the track, make sure to connect to internet"
                                         message:[error localizedDescription]
                                        delegate:nil
                               cancelButtonTitle:@"Ok"
                               otherButtonTitles:nil] show];
    }];
}

+(UIColor *)colorWithHex:(int)hex
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:1.0];
}

-(void)fetchWaveform {
//    NSString * waveURL = [self.track objectForKey:@"waveform_url"];
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] init];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager GET:@"https://w1.sndcdn.com/yU8UeluAEzw9_m.png" parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        self.waveFormImageView.image = [UIImage imageWithData:(NSData *)responseObject];
        self.waveFormImageView.image = [self.waveFormImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.waveFormImageView setTintColor:[AboutMe colorWithHex:0xFB4534]];
        
        self.waveFormImageView.backgroundColor = [UIColor redColor];
        self.waveFormImageView.clipsToBounds = YES;
        self.waveFormImageView.contentMode = UIViewContentModeTop;
    } failure:nil];

}

-(void)fetchStream {
//    NSString *stream = [self.track objectForKey:@"stream_url"];
    NSString *stream = @"https://api.soundcloud.com/tracks/150667693/stream";
    NSString *streamURL = [NSString stringWithFormat:@"%@?%@", stream, CLIENT_ID_PARAM];
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] init];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager GET:streamURL parameters:nil
                                              success:^(NSURLSessionDataTask *operation, id responseObject) {
                                                  self.trackStream = (NSData *)responseObject;
                                                  
                                                  // setup song view once I have the stream
                                                  self.playPauseButton.alpha = 1.0f;
                                                  self.playPauseButton.enabled = YES;
                                                  self.songNameLabel.hidden = NO;
                                                  
                                              }
                                              failure:^(NSURLSessionDataTask *operation, NSError *error) {
//                                                  [[[UIAlertView alloc] initWithTitle:@"Ops! There was an error playing the track"
//                                                                              message:[error localizedDescription]
//                                                                             delegate:nil
//                                                                    cancelButtonTitle:@"Ok"
//                                                                    otherButtonTitles:nil] show];
                                              }];
}

-(IBAction)playPause:(UIButton *)sender {
    if (!self.trackStream) {
        [self fetchStream];
    } else {
        NSError *playerError;
        self.player = [[AVAudioPlayer alloc] initWithData:self.trackStream error:&playerError];
        [self.player prepareToPlay];
        [self.player play];
    }
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController {
//    return self.titleForStory;
    return @"";
}

- (void)playPauseButtonDidPress:(RSPlayPauseButton *)playPauseButton {
    NSError *playerError;
    self.player = [[AVAudioPlayer alloc] initWithData:self.trackStream error:&playerError];
    
    if (playPauseButton.isPaused) {
        [self.player prepareToPlay];
        [self.player play];
    } else {
        [self.player stop];
    }
    [playPauseButton setPaused:!playPauseButton.isPaused animated:YES];
}

@end
