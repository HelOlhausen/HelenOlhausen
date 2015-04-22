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

@implementation AboutMePagerTabStripVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isProgressiveIndicator = YES;
    self.isElasticIndicatorLimit = YES;
    // Do any additional setup after loading the view.
    [self.buttonBarView.selectedBar setBackgroundColor:[UIColor orangeColor]];
    
    
    UICollectionViewLayoutAttributes *attributes = [self.buttonBarView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]];
    CGRect cellRect = attributes.frame;
    [self.buttonBarView.selectedBar setFrame:CGRectMake(cellRect.origin.x, self.buttonBarView.frame.size.height - 5, cellRect.size.width, 5)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}



#pragma mark - XLPagerTabStripViewControllerDataSource

-(NSArray *)childViewControllersForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController
{
    // create child view controllers that will be managed by XLPagerTabStripViewController
    TrackListTableViewController *trackListVC = [[TrackListTableViewController alloc] init];
    AboutMe * aboutMe = [[AboutMe alloc] init];
    return @[trackListVC, aboutMe];
    
//    NSMutableArray * childViewControllers = [NSMutableArray arrayWithObjects:child_1, child_2, nil];
//    NSUInteger count = [childViewControllers count];
//    for (NSUInteger i = 0; i < count; ++i) {
//        // Select a random element between i and end of array to swap with.
//        NSUInteger nElements = count - i;
//        NSUInteger n = (arc4random() % nElements) + i;
//        [childViewControllers exchangeObjectAtIndex:i withObjectAtIndex:n];
//    }
//    NSUInteger nItems = 1 + (rand() % 8);
//    return [childViewControllers subarrayWithRange:NSMakeRange(0, nItems)];
}


@end
