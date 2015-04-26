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
    
    // INTRO:
    AboutMe * intro = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe"];
    intro.titleForStory = @"INTRO";
    intro.story = @"Hey Hey! Hello again! So for all the sections I added a song for you to check out while I tell you some more about me. There is also a little game for you to have fun!... try to align all the titles, let's see if you can! At the very end there is a bonus track, hope you like it!";
    intro.streamURL = STREAM_0;
    intro.trackURL = TRACK_0;
    
    AboutMe * aboutMe1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe"];
    aboutMe1.titleForStory = @"DEVELOPMENT + ME";
    aboutMe1.story = @"So I'm a developer, an iOS developer though I developed in some other languages before. I have no special superpower but when I code I do it with passion and dedication, and that probably adds a little something to what I do. I study Computer Engineering at the public University in Montevideo. I've been developing iOS apps for a n year now.";
    aboutMe1.streamURL = STREAM_1;
    aboutMe1.trackURL = TRACK_1;
    
    AboutMe * aboutMe2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe"];
    aboutMe2.titleForStory = @"MUSIC + ME";
    aboutMe2.story = @"I started playing music when I was little, my father is a musician I learnt all from him. I joined my school chorus and when I was 16 it become one of my passions, music goes with me everywhere I go, my guitar and some cool songs... without it I could never code a single line! Hope you enjoy the songs I pick for you!";
    // poner: want to know more....get souncloud tracks
    aboutMe2.streamURL = STREAM_2;
    aboutMe2.trackURL = TRACK_2;
    
    AboutMe * aboutMe3 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe"];
    aboutMe3.titleForStory = @"WORK + ME";
    aboutMe3.story = @"I work as an iOS developer at a company called Xmartlabs. We are a team of iOS developers. I develop an app called Orchid Rounding, for nurse rounding in hospitals. I'm a member of a meetup group for iOS where I thought Objective-C while I was starting to learn it myself, now I'm learning swift. I know I have much more to learn and I'm exited to see what the future brings that is why I'll be awesome to go to the WWDC this year!";
    aboutMe3.streamURL = STREAM_3;
    aboutMe3.trackURL = TRACK_3;
    
    AboutMe * aboutMe4 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe"];
    aboutMe4.titleForStory = @"ME + ME";
    aboutMe4.story = @"I grew up in a small town called Salto which is at the north of Uruguay, now I live in Montevideo cause I came here to study Engineering, my parents still live there. I truly belive that we should do what we love the most cause life is short, as Steve whould say \"If you haven't found it yet, keep looking. Don't settle.\"";
    aboutMe4.streamURL = STREAM_4;
    aboutMe4.trackURL = TRACK_4;
    
   // THE END:
    AboutMe * end = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe"];
    end.story = @"\"You can only become truly accomplished at something you love. Don’t make money your goal. Instead pursue the things you love doing and then do them so well that people can’t take their eyes off of you.\" - Maya Angelou.  As the song title says, \"All I want\" is to be there at the WWDC :)";
    end.titleForStory = @"THE END";
    end.streamURL = STREAM_5;
    end.trackURL = TRACK_5;
    
    TrackListTableViewController *trackListVC = [[TrackListTableViewController alloc] init];
    
    return @[intro,aboutMe1,aboutMe2,aboutMe3,aboutMe4,end,trackListVC];

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.currentIndex != 6) {
        AboutMe * currentChild = (AboutMe*)[self.pagerTabStripChildViewControllers objectAtIndex:self.currentIndex];
    
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
}


@end
