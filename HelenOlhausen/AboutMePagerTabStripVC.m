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
//    [self.buttonBarView.selectedBar setBackgroundColor:[UIColor grayColor]];
//    self.navigationController.navigationBar.hidden = YES;
//    
////    UICollectionViewLayoutAttributes *attributes = [self.buttonBarView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
////    CGRect cellRect = attributes.frame;
////    [self.buttonBarView.selectedBar setFrame:CGRectMake(cellRect.origin.x, self.buttonBarView.frame.size.height - 5, cellRect.size.width, 5)];
//    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}



#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
//    TrackListTableViewController *trackListVC = [[TrackListTableViewController alloc] init];
    ViewController * mainVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"IntroView"];
    AboutMe * aboutMe1 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AboutMe1"];
    AboutMe * aboutMe2 = [[AboutMe alloc] init];
    AboutMe * aboutMe3 = [[AboutMe alloc] init];
    AboutMe * aboutMe4 = [[AboutMe alloc] init];
    AboutMe * aboutMe5 = [[AboutMe alloc] init];
    
    return @[mainVC,aboutMe1,aboutMe2,aboutMe3,aboutMe4];

}


@end
