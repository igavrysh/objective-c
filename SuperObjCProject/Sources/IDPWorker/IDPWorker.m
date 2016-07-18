//
//  IDPWorker.m
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPWorker.h"

#import "IDPRandom.h"
#import "IDPThreadSafeQueue.h"
#import "IDPGCDQueue.h"

#import "NSObject+IDPObject.h"
#import "NSString+IDPRandomName.h"

static float const kIDPWorkerMaxSalary          = 100;
static float const kIDPWorkerMaxCapital         = 100000;

static NSUInteger const kIDPWorkerMaxExperience = 10;

@interface IDPWorker ()
@property (nonatomic, assign)   float       cash;
@property (nonatomic, retain)   IDPGCDQueue *gcdQueue;

@end

@implementation IDPWorker

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    self.gcdQueue = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    
    self.salary = IDPRandomFloatWithMinAndMaxValue(0, kIDPWorkerMaxSalary);
    self.capital = IDPRandomFloatWithMinAndMaxValue(0, kIDPWorkerMaxCapital);
    self.experience = IDPRandomUIntWithMaxValue(kIDPWorkerMaxExperience);
    self.gcdQueue = [IDPGCDQueue gcdSerialQueueWithName:[NSString randomName]];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(id<IDPCashOwner>)object {
    [self.gcdQueue executeWithBlock:^{
        [self performWorkWithObject:object];
    } finishBlock:^{
        [self finishProcessingObject:object];
        [self finishProcessing];
    }];
}

- (void)performWorkWithObject:(IDPWorker *)worker {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)finishProcessingObject:(IDPWorker *)worker {
    if ([worker isKindOfClass:[IDPWorker class]]) {
       worker.state = IDPWorkerFree;
    }
}

- (void)finishProcessing {
    self.state = IDPWorkerPending;
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
    @synchronized(self) {
        float cashOwned = self.cash;
        float cashToGive = cashOwned > cash ? cash : cashOwned;
        self.cash = cashOwned - cashToGive;
        
        return cashToGive;
    }
}

- (void)log:(NSString *)info {
    NSLog(@"%@ :%@ %@", [self class], self, info);
}

- (void)log:(NSString *)info withObject:(id)object {
    NSLog(@"%@ :%@ %@ %@: %@ ", [self class], self, info, [object class], object);
}

#pragma mark -
#pragma mark IDPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    switch (state) {
        case IDPWorkerBusy:
            return @selector(workerDidBecomeBusy:);
            
        case IDPWorkerFree:
            return @selector(workerDidBecomeFree:);
            
        case IDPWorkerPending:
            return @selector(workerDidBecomePending:);
            
        default:
            return [super selectorForState:state];
    }
}

@end
