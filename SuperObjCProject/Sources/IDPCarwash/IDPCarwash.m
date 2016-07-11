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
#import "IDPWorkerDispatcher.h"

#import "NSObject+IDPObject.h"
#import "NSArray+IDPArrayEnumerator.h"

const NSUInteger kIDPCarwashersCount = 3;
const NSUInteger kIDPAccountantsCount = 2;
const NSUInteger kIDPDirectorsCount = 1;

@interface IDPCarwash ()
//@property (nonatomic, retain) NSArray *washers;
//@property (nonatomic, retain) NSArray *accountants;
//@property (nonatomic, retain) NSArray *directors;

@property (nonatomic, retain) IDPWorkerDispatcher *washersDispatcher;
@property (nonatomic, retain) IDPWorkerDispatcher *accountantsDispatcher;
@property (nonatomic, retain) IDPWorkerDispatcher *directorsDispatcher;

@property (nonatomic, retain) IDPThreadSafeQueue *carsQueue;

- (void)initCarwashStructure;
- (void)cleanUpCarwashStructure;

- (IDPCarwasher *)reservedFreeWasher;
- (void)assignWorkToCarwasher:(IDPCarwasher *)washer;

@end

@implementation IDPCarwash

@dynamic queueEmpty;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    [self cleanUpCarwashStructure];
    
    self.washersDispatcher = nil;
    self.accountantsDispatcher = nil;
    self.directorsDispatcher = nil;
    
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
    
    IDPWorker *(^workerFactory)(Class class, id<IDPWorkerObserver> observer) = ^id(Class class, id<IDPWorkerObserver> observer) {
        IDPWorker *worker = [class object];
        [worker addObserver:accountant];
        [worker addObserver:self];
        
        return worker;
    };
    
    self.directorsDispatcher =
    [IDPWorkerDispatcher dispatcherWithWorkerCount:kIDPDirectorsCount
                                           factory:^id { return workerFactory([IDPDirector class], self); }];
    
    self.accountantsDispatcher =
    [IDPWorkerDispatcher dispatcherWithWorkerCount:kIDPAccountantsCount
                                           factory:^id { return workerFactory([IDPAccountant class], self.directorsDispatcher); }];
    
    self.washersDispatcher =
    [IDPWorkerDispatcher dispatcherWithWorkerCount:kIDPCarwashersCount
                                           factory:^id { return workerFactory([IDPCarwasher class], self.accountantsDispatcher); }];
}

- (void)cleanUpCarwashStructure {
    
    /*
    [self.washers performBlockWithEachObject:^(IDPCarwasher *washer) {
        [washer removeObservers:@[self.accountants, self]];
    }];
    
    [self.accountants performBlockWithEachObject:^(IDPAccountant *accountant) {
        [accountant removeObservers:@[self.directors]];
    }];
     */
    // TO DO
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
        [self assignWorkToCarwasher:freeCarwasher];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)assignWorkToCarwasher:(IDPCarwasher *)carwasher {
    @synchronized(self.washers) {
        IDPCar *currentCar = [self.carsQueue dequeue];
        if (!currentCar) {
            return;
        }
        
        [carwasher log:@"was assigned" withObject:currentCar];
        
        [carwasher performSelectorInBackground:@selector(performWorkInBackgroundWithObject:)
                                    withObject:currentCar];
    }
}

#pragma mark -
#pragma mark IDPWorkerObserver

- (void)workerDidBecomeFree:(IDPCarwasher *)washer {
    @synchronized(self.washers) {
        if ([self.carsQueue count] > 0) {
            washer.state = IDPWorkerBusy;
            
            [self assignWorkToCarwasher:(IDPCarwasher *)washer];
        }
    }
}

@end
