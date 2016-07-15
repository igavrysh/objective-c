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
#import "IDPWorker.h"

#import "IDPDirector.h"
#import "IDPAccountant.h"
#import "IDPCarwasher.h"

@interface IDPWorkerDispatcher()
@property (nonatomic, retain)                           IDPThreadSafeQueue  *objectsQueue;
@property (nonatomic, retain)                           NSArray             *workers;
@property (nonatomic, readonly, getter=isQueueEmpty)    BOOL                queueEmpty;

- (void)cleanUpWorkersObservers;

- (IDPWorker *)freeWorker;
- (IDPWorker *)reservedWorker;
- (void)assignWorkToWorker:(IDPWorker *)worker;

@end

@implementation IDPWorkerDispatcher

@dynamic queueEmpty;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)dispatcherWithWorkers:(NSArray *)workers {    
    return [[[self alloc] initWithWorkers:workers] autorelease];
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

- (instancetype)initWithWorkers:(NSArray *)workers {
    self = [super init];
    if (self) {
        self.objectsQueue = [IDPThreadSafeQueue object];
        self.workers = [[workers copy] autorelease];
        
        [self.workers performBlockWithEachObject:^(IDPWorker *worker) {
            [worker addObserver:self];
        }];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(id<IDPCashOwner>)object {
    [self.objectsQueue enqueue:object];
    
    IDPWorker *worker = [self reservedWorker];
    
    [self assignWorkToWorker:worker];
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
    @synchronized(self.workers) {
        IDPWorker *worker = [self freeWorker];
        
        worker.state = IDPWorkerBusy;
        
        return worker;
    }
}

- (void)assignWorkToWorker:(IDPWorker *)worker {
    @synchronized(self.workers) {
        id object = [self.objectsQueue dequeue];
        
        @synchronized(worker) {
            if (!object) {
                worker.state = IDPWorkerFree;
                return;
            }
        }
        
        if (worker) {
            [worker log:@"was assigned" withObject:object];
            
            [worker performSelectorInBackground:@selector(processObject:)
                                     withObject:object];
        } else {
            [self.objectsQueue enqueue:object];
        }
    }
}

- (void)cleanUpWorkersObservers {
    [self.workers performBlockWithEachObject:^(IDPWorker *worker) {
        [worker removeObserver:self];
    }];
}

#pragma mark -
#pragma mark IDPWorkerObserver

- (void)workerDidBecomeFree:(IDPWorker *)worker {    
    @synchronized(self) {
        if (IDPWorkerFree == worker.state
            && [self isWorkerInProcessors:worker]
            && ![self isQueueEmpty])
        {
            worker.state = IDPWorkerBusy;
            
            [self performSelectorInBackground:@selector(assignWorkToWorker:) withObject:worker];
        }
    }
}

- (void)workerDidBecomePending:(IDPWorker *)worker {
    if (![self isWorkerInProcessors:worker]) {
        [self processObject:worker];
    }
}

@end
