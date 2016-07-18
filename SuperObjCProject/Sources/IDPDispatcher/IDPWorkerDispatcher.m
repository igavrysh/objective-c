//
//  IDPWorkerDispatcher.m
//  SuperObjCProject
//
//  Created by Ievgen on 7/11/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPWorkerDispatcher.h"

#import "IDPThreadSafeQueue.h"

#import "NSObject+IDPObject.h"
#import "NSArray+IDPArrayEnumerator.h"
#import "IDPGCDQueue.h"

#import "IDPWorker.h"
#import "IDPDirector.h"
#import "IDPAccountant.h"
#import "IDPCarwasher.h"

@interface IDPWorkerDispatcher()
@property (nonatomic, retain)                           IDPThreadSafeQueue  *objectsQueue;
@property (nonatomic, retain)                           NSArray             *workers;
@property (nonatomic, readonly, getter=isQueueEmpty)    BOOL                queueEmpty;
@property (nonatomic, retain)                           IDPGCDQueue         *gcdQueue;

- (void)cleanUpWorkersObservers;

- (IDPWorker *)freeWorker;
- (IDPWorker *)reservedWorker;
- (void)assignWorkToWorker:(IDPWorker *)worker;

@end

@implementation IDPWorkerDispatcher

@dynamic queueEmpty;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)dispatcherWithName:(NSString *)name workers:(NSArray *)workers {
    return [[[self alloc] initWithName:name workers:workers] autorelease];
}

#pragma mark -
#pragma mark Accessors Methods

- (BOOL)isQueueEmpty {
    return self.objectsQueue.count == 0;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.objectsQueue = nil;
    
    [self cleanUpWorkersObservers];
    self.workers = nil;
    
    [super dealloc];
}

- (instancetype)initWithName:(NSString *)name workers:(NSArray *)workers {
    self = [super init];
    if (self) {
        self.objectsQueue = [IDPThreadSafeQueue object];
        self.workers = [[workers copy] autorelease];
        
        [self.workers performBlockWithEachObject:^(IDPWorker *worker) {
            [worker addObserver:self];
        }];
        
        self.gcdQueue = [IDPGCDQueue gcdSerialQueueWithName:name];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(id<IDPCashOwner>)object {
    [self.gcdQueue executeWithBlock:^{
        [self.objectsQueue enqueue:object];
        
        IDPWorker *worker = [self reservedWorker];
        
        [self assignWorkToWorker:worker];
    }];
}

- (BOOL)isWorkerInProcessors:(IDPWorker *)worker {
    return [self.workers containsObject:worker];
}

#pragma mark -
#pragma mark Private Methods

- (IDPWorker *)freeWorker {
    NSArray *freeWorkers = [self.workers filteredArrayUsingBlock:^(IDPWorker *worker) {
        return (BOOL)(IDPWorkerFree == worker.state);
    }];
    
    return [freeWorkers firstObject];
}

- (IDPWorker *)reservedWorker {
    IDPWorker *worker = [self freeWorker];
    
    worker.state = IDPWorkerBusy;
    
    return worker;
}

- (void)assignWorkToWorker:(IDPWorker *)worker {
    if (!worker) {
        return;
    }
    
    id object = [self.objectsQueue dequeue];
    
    if (!object) {
        worker.state = IDPWorkerFree;
        return;
    }
    
    [worker log:@"was assigned" withObject:object];
    
    [worker processObject:object];
}

- (void)cleanUpWorkersObservers {
    [self.workers performBlockWithEachObject:^(IDPWorker *worker) {
        [worker removeObserver:self];
    }];
}

#pragma mark -
#pragma mark IDPWorkerObserver

- (void)workerDidBecomeFree:(IDPWorker *)worker {
    [self.gcdQueue executeWithBlock:^{
        if ([self isWorkerInProcessors:worker]
            && ![self isQueueEmpty]
            && IDPWorkerFree == worker.state)
        {
            worker.state = IDPWorkerBusy;
            
            [self assignWorkToWorker:worker];
        }
    }];
}

- (void)workerDidBecomePending:(IDPWorker *)worker {
    if (![self isWorkerInProcessors:worker]) {
        [self processObject:worker];
    }
}

@end
