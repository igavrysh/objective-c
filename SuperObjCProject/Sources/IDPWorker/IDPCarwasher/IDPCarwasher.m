//
//  IDPCarwasher.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwasher.h"

#import "IDPRandom.h"

@interface IDPCarwasher ()

- (void)cleanCar:(IDPCar *)car;

@end

@implementation IDPCarwasher

#pragma mark -
#pragma mark Overloaded Methods

- (void)performWorkWithObject:(IDPCar *)car {
    NSLog(@"Carwasher: %@ started cleaning car: %@", self, car);
    [self cleanCar:car];
    
    NSLog(@"Carwasher: %@ is getting money from car: %@", self, car);
    [self receiveCashFromCashOwner:car];
}

#pragma mark -
#pragma mark Private Methods

- (void)cleanCar:(IDPCar *)car {
    sleep((unsigned int)IDPRandomUIntWithMinAndMaxValue(1, 3));
    
    car.dirty = NO;
    
    NSLog(@"Carwasher: %@ finished cleaning car: %@", self, car);
}

@end
