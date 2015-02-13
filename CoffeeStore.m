//
//  CoffeeStore.m
//  Where's My Coffee
//
//  Created by Tal Zamirly on 11/02/15.
//  Copyright (c) 2015 Tal Zamirly. All rights reserved.
//

#import "CoffeeStore.h"

@implementation CoffeeStore

//initWithName method, which is used to initialise a CoffeeStore Object
-(id)initWithName:(NSString *)name address:(NSString *)address city:(NSString *)city
            state:(NSString *)state postalCode:(NSString *)postalCode country:(NSString *)country
         distance:(float)distance latitude:(NSString *)latitude longitude:(NSString *)longitude{
    self = [super init];
    if (self) {
        self.name = name;
        self.distance = distance;
        self.address = address;
        self.city = city;
        self.country = country;
        self.postalCode = postalCode;
        self.state = state;
        self.latitude = latitude;
        self.longitude = longitude;
    }
    return self;
}

@end
