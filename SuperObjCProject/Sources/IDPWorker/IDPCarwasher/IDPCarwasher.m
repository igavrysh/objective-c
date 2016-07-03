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
@property (nonatomic, assign)   NSUInteger  carsWashed;

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
    //usleep((unsigned int) (5 * IDPRandomUIntWithMinAndMaxValue(1, 3)));
    usleep(10);
    
    car.dirty = NO;
    self.carsWashed += 1;
    
    [self log:@"finished clearing" withObject:car];
}

@end
