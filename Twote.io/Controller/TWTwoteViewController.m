//
//  TWTwoteViewController.m
//  Twote.io
//
//  Created by Marcus Kida on 21.05.13.
//  Copyright (c) 2013 Twote.io. All rights reserved.
//

#import "TWTwoteViewController.h"

#import "UIBarButtonItem+FlatUI.h"

@interface TWTwoteViewController ()
{
    IBOutlet TWChart *_barChart;
    TWTwote *_twote;
}
@end

@implementation TWTwoteViewController

@synthesize twote = _twote;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[TWDataController sharedInstance] twoteWithName:_twote.twote
                                       andCompletion:^(BOOL success, TWTwote *twote) {
                                           if(success)
                                           {
                                               _twote = twote;
                                               _barChart.color = [UIColor colorWithRed:0.910 green:0.808 blue:0.247 alpha:1.000];
                                               
                                               NSMutableArray *aRefs = [[NSMutableArray alloc] init];
                                               NSMutableArray *aVals = [[NSMutableArray alloc] init];
                                               
                                               for (NSString *key in [_twote.votes allKeys])
                                               {
                                                   int value = [[_twote.votes objectForKey:key] intValue];
                                                   [aRefs addObject:key];
                                                   [aVals addObject:[NSNumber numberWithInt:value]];
                                               }
                                               _barChart.refs = aRefs;
                                               _barChart.vals = aVals;
                                               _barChart.backgroundColor = [UIColor clearColor];
                                               [_barChart setNeedsDisplay];
                                           }
                                       }];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Configure NavigationBar
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor colorWithWhite:0.196 alpha:1.000]];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor colorWithRed:0.910 green:0.808 blue:0.247 alpha:1.000]
                                  highlightedColor:[UIColor yellowColor]
                                      cornerRadius:3];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 35)];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont fontWithName:@"LeagueGothic-Regular" size:26.0f]];
    [titleLabel setTextColor:[UIColor colorWithRed:0.910 green:0.808 blue:0.247 alpha:1.000]];
    [titleLabel setText:_twote.twote];
    [self.navigationItem setTitleView:titleLabel];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], UITextAttributeTextColor,nil]
                                                                                            forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end