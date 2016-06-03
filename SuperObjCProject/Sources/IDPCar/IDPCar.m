//
//  IDPCar.m
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCar.h"

@implementation IDPCar

#pragma mark -
#pragma mark Initializtions and Deallocations

- (id)init {
    self = [super init];
    if (self) {
        self.cash = arc4random_uniform(10000);
        self.dirty = TRUE;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (float)payForServiceWithPrice:(float)price {
    float ownCash = self.cash;
    
    float payment = ownCash - price < 0 ? ownCash : price;

    self.cash -= payment;
    
    return payment;
}

@end
