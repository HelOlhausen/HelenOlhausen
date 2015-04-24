//
//  TrackListTableViewController.m
//  HelenOlhausen
//
//  Created by Helen Olhausen on 4/21/15.
//  Copyright (c) 2015 Helen Olhausen. All rights reserved.
//

#import "TrackListTableViewController.h"
#import "HelenHTTPSessionManager.h"
#import "Constants.h"
#import "NSObject+Additions.h"

@interface TrackListTableViewController ()
@property (nonatomic) NSIndexPath * previousIndex;
@end

@implementation TrackListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchTracks];
}

-(void)setTracks:(NSArray *)tracks {
    _tracks = tracks;
    [self.tableView reloadData];
}

-(void)fetchTracks {
    
    [[HelenHTTPSessionManager sharedClient] getTracksWithSuccess:^(NSURLSessionDataTask *operation, id responseObject) {
        self.tracks = (NSArray *)responseObject;
    }
                                                         failure:^(NSURLSessionDataTask *operation, NSError *error) {
                                                             [[[UIAlertView alloc] initWithTitle:@"Ops! There was an error loading the tracks"
                                                                                         message:[error localizedDescription]
                                                                                        delegate:nil
                                                                               cancelButtonTitle:@"Ok"
                                                                               otherButtonTitles:nil] show];
                                                         }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.tracks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *track = [self.tracks objectAtIndex:indexPath.row];
    cell.textLabel.text = [track objectForKey:@"title"];
    NSString * trackArtWork = [[track objectForKey:@"artwork_url"] valueOrNil];
    
    if (trackArtWork != nil) {
    NSURL *imageURL = [NSURL URLWithString:trackArtWork];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
        });
    });
    }
    return cell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.previousIndex == indexPath) {
        [self.player stop];
        return;
    }
    self.previousIndex = indexPath;
    
    NSDictionary *track = [self.tracks objectAtIndex:indexPath.row];
    NSString *stream = [track objectForKey:@"stream_url"];
    NSString *streamURL = [NSString stringWithFormat:@"%@?%@", stream, CLIENT_ID_PARAM];
    
    [[HelenHTTPSessionManager sharedClient] getStream:streamURL
            success:^(NSURLSessionDataTask *operation, id responseObject) {
                    NSError *playerError;
                    self.player = [[AVAudioPlayer alloc] initWithData:(NSData *)responseObject error:&playerError];
                    [self.player prepareToPlay];
                    [self.player play];
                }
            failure:^(NSURLSessionDataTask *operation, NSError *error) {
                    [[[UIAlertView alloc] initWithTitle:@"Ops! There was an error playing the track"
                                          message:[error localizedDescription]
                                         delegate:nil
                                cancelButtonTitle:@"Ok"
                                otherButtonTitles:nil] show];
    }];
    
}

- (NSString *)titleForPagerTabStripViewController:(XLPagerTabStripViewController *)pagerTabStripViewController {
    return @"Helen";
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
