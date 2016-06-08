//
//  IDPCarwasher.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwasher.h"

@interface IDPCarwasher ()

- (void)cleanCar:(IDPCar *)car;

@end

@implementation IDPCarwasher

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(IDPCar *)car {
    [self doJob];
    [self cleanCar:car];
    [super receiveCashFromCashOperatingObject:car];
}

#pragma mark -
#pragma mark Private Methods

- (void)cleanCar:(IDPCar *)car {
    car.dirty = NO;
}

- (void)doJob {
    [self printMessage:@"Car is washed"];
}

@end
