//
//  IDPRoom.m
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPRoom.h"

#import "IDPBuilding.h"

@interface IDPRoom ()
@property (nonatomic)                       IDPBuilding     *building;
@property (nonatomic, retain)               NSMutableArray  *mutableWorkers;
@property (nonatomic, assign, readonly)     NSUInteger      workersCount;
@property (nonatomic, assign)               NSUInteger      capacity;

@end

@implementation IDPRoom

@dynamic workers;
@dynamic workersCount;
@dynamic filled;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    self.mutableWorkers = nil;
    
    [super dealloc];
}

- (id)init {
    return [self initWithCapacity:10];
}

- (id)initWithCapacity:(NSUInteger)capacity {
    self = [super init];
    if (self) {
        self.mutableWorkers = [NSMutableArray new];
        self.capacity = capacity;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods

- (void)setBuilding:(IDPBuilding *)building {
    _building = building;
}

- (NSUInteger)workersCount {
    return [self.mutableWorkers count];
}

- (BOOL)isFilled {
    return self.capacity <= self.workersCount;
}

- (NSArray *)workers {
    return [[self.mutableWorkers copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods

- (BOOL)addWorker:(IDPWorker *)worker {
    if (nil == worker || self.capacity <= self.workersCount) {
        return NO;
    }
    
    [self.mutableWorkers addObject:worker];
    
    return YES;
}

- (void)removeWorker:(IDPWorker *)worker {
    if ([self.mutableWorkers containsObject:worker]) {
        [self.mutableWorkers removeObject:worker];
    }
}

#pragma mark -
#pragma mark Private Methods


@end
