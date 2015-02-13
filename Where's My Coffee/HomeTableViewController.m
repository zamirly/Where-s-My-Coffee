//
//  HomeTableViewController.m
//  Where's My Coffee
//
//  Created by Tal Zamirly on 11/02/15.
//  Copyright (c) 2015 Tal Zamirly. All rights reserved.
//

#import "HomeTableViewController.h"
#import "CoffeeStore.h"
#import "StoreViewController.h"

@interface HomeTableViewController () <UIActionSheetDelegate>

@property (strong, nonatomic) NSMutableArray *storeArray;

@property BOOL didFindLocation; //bool variable to state wether location has been found
@property BOOL sortAlphabetically; //bool variable to state wether to sort alphabetically
@property BOOL sortByDistance; //bool variable to state wether to sort by distance

@end

@implementation HomeTableViewController

-(NSMutableArray *)storeArray{
    if (!_storeArray) {
        _storeArray = [[NSMutableArray alloc] init];
    }
    return _storeArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.toolbarHidden = NO;
    
    //initialise the bool variables
    self.didFindLocation = NO;
    self.sortAlphabetically = NO;
    self.sortByDistance = YES;
    
    [self updateLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBActions
- (IBAction)refreshTableViewBarButtonItemPressed:(id)sender {
    self.didFindLocation = NO;
    
    [self updateLocation];
}

- (IBAction)sortBarButtonItemPressed:(id)sender {
    UIActionSheet *actionsActionSheet = [[UIActionSheet alloc] initWithTitle:@"Sort" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                                 otherButtonTitles:@"By Distance", @"Alphabetically", nil];
    
    [actionsActionSheet showFromToolbar:self.navigationController.toolbar];
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0: //Sort By Distance chosen
            self.sortByDistance = YES;
            self.sortAlphabetically = NO;
            [self sort:@"distance"];
            break;
        case 1: //Sort Alphabetically chosen
            self.sortAlphabetically = YES;
            self.sortByDistance = NO;
            [self sort:@"name"];
            break;
            
        default:
            break;
    }
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //check if location hasn't been found yet, if so, set it to found and stop updating the location
    if (!self.didFindLocation) {
        self.didFindLocation = YES;
        [self.locationManager stopUpdatingLocation];
    }
    
    //get the latitude and longtitude values from current location, send to URL to get the JSON script
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    CLLocation *crnLoc = [locations lastObject];
    NSString *latitudeString = [NSString stringWithFormat:@"%.10f",crnLoc.coordinate.latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%.10f",crnLoc.coordinate.longitude];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G&client_secret=YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL&ll=%@,%@&query=coffee&v=20140806&m=foursquare", latitudeString, longitudeString];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    NSError *error = nil;
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    NSDictionary *responseDictionary = [dataDictionary objectForKey:@"response"];
    NSDictionary *venueDictionary = [responseDictionary objectForKey:@"venues"];
    
    for (NSDictionary *dict in venueDictionary) {
        NSDictionary *locationDictionary = [dict objectForKey:@"location"];
        
        NSString *name = [dict objectForKey:@"name"];
        //store location strings
        NSString *address = [NSString stringWithFormat: @"%@", [locationDictionary objectForKey:@"address"]];
        NSString *city = [NSString stringWithFormat: @"%@", [locationDictionary objectForKey:@"city"]];
        NSString *state = [NSString stringWithFormat: @"%@", [locationDictionary objectForKey:@"state"]];
        NSString *postalCode = [NSString stringWithFormat: @"%@", [locationDictionary objectForKey:@"postalCode"]];
        NSString *country = [NSString stringWithFormat: @"%@", [locationDictionary objectForKey:@"country"]];
        
        NSString *latitude = [NSString stringWithFormat:@"%@", [locationDictionary objectForKey:@"lat"]];
        NSString *longitude = [NSString stringWithFormat:@"%@", [locationDictionary objectForKey:@"lng"]];
        
        NSString *distanceString = [NSString stringWithFormat: @"%@", [locationDictionary objectForKey:@"distance"]];
        float distance = [distanceString floatValue];
        
        //initialise the CoffeeStore object with the values from the JSON script
        CoffeeStore *store = [[CoffeeStore alloc] initWithName:name address:address city:city state:state postalCode:postalCode country:country distance:distance latitude:latitude longitude:longitude];
        
        [resultArray addObject:store];
    }
    
    //check if alphabetical sort is set, if so, sort alphabetically, if not, sort by distance
    if (self.sortAlphabetically) {
        NSSortDescriptor *distanceDesc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        
        self.storeArray = [resultArray sortedArrayUsingDescriptors:@[distanceDesc]];
        [self.tableView reloadData];
    } else {
        NSSortDescriptor *distanceDesc = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES];
         
        self.storeArray = [resultArray sortedArrayUsingDescriptors:@[distanceDesc]];
         [self.tableView reloadData];
    }
    
    [self.tableView reloadData];
}

#pragma mark - helper methods
-(void)updateLocation{
    self.locationManager = [[CLLocationManager alloc]init]; // initializing locationManager
    self.locationManager.delegate = self; // we set the delegate of locationManager to self.
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    
    if (IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];  //requesting location updates
}

//Sort method which is used to sort the array by distance or alphabetically
-(void)sort:(NSString *)sortBy{
    NSLog(@"sort");
    NSSortDescriptor *distanceDesc = [NSSortDescriptor sortDescriptorWithKey:sortBy ascending:YES];
    
    self.storeArray = [self.storeArray sortedArrayUsingDescriptors:@[distanceDesc]];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.storeArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    CoffeeStore *selectedStore = self.storeArray[indexPath.row];
    cell.textLabel.text = selectedStore.name;
    
    NSString *distanceString = [[NSString stringWithFormat:@"%.0f", selectedStore.distance] stringByAppendingString:@"m"];
    cell.detailTextLabel.text = distanceString;
    
    return cell;
}



 #pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Store Chosen"]) {
        //set StoreViewController as the destination view controller
        StoreViewController *targetVC = segue.destinationViewController;
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        CoffeeStore *selectedStore = self.storeArray[path.row];
        
        //set up the variables at the StoreViewController from the selected cell
        targetVC.name = selectedStore.name;
        targetVC.distance = selectedStore.distance;
        targetVC.address = selectedStore.address;
        targetVC.city = selectedStore.city;
        targetVC.country = selectedStore.country;
        targetVC.state = selectedStore.state;
        targetVC.postalCode = selectedStore.postalCode;
        targetVC.latitude = selectedStore.latitude;
        targetVC.longitude = selectedStore.longitude;
    }
}


@end
