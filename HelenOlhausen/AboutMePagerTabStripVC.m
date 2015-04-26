//
//  AboutMePagerTabStripVC.m
//  HelenOlhausen
//
//  Created by Helen Olhausen on 4/22/15.
//  Copyright (c) 2015 Helen Olhausen. All rights reserved.
//

#import "AboutMePagerTabStripVC.h"



#import "TrackListTableViewController.h"




#import "AboutMe.h"
#import "ViewController.h"
#import "Constants.h"

@implementation AboutMePagerTabStripVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isProgressiveIndicator = YES;
    self.isElasticIndicatorLimit = YES;
}

-(void)setChildInfo {
    
}


#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
//    TrackListTableViewController *trackListVC = [[TrackListTableViewController alloc] init];
    // INTRO:
    AboutMe * intro = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe1"];
    intro.titleForStory = @"INTRO";
    intro.streamURL = STREAM_0;
    intro.trackURL = TRACK_0;
    // MAKE SURE TO BE CONNECTED TO THE INTERNET, I NEED TO BRING SOME STUFF FROM THERE :)
    
    AboutMe * aboutMe1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe1"];
    aboutMe1.titleForStory = @"DEVELOPMENT + ME";
    aboutMe1.story = @"Hey Hey! Hello! So I'm a developer, an iOS developer though I developed in some other languages before. I have no special superpower but when I code I do it with passion and dedication, and that probably adds a little something to what I do :)";
    aboutMe1.streamURL = STREAM_1;
    aboutMe1.trackURL = TRACK_1;
    
    AboutMe * aboutMe2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe1"];
    aboutMe2.titleForStory = @"MUSIC + ME";
    aboutMe2.story = @"I started playin music when I was little, I join my school chorus and then when I was 16 it become one of my passions, music goes with me everywhere I go, my guitar and some cool songs... without it I could never code a single line!";
    // poner: want to know more....get souncloud tracks
    aboutMe2.streamURL = STREAM_2;
    aboutMe2.trackURL = TRACK_2;
    
    AboutMe * aboutMe3 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe1"];
    aboutMe3.titleForStory = @"WORK + ME";
    aboutMe3.story = @"I work as an ios developer at a company called Xmartlabs. I joined some groups where I tought objective-c while I was starting to learn it myself... I know I have much more to learn and I'm exited to see what the future bring that is why I'll be awesomely glad to be at the WWDC this year";
    aboutMe3.streamURL = STREAM_3;
    aboutMe3.trackURL = TRACK_3;
    
    AboutMe * aboutMe4 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe1"];
    aboutMe4.titleForStory = @"ME + ME";
    aboutMe4.story = @"I am from a little town called Salto which is at the north of Uruguay, now I live in Montevideo cause I came here to study Engeniiering, my parents still live there";
    aboutMe4.streamURL = STREAM_4;
    aboutMe4.trackURL = TRACK_4;
    
   // THE END:
    AboutMe * end = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe1"];
    end.titleForStory = @"THE END";
    end.streamURL = STREAM_5;
    end.trackURL = TRACK_5;
    
//    AboutMe * aboutMe5 = [[AboutMe alloc] init];
    
    return @[intro,aboutMe1,aboutMe2,aboutMe3,aboutMe4,end];

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    AboutMe * currentChild = (AboutMe*)[self.pagerTabStripChildViewControllers objectAtIndex:self.currentIndex];
    
//    UIDevice.currentDevice().userInterfaceIdiom == .Phone ? 18 : 24
     float constant = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) ? self.view.frame.size.width/3 : self.view.frame.size.width/5;
    
    if (![currentChild.titleForStory isEqualToString:@"INTRO"]) {
        [UIView animateWithDuration:1
                     animations:^{
                         if (currentChild.leadingSpaceTitle.constant != constant) {
                             currentChild.leadingSpaceTitle.constant = constant;
                         } else {
                             currentChild.leadingSpaceTitle.constant = 16;
                         }
                         [currentChild.view setNeedsLayout];
                         [currentChild.view layoutIfNeeded];
                     }
                     completion:nil];
    }
}


@end
