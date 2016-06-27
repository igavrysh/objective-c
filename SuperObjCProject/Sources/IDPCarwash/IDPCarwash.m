//
//  IDPCarwash.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwash.h"

#import "IDPRandom.h"
#import "IDPQueue.h"
#import "IDPCar.h"
#import "IDPCarwasher.h"
#import "IDPAccountant.h"
#import "IDPDirector.h"

#import "NSObject+IDPObject.h"
#import "NSArray+IDPArrayEnumerator.h"

const NSUInteger kIDPCarwashersCount = 10;

@interface IDPCarwash ()
@property (nonatomic, retain) NSMutableArray *carwashers;
@property (nonatomic, retain) NSMutableArray *accountants;
@property (nonatomic, retain) NSMutableArray *directors;

@property (nonatomic, retain) IDPQueue *carsQueue;

- (void)initCarwashStructure;

- (IDPWorker *)freeWorkerFromWorkers:(NSArray *)workers;
- (void)assignWorkToCarwasher:(IDPCarwasher *)carwasher;
@end

@implementation IDPCarwash

@dynamic queueEmpty;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void) dealloc {
    [self.carwashers removeAllObjects];
    [self.accountants removeAllObjects];
    [self.directors removeAllObjects];
    
    self.carwashers = nil;
    self.accountants = nil;
    self.directors = nil;
    
    self.carsQueue = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    
    self.carsQueue = [IDPQueue object];
    self.accountants = [NSMutableArray object];
    self.carwashers = [NSMutableArray object];
    self.directors = [NSMutableArray object];
    
    [self initCarwashStructure];
    
    return self;
}

- (void)initCarwashStructure {
    IDPDirector *director = [IDPDirector object];
    IDPAccountant *accountant = [IDPAccountant object];
    
    self.carwashers = [[[NSArray objectsWithCount:kIDPCarwashersCount block:^id{
        IDPCarwasher *carwasher = [IDPCarwasher object];
        [carwasher addObserver:accountant];
        
        return carwasher;
    }] mutableCopy] autorelease];
    
    [accountant addObserver:director];
    [self.accountants addObject:accountant];
    [self.directors addObject:director];
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
    
    while (![self isQueueEmpty]) {
        [self assignWorkToCarwasher:(IDPCarwasher *)[self freeWorkerFromWorkers:self.carwashers]];
    }
}

#pragma mark -
#pragma mark Private Methods

- (IDPWorker *)freeWorkerFromWorkers:(NSArray *)workers {
    id freeWorkerFilter = ^BOOL(IDPWorker* worker, NSDictionary<NSString *,id> *bindings) {
        return worker.state == IDPWorkerFree;
    };
    
    NSArray *freeWorkers = [workers filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:freeWorkerFilter]];
    
    return [freeWorkers count] ? freeWorkers[0] : nil;
}

- (void)assignWorkToCarwasher:(IDPCarwasher *)carwasher {
    IDPCar *currentCar = [self.carsQueue dequeue];
    
    if (!currentCar) {
        return;
    }
    
    [carwasher processObject:currentCar];
}

#pragma mark -
#pragma mark Overloaded Methods

- (void)workerDidBecomeFree:(IDPCarwasher *)carwasher {
    [self assignWorkToCarwasher:carwasher];
}

- (void)workerDidBecomeBusy:(IDPCarwasher *)carwasher {
}

- (void)workerDidBecomePending:(IDPWorker *)carwasher {
}

@end
