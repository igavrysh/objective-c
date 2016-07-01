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
    [self log:@"started cleaning" withObject:car];
    [self cleanCar:car];
    
    [self log:@"is getting money from" withObject:car];
    [self receiveCashFromCashOwner:car];
}

#pragma mark -
#pragma mark Private Methods

- (void)cleanCar:(IDPCar *)car {
    sleep((unsigned int)IDPRandomUIntWithMinAndMaxValue(1, 3));
    
    car.dirty = NO;
    
    [self log:@"finished clearing" withObject:car];
}

@end
