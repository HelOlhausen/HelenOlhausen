//
//  AboutMe.h
//  HelenOlhausen
//
//  Created by Helen Olhausen on 4/22/15.
//  Copyright (c) 2015 Helen Olhausen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLPagerTabStripViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AboutMe : UIViewController <XLPagerTabStripChildItem>
@property (nonatomic, strong) NSString * titleForStory;
@property (nonatomic, strong) NSString * story;
@property (nonatomic, strong) NSString * songURL;
@property (nonatomic, strong) NSString * waveformURL;
@property (nonatomic, strong) NSString * backColor; //hex
@end
