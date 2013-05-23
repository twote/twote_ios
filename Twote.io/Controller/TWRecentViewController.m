//
//  TWRecentViewController.m
//  Twote.io
//
//  Created by Marcus Kida on 21.05.13.
//  Copyright (c) 2013 Twote.io. All rights reserved.
//

#import "TWRecentViewController.h"

#import "TWTwoteViewController.h"

@interface TWTwoteCell ()

@end

@implementation TWTwoteCell

@synthesize twoteLabel;
@synthesize votesLabel;

@end

@interface TWRecentViewController ()
{
    NSArray *_aTwotes;
}
@end

@implementation TWRecentViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Configure NavigationBar
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorWithWhite:0.196 alpha:1.000]];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 35)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont fontWithName:@"LeagueGothic-Regular" size:26.0f]];
    [titleLabel setTextColor:[UIColor colorWithRed:0.910 green:0.808 blue:0.247 alpha:1.000]];
    [titleLabel setText:@"TWOTE.IO"];
    [self.navigationItem setTitleView:titleLabel];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Retrieve recent Twotes
    FPActivityView* activityView = [[FPActivityView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 4) andActivityBar:[UIImage imageNamed:@"ActivityBar"]];
    [activityView start];
    [self.view addSubview:activityView];
    
    [[TWDataController sharedInstance] recentTwotesWithCompletion:^(BOOL success, NSArray *twotes) {
        if(success)
        {
            _aTwotes = [[NSArray alloc] initWithArray:twotes];
            [self.tableView reloadData];
            double delayInSeconds = .5f;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [activityView stop];
                [activityView removeFromSuperview];
            });
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_aTwotes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TWTwoteCell *cell = (TWTwoteCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    TWTwote *twote = (TWTwote *)[_aTwotes objectAtIndex:indexPath.row];
    
    cell.twoteLabel.text = [twote.twote uppercaseString];
    cell.twoteLabel.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:18.0f];
    
    cell.votesLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%1$d votes", @"%1$d votes"), [twote.overallVotes intValue]];
    cell.votesLabel.font = [UIFont fontWithName:@"LeagueGothic-Regular" size:18.0f];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"TwoteDetails"])
    {
        TWTwoteViewController *viewController = (TWTwoteViewController *)segue.destinationViewController;
        viewController.twote = (TWTwote *)[_aTwotes objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}
@end
