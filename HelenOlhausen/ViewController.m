//
//  ViewController.m
//  HelenOlhausen
//
//  Created by Helen Olhausen on 4/20/15.
//  Copyright (c) 2015 Helen Olhausen. All rights reserved.
//

#import "ViewController.h"
#import "TrackListTableViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Constants.h"

#import "HelenHTTPSessionManager.h"

@interface ViewController ()
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self playBackAudio];
}

-(void)playBackAudio {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"TryHel" withExtension:@"mp3"];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
}

- (IBAction) getTracks:(id) sender
{
    [[HelenHTTPSessionManager sharedClient] getTracksWithSuccess:^(NSURLSessionDataTask *operation, id responseObject) {
                 TrackListTableViewController *trackListVC = [[TrackListTableViewController alloc] init];
                 trackListVC.tracks = (NSArray *)responseObject;
                 [self presentViewController:trackListVC animated:YES completion:nil];
             }
             failure:^(NSURLSessionDataTask *operation, NSError *error) {
                 [[[UIAlertView alloc] initWithTitle:@"Ops! There was an error loading the tracks"
                                             message:[error localizedDescription]
                                            delegate:nil
                                   cancelButtonTitle:@"Ok"
                                   otherButtonTitles:nil] show];
     }];
}


@end
