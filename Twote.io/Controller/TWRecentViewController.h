//
//  TWRecentViewController.h
//  Twote.io
//
//  Created by Marcus Kida on 21.05.13.
//  Copyright (c) 2013 Twote.io. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TWDataController.h"

@interface TWTwoteCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *twoteLabel;
@property (nonatomic, retain) IBOutlet UILabel *votesLabel;

@end

@interface TWRecentViewController : UITableViewController

@end
