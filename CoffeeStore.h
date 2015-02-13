//
//  CoffeeStore.h
//  Where's My Coffee
//
//  Created by Tal Zamirly on 11/02/15.
//  Copyright (c) 2015 Tal Zamirly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoffeeStore : NSObject 

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *postalCode;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;

@property (assign, nonatomic) float distance;


-(id)initWithName:(NSString *)name address:(NSString *)address city:(NSString *)city
            state:(NSString *)state postalCode:(NSString *)postalCode country:(NSString *)country
            distance:(float)distance latitude:(NSString *)latitude longitude:(NSString *)longitude;

@end
