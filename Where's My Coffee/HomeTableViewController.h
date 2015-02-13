//
//  HomeTableViewController.h
//  Where's My Coffee
//
//  Created by Tal Zamirly on 11/02/15.
//  Copyright (c) 2015 Tal Zamirly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface HomeTableViewController : UITableViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *refreshTableViewBarButtonItem;

- (IBAction)refreshTableViewBarButtonItemPressed:(id)sender;
- (IBAction)sortBarButtonItemPressed:(id)sender;

@end
