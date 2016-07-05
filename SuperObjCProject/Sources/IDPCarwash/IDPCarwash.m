//
//  IDPCarwash.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwash.h"

#import "IDPRandom.h"
#import "IDPThreadSafeQueue.h"
#import "IDPCar.h"
#import "IDPCarwasher.h"
#import "IDPAccountant.h"
#import "IDPDirector.h"

#import "NSObject+IDPObject.h"
#import "NSArray+IDPArrayEnumerator.h"

const NSUInteger kIDPCarwashersCount = 2;

@interface IDPCarwash ()
@property (nonatomic, retain) NSArray *washers;
@property (nonatomic, retain) NSArray *accountants;
@property (nonatomic, retain) NSArray *directors;

@property (nonatomic, retain) IDPThreadSafeQueue *carsQueue;

- (void)initCarwashStructure;
- (void)cleanUpCarwashStructure;

- (IDPCarwasher *)reservedFreeWasher;
- (id)freeWorkerFromWorkers:(NSArray *)workers;
- (void)assignWorkToCarwasher:(IDPCarwasher *)washer;

@end

@implementation IDPCarwash

@dynamic queueEmpty;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    [self cleanUpCarwashStructure];
    
    self.washers = nil;
    self.accountants = nil;
    self.directors = nil;
    
    self.carsQueue = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];

    self.carsQueue = [IDPThreadSafeQueue object];
    
    [self initCarwashStructure];
    
    return self;
}

- (void)initCarwashStructure {
    IDPAccountant *accountant = [IDPAccountant object];
    
    id washerFactory = ^id {
        IDPCarwasher *washer = [IDPCarwasher object];
        [washer addObserver:accountant];
        [washer addObserver:self];
        
        return washer;
    };
    
    self.washers = [NSArray objectsWithCount:kIDPCarwashersCount block:washerFactory];
    
    IDPDirector *director = [IDPDirector object];
    [accountant addObserver:director];
    
    self.accountants = @[accountant];
    self.directors = @[director];
}

- (void)cleanUpCarwashStructure {
    [self.washers performBlockWithEachObject:^(IDPCarwasher *washer) {
        [washer removeObservers:@[self.accountants, self]];
    }];
    
    [self.accountants performBlockWithEachObject:^(IDPAccountant *accountant) {
        [accountant removeObservers:@[self.directors]];
    }];
}

#pragma mark -
#pragma mark Accessors Methods

- (BOOL)isQueueEmpty {
    return self.carsQueue.count == 0;
}

#pragma mark -
#pragma mark Public Methods

- (void)processCar:(IDPCar *)car {
    [self.carsQueue enqueue:car];
    
    IDPCarwasher *freeCarwasher = [self reservedFreeWasher];
    
    if (freeCarwasher) {
        [self assignWorkToCarwasher:freeCarwasher checkForState:NO];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)assignWorkToCarwasher:(IDPCarwasher *)carwasher checkForState:(BOOL)checkForState {
    @synchronized(self.washers) {
        IDPCar *currentCar = [self.carsQueue dequeue];
        if (!currentCar) {
            return;
        }
        
        [carwasher log:@"was assigned" withObject:currentCar];
        
        [carwasher performSelectorInBackground:@selector(performWorkInBackgroundWithObject:) withObject:currentCar];
    }
}

- (IDPCarwasher *)reservedFreeWasher {
    @synchronized(self.washers) {
        IDPCarwasher *washer = [self freeWorkerFromWorkers:self.washers];
        
        washer.state = IDPWorkerBusy;
        
        return washer;
    }
}

- (id)freeWorkerFromWorkers:(NSArray *)workers {
    NSArray *freeWorkers = [workers filteredArrayUsingBlock:^(IDPWorker *worker) {
        return (BOOL)(IDPWorkerFree == worker.state);
    }];
    
    return [freeWorkers firstObject];
}

#pragma mark -
#pragma mark IDPWorkerObserver

- (void)workerDidBecomeFree:(IDPCarwasher *)washer {
    @synchronized(self.washers) {
        if ([self.carsQueue count] > 0) {
            washer.state = IDPWorkerBusy;
            
            [self assignWorkToCarwasher:(IDPCarwasher *)washer checkForState:YES];
        }
    }
}

@end
