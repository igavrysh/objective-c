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
@property (nonatomic, retain) NSArray *carwashers;
@property (nonatomic, retain) NSArray *accountants;
@property (nonatomic, retain) NSArray *directors;

@property (nonatomic, retain) IDPThreadSafeQueue *carsQueue;

- (void)initCarwashStructure;
- (void)cleanUpCarwashStructure;

- (id)freeWorkerFromWorkers:(NSArray *)workers;
- (void)assignWorkToCarwasher:(IDPCarwasher *)carwasher checkForState:(BOOL)checkForState;

@end

@implementation IDPCarwash

@dynamic queueEmpty;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    [self cleanUpCarwashStructure];
    
    self.carwashers = nil;
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
        IDPCarwasher *carwasher = [IDPCarwasher object];
        [carwasher addObserver:accountant];
        [carwasher addObserver:self];
        
        return carwasher;
    };
    
    self.carwashers = [NSArray objectsWithCount:kIDPCarwashersCount block:washerFactory];
    
    IDPDirector *director = [IDPDirector object];
    [accountant addObserver:director];
    
    self.accountants = @[accountant];
    self.directors = @[director];
}

- (void)cleanUpCarwashStructure {
    [self.carwashers performBlockWithEachObject:^(IDPCarwasher *washer) {
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
    
    IDPCarwasher *freeCarwasher = nil;
    
    @synchronized(self.carwashers) {
        freeCarwasher = [self freeWorkerFromWorkers:self.carwashers];
        freeCarwasher.state = IDPWorkerBusy;
    }
    
    if (freeCarwasher) {
        [self assignWorkToCarwasher:freeCarwasher checkForState:NO];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)assignWorkToCarwasher:(IDPCarwasher *)carwasher checkForState:(BOOL)checkForState {
    @synchronized(carwasher) {
        if (IDPWorkerFree == carwasher.state || !checkForState) {
            carwasher.state = IDPWorkerBusy;
            
            IDPCar *currentCar = [self.carsQueue dequeue];
            if (!currentCar) {
                return;
            }
            
            [carwasher log:@"was assigned" withObject:currentCar];
            
            [carwasher performSelectorInBackground:@selector(performWorkInBackgroundWithObject:) withObject:currentCar];
        }
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

- (void)workerDidBecomeFree:(IDPWorker *)worker {
    [self assignWorkToCarwasher:(IDPCarwasher *)worker checkForState:YES];
}

@end
