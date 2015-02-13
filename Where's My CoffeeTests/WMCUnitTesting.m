//
//  WMCUnitTesting.m
//  Where's My Coffee
//
//  Created by Tal Zamirly on 13/02/15.
//  Copyright (c) 2015 Tal Zamirly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "CoffeeStore.h"

@interface WMCUnitTesting : XCTestCase

@end

@implementation WMCUnitTesting

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEiffelTowerLocationByDistance{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    BOOL sortAlphabetically = NO;

    //Latitude Longitude coordinates of the Eiffel Tower
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G&client_secret=YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL&ll=48.8582,2.2945&query=coffee&v=20140806&m=foursquare"];
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
    
    if (!sortAlphabetically) {
        NSSortDescriptor *distanceDesc = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES];
        
        resultArray = [resultArray sortedArrayUsingDescriptors:@[distanceDesc]];
    }
    
    CoffeeStore *store = resultArray[0];
    NSString *storeName = [NSString stringWithFormat:@"%@", store.name];
    NSString *storeCountry = [NSString stringWithFormat:@"%@", store.country];
    NSString *storeCity = [NSString stringWithFormat:@"%@", store.city];
    NSString *storeState = [NSString stringWithFormat:@"%@", store.state];
    NSString *storePostalCode = [NSString stringWithFormat:@"%@", store.postalCode];
    
    XCTAssertTrue([@"France" isEqualToString:storeCountry]); //test country
    XCTAssertTrue([@"Coffee & Cigarettes" isEqualToString:storeName]); //test closest store name
    XCTAssertTrue([@"Paris" isEqualToString:storeCity]); //test city
    XCTAssertTrue([@"Île-de-France" isEqualToString:storeState]); //test city
    XCTAssertTrue([@"75007" isEqualToString:storePostalCode]); //test city
    
}

- (void)testEiffelTowerLocationByName{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    BOOL sortAlphabetically = YES;
    
    //Latitude Longitude coordinates of the Eiffel Tower
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G&client_secret=YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL&ll=48.8582,2.2945&query=coffee&v=20140806&m=foursquare"];
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
    
    if (sortAlphabetically) {
        NSSortDescriptor *distanceDesc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        
        resultArray = [resultArray sortedArrayUsingDescriptors:@[distanceDesc]];
    }
    
    CoffeeStore *store = resultArray[0];
    NSString *storeName = [NSString stringWithFormat:@"%@", store.name];
    NSString *storeCountry = [NSString stringWithFormat:@"%@", store.country];
    NSString *storeCity = [NSString stringWithFormat:@"%@", store.city];
    NSString *storeState = [NSString stringWithFormat:@"%@", store.state];
    NSString *storePostalCode = [NSString stringWithFormat:@"%@", store.postalCode];
    
    XCTAssertTrue([@"France" isEqualToString:storeCountry]); //test country
    XCTAssertTrue([@"Bliss Coffee" isEqualToString:storeName]); //test store name
    XCTAssertTrue([@"Paris" isEqualToString:storeCity]); //test city
    XCTAssertTrue([@"Île-de-France" isEqualToString:storeState]); //test city
    XCTAssertTrue([@"75014" isEqualToString:storePostalCode]); //test city
    
}

- (void)testOperaHouseLocationByDistance{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    BOOL sortAlphabetically = NO;

    //Latitude Longitude coordinates of the Eiffel Tower
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G&client_secret=YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL&ll=-33.8587,151.2140&query=coffee&v=20140806&m=foursquare"];
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
    
    if (!sortAlphabetically) {
        NSSortDescriptor *distanceDesc = [NSSortDescriptor sortDescriptorWithKey:@"distance" ascending:YES];
        
        resultArray = [resultArray sortedArrayUsingDescriptors:@[distanceDesc]];
    }
    
    CoffeeStore *store = resultArray[0];
    NSString *storeName = [NSString stringWithFormat:@"%@", store.name];
    NSString *storeCountry = [NSString stringWithFormat:@"%@", store.country];
    NSString *storeCity = [NSString stringWithFormat:@"%@", store.city];
    NSString *storeState = [NSString stringWithFormat:@"%@", store.state];
    NSString *storePostalCode = [NSString stringWithFormat:@"%@", store.postalCode];
    
    XCTAssertTrue([@"Australia" isEqualToString:storeCountry]); //test country
    XCTAssertTrue([@"Lavazza Coffee Cart" isEqualToString:storeName]); //test closest store name
    XCTAssertTrue([@"Parramatta" isEqualToString:storeCity]); //test city
    XCTAssertTrue([@"NSW" isEqualToString:storeState]); //test city
    XCTAssertTrue([@"(null)" isEqualToString:storePostalCode]); //test city
    
}

- (void)testOperaHouseLocationByName{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    BOOL sortAlphabetically = YES;
    
    //Latitude Longitude coordinates of the Eiffel Tower
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G&client_secret=YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL&ll=-33.8587,151.214&query=coffee&v=20140806&m=foursquare"];
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
    
    if (sortAlphabetically) {
        NSSortDescriptor *distanceDesc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        
        resultArray = [resultArray sortedArrayUsingDescriptors:@[distanceDesc]];
    }
    
    CoffeeStore *store = resultArray[0];
    NSString *storeName = [NSString stringWithFormat:@"%@", store.name];
    NSString *storeCountry = [NSString stringWithFormat:@"%@", store.country];
    NSString *storeCity = [NSString stringWithFormat:@"%@", store.city];
    NSString *storeState = [NSString stringWithFormat:@"%@", store.state];
    NSString *storePostalCode = [NSString stringWithFormat:@"%@", store.postalCode];
    
    XCTAssertTrue([@"Australia" isEqualToString:storeCountry]); //test country
    XCTAssertTrue([@"Cabrito Coffee Traders" isEqualToString:storeName]); //test store name
    XCTAssertTrue([@"Sydney" isEqualToString:storeCity]); //test city
    XCTAssertTrue([@"NSW" isEqualToString:storeState]); //test city
    XCTAssertTrue([@"2000" isEqualToString:storePostalCode]); //test city
    
}

- (void)testLocationError{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    BOOL sortAlphabetically = YES;
    
    //Latitude Longitude coordinates of the Eiffel Tower
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=ACAO2JPKM1MXHQJCK45IIFKRFR2ZVL0QASMCBCG5NPJQWF2G&client_secret=YZCKUYJ1WHUV2QICBXUBEILZI1DMPUIDP5SHV043O04FKBHL&ll=%@,%@&query=coffee&v=20140806&m=foursquare", nil, nil];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    NSError *error = nil;
    
    @try {
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    }
    @catch (NSException *exception) {
        XCTAssertNotNil(exception); //NSInvalidArgumentException Called
    }
    @finally {
        
    }
    
}





@end