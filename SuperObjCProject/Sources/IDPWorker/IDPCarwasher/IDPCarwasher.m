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
    [self cleanCar:car];
    [self receiveCashFromCashOwner:car];
}

#pragma mark -
#pragma mark Private Methods

- (void)cleanCar:(IDPCar *)car {
    car.dirty = NO;
    
    sleep((unsigned int)IDPRandomUIntWithMinAndMaxValue(100, 200));
    
    NSLog(@"Car is washed");
}

@end
