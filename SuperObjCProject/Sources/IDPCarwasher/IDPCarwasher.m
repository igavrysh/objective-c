//
//  IDPCarwasher.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwasher.h"

@implementation IDPCarwasher

- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}

- (void)cleanCar:(IDPCar *)car {
    car.dirty = NO;
}

- (void)doJob {
    NSLog(@"Car is washed");
}

- (void)processObject:(IDPCar *)car {
    [self cleanCar:car];
    [super receiveCashFromCashOperatingObject:car];
}

@end
