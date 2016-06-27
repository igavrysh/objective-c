//
//  IDPCar.m
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCar.h"
#import "IDPRandom.h"

static const float kIDPCarwashPrice = 5;

@interface IDPCar ()
@property (nonatomic, assign) float cash;

@end

@implementation IDPCar

#pragma mark -
#pragma mark Initializtions and Deallocations

- (id)init {
    self = [super init];
    
    self.cash = kIDPCarwashPrice;
    self.dirty = YES;
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

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
