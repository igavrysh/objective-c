//
//  IDPCar.m
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCar.h"
#import "IDPRandom.h"

@interface IDPCar ()

@end

@implementation IDPCar

@synthesize cash = _cash;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (id)init {
    self = [super init];
    
    self.cash = 4.99;
    self.dirty = YES;
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)receiveCash:(id<IDPCashOwner>)object {
    return;
}

- (float)giveAllCash {
    return [self giveCash:self.cash];
}

- (float)giveCash:(float)cash {
    float cashOwned = self.cash;
    float cashToGive = cashOwned > cash ? cash : cashOwned;
    self.cash = cashOwned - cashToGive;
    
    return cashToGive;
}

@end