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
@property (weak, nonatomic) IBOutlet UITextView *storyTextField;

@property (weak, nonatomic) IBOutlet UIImageView *waveFormImageView;
@property (nonatomic,strong) RSPlayPauseButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UIView *playPauseView;

@property (nonatomic, strong) AVAudioPlayer *player;

@property (strong, nonatomic) NSDictionary * track;
@property (strong, nonatomic) NSData * trackStream;


@property (weak, nonatomic) IBOutlet UILabel *songNameLabel;

@end

@implementation AboutMe

#pragma mark - Lifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    [self fetchStream];
    [self fetchTrack];
    [self fetchWaveform];
    
    [self configureUI];
    
    // song view
    self.playPauseButton = [[RSPlayPauseButton alloc] init];
    self.playPauseButton.animationStyle = RSPlayPauseButtonAnimationStyleSplitAndRotate;
    self.playPauseButton.tintColor = [UIColor whiteColor];
    
    self.playPauseButton.alpha = 0.5f;
    self.songNameLabel.alpha = 0.5f;
    
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
    
    if ([self.titleForStory isEqualToString:@"INTRO"]) { // TODO: ACA PONER EL 1er hijo!
        [UIView animateWithDuration:1
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

-(void)viewDidLayoutSubviews
{
    [self.playPauseButton sizeToFit];
}

-(void)configureUI {
    // title
    self.titleLabel.text = self.titleForStory;
    
    // setup story text
    self.storyTextField.text = self.story;
    CGFloat textSize = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) ? 24 : 16;
    UIFont * font = [UIFont fontWithName:@"HelveticaNeue-Regular" size:textSize];
    self.storyTextField.font = font;
    self.storyTextField.textColor = [UIColor whiteColor];
}

#pragma mark - Setters

-(void)setTitleForStory:(NSString *)titleForStory {
    _titleForStory = titleForStory;
    self.titleLabel.text = titleForStory;
}

-(void)fetchTrack {
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] init];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [manager GET:self.trackURL parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            self.track = (NSDictionary *)responseObject;
            self.songNameLabel.text = [self.track objectForKey:@"title"];
    }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[[UIAlertView alloc] initWithTitle:@"Ops! There was an error loading the track, be sure to be connected to the internet"
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

-(void)configureWaveformView {
    self.waveFormImageView.image = [self.waveFormImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.waveFormImageView setTintColor:[AboutMe colorWithHex:0xFB4534]];
    self.waveFormImageView.backgroundColor = [UIColor redColor];
    self.waveFormImageView.clipsToBounds = YES;
    self.waveFormImageView.contentMode = UIViewContentModeTop;
}

-(void)fetchWaveform {
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] init];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager GET:WAVEFORM
      parameters:nil
         success:^(NSURLSessionDataTask *operation, id responseObject) {
            self.waveFormImageView.image = [UIImage imageWithData:(NSData *)responseObject];
            [self configureWaveformView];
    } failure:nil];
}

-(void)fetchStream {
    NSString *streamURL = [NSString stringWithFormat:@"%@?%@", self.streamURL, CLIENT_ID_PARAM];
    AFHTTPSessionManager * manager = [[AFHTTPSessionManager alloc] init];
    [manager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [manager GET:streamURL parameters:nil
                                              success:^(NSURLSessionDataTask *operation, id responseObject) {
                                                  self.trackStream = (NSData *)responseObject;
                                                  
                                                  // setup song view once I have the stream
                                                  self.playPauseButton.alpha = 1.0f;
                                                  self.songNameLabel.alpha = 1.0f;
                                                  self.playPauseButton.enabled = YES;
                                              }
                                              failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                                  [[[UIAlertView alloc] initWithTitle:@"Ops! There was an error loading the track, be sure to be connected to the internet"
                                                                              message:[error localizedDescription]
                                                                             delegate:nil
                                                                    cancelButtonTitle:@"Ok"
                                                                    otherButtonTitles:nil] show];
                                              }];
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

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController {
    return @"";
}

@end
