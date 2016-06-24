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
    [self cleanCar:car];
    [self receiveCashFromCashOwner:car];
    
    [self.workerDelegate workerDidFinishProcessingObject:self];
}

#pragma mark -
#pragma mark Private Methods

- (void)cleanCar:(IDPCar *)car {
    car.dirty = NO;
    NSLog(@"Car is washed");
}


@end
