//
//  TWTwoteViewController.m
//  Twote.io
//
//  Created by Marcus Kida on 21.05.13.
//  Copyright (c) 2013 Twote.io. All rights reserved.
//

#import "TWTwoteViewController.h"

@interface TWTwoteViewController () <TWChartDelegate>
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
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void) viewDidAppear:(BOOL)animated
{
    // Retrive Twote details
    TWActivityView* activityView = [[TWActivityView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 4) andActivityBar:[UIImage imageNamed:@"ActivityBar"]];
    [activityView start];
    [_barChart addSubview:activityView];
    
    [[TWDataController sharedInstance] twoteWithName:_twote.twote
                                       andCompletion:^(BOOL success, TWTwote *twote) {
                                           if(success)
                                           {
                                               _twote = twote;
                                               _barChart.color = [UIColor colorWithRed:192.0/255.0 green:169.0/255.0 blue:43.0/255.0 alpha:1.0];
                                               _barChart.delegate = self;
                                               
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
                                               _barChart.backgroundColor = [UIColor whiteColor];
                                               [_barChart setNeedsDisplay];
                                               
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

#pragma mark - ChartDelegate
- (void) chartDidSelectButtonItemAtIndex:(NSInteger)index
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *socialComposeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        SLComposeViewControllerCompletionHandler completionHandler =
        ^(SLComposeViewControllerResult result){
            
            [socialComposeVc dismissViewControllerAnimated:YES completion:nil];
            
            if(result == SLComposeViewControllerResultDone)
            {
                [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Success", nil)
                                            message:NSLocalizedString(@"Your vote has been posted successfully!\nThank you very much.", nil)
                                           delegate:nil
                                  cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                  otherButtonTitles:nil] show];
            }
        };
        
        [socialComposeVc setInitialText:
         [NSString stringWithFormat:NSLocalizedString(@"i just #twote #%@ #%@", nil),
          [_twote.twote lowercaseString],
          [[[_twote.votes allKeys] objectAtIndex:index] lowercaseString]
          ]
         ];
        [socialComposeVc setCompletionHandler:completionHandler];
        [self presentViewController:socialComposeVc animated:YES completion:nil];
    }
}

@end
