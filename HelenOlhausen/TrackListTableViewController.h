//
//  TrackListTableViewController.h
//  HelenOlhausen
//
//  Created by Helen Olhausen on 4/21/15.
//  Copyright (c) 2015 Helen Olhausen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "XLPagerTabStripViewController.h"

@interface TrackListTableViewController : UITableViewController <XLPagerTabStripChildItem>

@property (nonatomic, strong) NSArray *tracks;
@property (nonatomic, strong) AVAudioPlayer *player;

@end
