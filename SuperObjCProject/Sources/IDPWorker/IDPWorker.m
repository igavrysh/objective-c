//
//  IDPWorker.m
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPWorker.h"

#import "IDPRandom.h"

static float const kIDPWorkerMaxSalary = 100;
static float const kIDPWorkerMaxCapital = 100000;
static NSUInteger const kIDPWorkerMaxExperience = 10;

@interface IDPWorker ()
@property (nonatomic, assign) float cash;

@end

@implementation IDPWorker

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    self.delegate = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    
    self.salary = IDPRandomFloatWithMinAndMaxValue(0, kIDPWorkerMaxSalary);
    self.capital = IDPRandomFloatWithMinAndMaxValue(0, kIDPWorkerMaxCapital);
    self.experience = IDPRandomUIntWithMaxValue(kIDPWorkerMaxExperience);
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setDelegate:(IDPWorker *)delegate {
    if (_delegate != delegate) {
        [delegate retain];
        
        if (!_delegate) {
            [_delegate release];
        }
        
        _delegate = delegate;
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(id<IDPCashOwner>) object {
    [self receiveCashFromCashOwner:object];
}

- (void)receiveCashFromCashOwner:(id<IDPCashOwner>)object {
    [self receiveCash:[object giveAllCash]];
}

- (void)receiveCash:(float)cash {
    self.cash += cash;
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

#pragma mark -
#pragma mark IDPWorkerDelegate

- (void)workerDidFinishProcessingObject:(IDPWorker *)worker {
    [self processObject:worker];
}

@end
