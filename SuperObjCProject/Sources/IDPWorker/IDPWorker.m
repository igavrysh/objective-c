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

#import "NSObject+IDPObject.h"

static float const kIDPWorkerMaxSalary = 100;
static float const kIDPWorkerMaxCapital = 100000;
static NSUInteger const kIDPWorkerMaxExperience = 10;

@interface IDPWorker ()
@property (nonatomic, assign) float cash;
@property (nonatomic, retain) IDPThreadSafeQueue *objectsQueue;

- (void)finishProcessingObjectOnMainThread:(id<IDPCashOwner>)object;

@end

@implementation IDPWorker

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    self.objectsQueue = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    
    self.salary = IDPRandomFloatWithMinAndMaxValue(0, kIDPWorkerMaxSalary);
    self.capital = IDPRandomFloatWithMinAndMaxValue(0, kIDPWorkerMaxCapital);
    self.experience = IDPRandomUIntWithMaxValue(kIDPWorkerMaxExperience);
    self.objectsQueue = [IDPThreadSafeQueue object];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(id<IDPCashOwner>)object {
    @synchronized(self) {
        if (IDPWorkerFree != self.state) {
            [self.objectsQueue enqueue:object];
        } else {
            [self performSelectorOnMainThread:@selector(reserveWorker) withObject:nil waitUntilDone:YES];
            
            [self performSelectorInBackground:@selector(performWorkInBackgroundWithObject:) withObject:object];
        }
    }
}

- (void)performWorkInBackgroundWithObject:(id<IDPCashOwner>)object {
    [self performWorkWithObject:object];
    
    [self performSelectorOnMainThread:@selector(finishProcessingObjectOnMainThread:) withObject:object waitUntilDone:NO];
}

- (void)finishProcessingObjectOnMainThread:(id<IDPCashOwner>)object {
    @synchronized(object) {
        if ([object respondsToSelector:@selector(finishProcessing)]) {
            [(IDPWorker *)object finishProcessing];
        }
    }
    
    @synchronized(self.objectsQueue) {
        IDPThreadSafeQueue *objectsQueue = self.objectsQueue;
        if ([objectsQueue count] > 0 ) {
            id object = [objectsQueue dequeue];
            
            [self performSelectorInBackground:@selector(performWorkInBackgroundWithObject:) withObject:object];
        } else {
            [self finishProcessing];
        }
    }
}

- (void)performWorkWithObject:(id<IDPCashOwner>)object {
    [self doesNotRecognizeSelector:_cmd];
}

- (void)finishProcessingObject:(id<IDPCashOwner>)object {
    self.state = IDPWorkerPending;
}

- (void)finishProcessing {
    self.state = IDPWorkerFree;
}

- (void)reserveWorker {
    self.state = IDPWorkerBusy;
}

- (void)receiveCashFromCashOwner:(id<IDPCashOwner>)object {
    float cash = 0;
    
    cash = [object giveAllCash];
    
    [self receiveCash:cash];
}

- (void)receiveCash:(float)cash {
    @synchronized(self) {
        self.cash += cash;
    }
}

- (float)giveAllCash {
    @synchronized(self) {
        return [self giveCash:self.cash];
    }
}

- (float)giveCash:(float)cash {
    @synchronized(self) {
        float cashOwned = self.cash;
        float cashToGive = cashOwned > cash ? cash : cashOwned;
        self.cash = cashOwned - cashToGive;
        
        return cashToGive;
    }
}

#pragma mark -
#pragma mark IDPWorkerDelegate

- (void)workerDidFinishProcessingObject:(IDPWorker *)worker {
    [self processObject:worker];
}

#pragma mark -
#pragma mark Overloaded Methods

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
