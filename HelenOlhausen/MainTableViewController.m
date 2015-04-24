//
//  MainTableViewController.m
//  HelenOlhausen
//
//  Created by Helen Olhausen on 4/24/15.
//  Copyright (c) 2015 Helen Olhausen. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController()
@property (nonatomic,strong) NSNumber * selectedIndex;
@end

@implementation MainTableViewController

#define kCellHeight 200.0

-(void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)cellIsSelected:(NSNumber*)indexPath {
    // Return whether the cell at the specified index path is selected or not
    //	NSNumber *selectedIndex = [selectedIndexes objectForKey:indexPath];
    //	return selectedIndexx == nil ? FALSE : [selectedIndex boolValue];
    return indexPath == self.selectedIndex;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        [cell.textLabel setText:[NSString stringWithFormat:@"Ooooh click me please!%@", [NSNumber numberWithInteger:[indexPath row]]]];
//    }
//    
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSLog(@"%@",indexPath);
    
    // Deselect cell
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    // Toggle 'selected' state
    BOOL isSelected = ![self cellIsSelected:[NSNumber numberWithInteger:[indexPath row]]];
    NSLog(@"%@",[NSNumber numberWithInteger:[indexPath row]]);
    
    // Store cell 'selected' state keyed on indexPath
    self.selectedIndex = isSelected ? [NSNumber numberWithInteger: [indexPath row]] : 0;
    
//    [CATransaction begin];
    
//    [CATransaction setCompletionBlock:^{
        // animation has finished
//        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    }];
    
    [tableView beginUpdates];
    // do some work
    [tableView endUpdates];
    
//    [CATransaction commit];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self cellIsSelected:[NSNumber numberWithInteger:[indexPath row]]]) {
//        return kCellHeight * 2;
        return tableView.frame.size.height - tableView.frame.size.height/3;
    }
    return kCellHeight;
}

@end
