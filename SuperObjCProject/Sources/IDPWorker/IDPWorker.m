//
//  IDPWorker.m
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPWorker.h"

#import "IDPRandom.h"

@interface IDPWorker ()

@end

@implementation IDPWorker

@synthesize cash = _cash;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (id)init {
    self = [super init];
    
    self.salary = IDPRandomFloatWithMinAndMaxValue(0, 100);
    self.capital = IDPRandomFloatWithMinAndMaxValue(0, 100000);
    self.experience = IDPRandomUIntWithMaxValue(10);
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(id<IDPCashOwner>) object {
    [self receiveCash:object];
}

- (void)receiveCash:(id<IDPCashOwner>)object {
    self.cash += [object giveAllCash];
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
