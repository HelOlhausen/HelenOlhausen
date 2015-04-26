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
#import "AboutMePagerTabStripVC.h"

#import "HelenHTTPSessionManager.h"

@interface ViewController ()
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.view.backgroundColor =
    [UIColor colorWithPatternImage:[UIImage imageNamed:@"Hel.png"]];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self playBackAudio];
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

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"AboutMeSegue"]) {
//        if ([segue.destinationViewController isKindOfClass:[AboutMePagerTabStripVC class]]) {
//            AboutMePagerTabStripVC *aboutME = (AboutMePagerTabStripVC *)segue.destinationViewController;
//        } else if ([segue.destinationViewController isKindOfClass:[TrackListTableViewController class]]) {
//            TrackListTableViewController * trackList = (TrackListTableViewController*)segue.destinationViewController;
//        }
//    }
//}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController {
    return @"Intro";
}

@end
