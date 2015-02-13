//
//  StoreViewController.h
//  Where's My Coffee
//
//  Created by Tal Zamirly on 12/02/15.
//  Copyright (c) 2015 Tal Zamirly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : UIViewController

//properties for the store
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *postalCode;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (assign, nonatomic) float distance;

//IBOutlet properties
@property (strong, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *postalCodeLabel;
@property (strong, nonatomic) IBOutlet UILabel *countryLabel;

- (IBAction)mapsButtonPressed:(id)sender;

@end
