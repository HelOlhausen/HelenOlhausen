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
@property (weak, nonatomic) IBOutlet UIImageView *waveFormImageView;
@property (nonatomic,strong) RSPlayPauseButton *playPauseButton;

@property (strong, nonatomic) NSDictionary * track;
@property (strong, nonatomic) NSData * trackStream;
@property (weak, nonatomic) IBOutlet UIView *playPauseView;
@end

@implementation AboutMe

-(void)viewDidLoad {
    [super viewDidLoad];
//    [self fetchTrack];
    [self fetchStream];
    [self fetchWaveform];
    self.playPauseButton = [[RSPlayPauseButton alloc] init];
    self.playPauseButton.tintColor = [UIColor whiteColor];
    self.playPauseButton.alpha = 0.5f;
    self.playPauseButton.enabled = false;
    [self.playPauseButton addTarget:self action:@selector(playPauseButtonDidPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playPauseButton];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.player stop];
}

- (void)viewDidLayoutSubviews
{
    [self.playPauseButton sizeToFit];
    self.playPauseButton.center = self.view.center;
}

-(void)fetchTrack {
    [[HelenHTTPSessionManager sharedClient] getTrackWithURL:@"http://api.soundcloud.com/resolve.json?url=https://soundcloud.com/helen-olhausen/me-haces-bien-jorge-drexler-by-helen&client_id=18a54722bf90fb2d9723570ccefa02b3"
        success:^(NSURLSessionDataTask *operation, id responseObject) {
            self.track = (NSDictionary *)responseObject;
            NSLog(@"%@",self.track);
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
                                                  self.playPauseButton.alpha = 1.0f;
                                                  self.playPauseButton.enabled = true;
                                                  
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
    return @"About me";
}

- (void)playPauseButtonDidPress:(RSPlayPauseButton *)playPauseButton {
    
//    
//    if (!self.trackStream) {
//        [self fetchStream];
//    }
    NSError *playerError;
    self.player = [[AVAudioPlayer alloc] initWithData:self.trackStream error:&playerError];
    
    if (playPauseButton.isPaused) {
        [playPauseButton setPaused:!playPauseButton.isPaused animated:YES];
        [self.player prepareToPlay];
        [self.player play];
    } else {
        [self.player stop];
    }
}

@end
