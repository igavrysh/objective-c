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

@interface IDPCarwash ()
@property (nonatomic, retain) NSMutableArray *washers;
@property (nonatomic, retain) NSMutableArray *accountants;
@property (nonatomic, retain) NSMutableArray *directors;

@property (nonatomic, retain) IDPQueue *carsQueue;

- (void)initCarwashStructure;

- (IDPCarwasher *)freeWasher;
- (IDPAccountant *)freeAccountant;
- (IDPDirector *)freeDirector;

- (void)addCarwasher:(IDPCarwasher *)washer;
- (void)removeCarwasher:(IDPCarwasher *)washer;
- (void)removeCarwashers;

- (void)addAccountant:(IDPAccountant *)accountant;
- (void)removeAccountant:(IDPCarwasher *)accountant;
- (void)removeAccountants;

- (void)addDirector:(IDPDirector *)director;
- (void)removeDirector;

- (BOOL)addWorker:(IDPWorker *)worker toArray:(NSMutableArray *)array;
- (void)removeWorker:(IDPWorker *)worker;
- (void)removeWorkersInArray:(NSMutableArray *)workers;
@end

@implementation IDPCarwash

@dynamic queueEmpty;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void) dealloc {
    [self removeCarwashers];
    [self removeAccountants];
    [self removeDirector];
    
    self.washers = nil;
    self.accountants = nil;
    self.directors = nil;
    
    self.carsQueue = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    
    self.carsQueue = [IDPQueue object];
    self.accountants = [NSMutableArray object];
    self.washers = [NSMutableArray object];
    self.directors = [NSMutableArray object];
    
    [self initCarwashStructure];
    
    return self;
}

- (void)initCarwashStructure {
    IDPDirector *director = [IDPDirector object];
    IDPAccountant *accountant = [IDPAccountant object];
    IDPCarwasher *carwasher = [IDPCarwash object];
    
    accountant.workerDelegate = director;
    carwasher.workerDelegate = accountant;
    
    [self addDirector:director];
    [self addAccountant:accountant];
    [self addCarwasher:carwasher];
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
        IDPCar *currentCar = [self.carsQueue dequeue];
        
        if (!currentCar) {
            return;
        }
        
        IDPCarwasher *washer = [self freeWasher];
        [washer processObject:currentCar];
    }
}

#pragma mark -
#pragma mark Private Methods

- (IDPCarwasher *)freeWasher {
    return [self.washers randomObject];
}

- (IDPAccountant *)freeAccountant {
    return [self.accountants randomObject];
}

- (IDPDirector *)freeDirector {
    return self.directors[0];
}

- (void)addCarwasher:(IDPCarwasher *)washer {
    [self addWorker:washer toArray:self.washers];
}

- (void)removeCarwasher:(IDPCarwasher *)washer {
    [self removeWorker:washer];
}

- (void)removeCarwashers {
    [self removeWorkersInArray:self.washers];
}

- (void)addAccountant:(IDPAccountant *)accountant {
    [self addWorker:accountant toArray:self.accountants];
}

- (void)removeAccountant:(IDPCarwasher *)accountant {
    [self removeWorker:accountant];
}

- (void)removeAccountants {
    [self removeWorkersInArray:self.accountants];
}

- (void)addDirector:(IDPDirector *)director {
    if ([self.directors count]) {
        return;
    }
    
    [self addWorker:director toArray:self.directors];
}

- (void)removeDirector {
    if (![self.directors count]) {
        return;
    }
    
    [self removeWorker:self.directors[0]];
}

- (BOOL)addWorker:(IDPWorker *)worker toArray:(NSMutableArray *)array{
    [array addObject:worker];
    
    return NO;
}

- (void)removeWorker:(IDPWorker *)worker {
    if (!worker) {
        return;
    }
    
    [self.directors removeObject:worker];
    [self.washers removeObject:worker];
    [self.accountants removeObject:worker];
}

- (void)removeWorkersInArray:(NSMutableArray *)workers {
    for (IDPWorker *worker in workers) {
        [self removeWorker:worker];
    }
}

@end
