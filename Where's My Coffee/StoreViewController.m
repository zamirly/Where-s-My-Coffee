//
//  StoreViewController.m
//  Where's My Coffee
//
//  Created by Tal Zamirly on 12/02/15.
//  Copyright (c) 2015 Tal Zamirly. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bodyBackground.jpg"]];
    
    //convert the float value to string, and m at the end to symbolize 'meters'
    NSString *distanceString = [[NSString stringWithFormat:@"%.0f",self.distance] stringByAppendingString:@"m"];
    self.distanceLabel.text = distanceString;
    
    //check if an address value has been set, if not, state that it hasn't been provided
    if ([self.address isEqualToString:@"(null)"]) {
        self.address = @"No Address Provided";
    }
    
    //check if a city value has been set, if not, clear the text
    if ([self.city isEqualToString:@"(null)"]) {
        self.city = @"";
    }
    
    //check if a state value has been set, if not, clear the text
    if ([self.state isEqualToString:@"(null)"]) {
        self.state = @"";
    }
    
    //check if a postalCode value has been set, if not, clear the text
    if ([self.postalCode isEqualToString:@"(null)"]) {
        self.postalCode = @"";
    }
    
    //check if a country value has been set, if not, clear the text
    if ([self.country isEqualToString:@"(null)"]) {
        self.country = @"";
    }
    
    //set the Labels text
    self.addressLabel.text = self.address;
    self.storeNameLabel.text = self.name;
    self.cityLabel.text = self.city;
    self.countryLabel.text = self.country;
    self.stateLabel.text = self.state;
    self.postalCodeLabel.text = self.postalCode;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//method called when user presses the 'Open In Maps' button, which opens the map application at the chosen coordinates
- (IBAction)mapsButtonPressed:(id)sender {
    UIApplication *app = [UIApplication sharedApplication];
    
    NSString *coordinates = [NSString stringWithFormat:@"http://maps.apple.com/?ll=%@,%@&z=1000", self.latitude, self.longitude];
    
    [app openURL:[NSURL URLWithString: coordinates]];
}
@end
