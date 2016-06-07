//
//  IDPCar.m
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCar.h"
#import "IDPRandom.h"

@implementation IDPCar

@synthesize cash = _cash;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (id)init {
    self = [super init];
    if (self) {
        self.cash = IDPRandomUIntWithMaxValue(10000);
        self.dirty = TRUE;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)receiveCashFromCashOperatingObject:(id<IDPCashOperating>)object {
    return;
}

- (float)giveAllCash {
    float cashToGive = self.cash;
    self.cash = 0;
    
    return cashToGive;
}

@end
