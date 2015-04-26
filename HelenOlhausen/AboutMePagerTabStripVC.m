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

@implementation AboutMePagerTabStripVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isProgressiveIndicator = YES;
    self.isElasticIndicatorLimit = YES;
    // Do any additional setup after loading the view.
}

-(void)setChildInfo {
    
}


#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
//    TrackListTableViewController *trackListVC = [[TrackListTableViewController alloc] init];
    AboutMe * aboutMe1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe1"];
    aboutMe1.titleForStory = @"DEVELOPMENT + ME";
    AboutMe * aboutMe2 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe1"];
    aboutMe2.titleForStory = @"MUSIC + ME";
    
    AboutMe * aboutMe3 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe1"];
    aboutMe3.titleForStory = @"ME + WORK";
    
    AboutMe * aboutMe4 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe1"];
    aboutMe3.titleForStory = @"ME + SOME SHIT";
    
//    AboutMe * aboutMe5 = [[AboutMe alloc] init];
    
    return @[aboutMe1,aboutMe2,aboutMe3,aboutMe4];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];
    
}


@end
