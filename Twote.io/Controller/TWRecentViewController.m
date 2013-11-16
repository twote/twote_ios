//
//  TWRecentViewController.m
//  Twote.io
//
//  Created by Marcus Kida on 21.05.13.
//  Copyright (c) 2013 Twote.io. All rights reserved.
//

#import "TWRecentViewController.h"

#import "TWTwoteViewController.h"

@interface TWRecentViewController ()
{
    NSArray *_aTwotes;
    BOOL _didAppear;
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
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(!_didAppear)
    {
        [self refresh:nil];
        _didAppear = YES;
    }
}

- (IBAction) refresh:(id)sender
{
    // Retrieve recent Twotes
    TWActivityView* activityView = [[TWActivityView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 4) andActivityBar:[UIImage imageNamed:@"ActivityBar"]];
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
                [self.refreshControl endRefreshing];
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
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    TWTwote *twote = (TWTwote *)[_aTwotes objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [twote.twote uppercaseString];
    cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%1$d votes", @"%1$d votes"), [twote.overallVotes intValue]];
    
    return cell;
}

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
