//
//  AboutMe.m
//  HelenOlhausen
//
//  Created by Helen Olhausen on 4/22/15.
//  Copyright (c) 2015 Helen Olhausen. All rights reserved.
//

#import "AboutMe.h"

@implementation AboutMe

-(void)viewDidLoad {
    [super viewDidLoad];
    UIColor *colour = [[UIColor alloc]initWithRed:57.0/255.0 green:156.0/255.0 blue:52.0/255.0 alpha:1.0];
    self.view.backgroundColor = colour;
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController {
    return @"About Me";
}

@end
