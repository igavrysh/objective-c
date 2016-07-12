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
#import "NSArray+IDPIndex.h"

const NSUInteger kIDPCarwashersCount = 3;
const NSUInteger kIDPAccountantsCount = 2;
const NSUInteger kIDPDirectorsCount = 1;

typedef  NSArray *(^WorkersFactory)(Class class, NSUInteger count, id<IDPWorkerObserver> observer);

@interface IDPCarwash ()

@property (nonatomic, retain) IDPWorkerDispatcher *washersDispatcher;
@property (nonatomic, retain) IDPWorkerDispatcher *accountantsDispatcher;
@property (nonatomic, retain) IDPWorkerDispatcher *directorsDispatcher;

- (void)initCarwashStructure;
- (void)cleanUpCarwashStructure;

@end

@implementation IDPCarwash

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    [self cleanUpCarwashStructure];
    
    self.washersDispatcher = nil;
    self.accountantsDispatcher = nil;
    self.directorsDispatcher = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    
    [self initCarwashStructure];
    
    return self;
}

- (void)initCarwashStructure {
    WorkersFactory workersFactory = ^id(Class class, NSUInteger count, id<IDPWorkerObserver> observer) {
        return [[NSArray objectsWithCount:count block:^id{
            IDPWorker *worker = [class object];
            [worker addObserver:observer];
            [worker addObserver:self];
            
            return worker;
        }] autorelease];
    };
    
    self.directorsDispatcher = [IDPWorkerDispatcher dispatcherWithWorkers:workersFactory([IDPDirector class],
                                                                                         kIDPDirectorsCount,
                                                                                         nil)];
    
    self.accountantsDispatcher = [IDPWorkerDispatcher dispatcherWithWorkers:workersFactory([IDPAccountant class],
                                                                                           kIDPAccountantsCount,
                                                                                           self.directorsDispatcher)];
    
    self.washersDispatcher = [IDPWorkerDispatcher dispatcherWithWorkers:workersFactory([IDPCarwasher class],
                                                                                       kIDPCarwashersCount,
                                                                                       self.accountantsDispatcher)];
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
#pragma mark Public Methods

- (void)processCar:(IDPCar *)car {
    [self.washersDispatcher processObject:car];
}

#pragma mark -
#pragma mark IDPWorkerObserver

- (void)workerDidBecomeBusy:(IDPWorker *)worker {
    [worker log:@"did become busy"];
}

- (void)workerDidBecomePending:(IDPWorker *)worker {
    [worker log:@"did become pending"];
}

- (void)workerDidBecomeFree:(IDPWorker *)worker {
    [worker log:@"did become free"];
}

@end
