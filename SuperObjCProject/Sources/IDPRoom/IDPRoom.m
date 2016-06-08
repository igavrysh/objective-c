//
//  IDPRoom.m
//  SuperObjCProject
//
//  Created by Student 104 on 6/1/16.
//  Copyright (c) 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPRoom.h"

#import "IDPBuilding.h"

static const NSUInteger kIDPRoomDefaultCapacity = 10;

@interface IDPRoom ()
@property (nonatomic, retain)   NSMutableArray  *mutableWorkers;
@property (nonatomic, assign)   NSUInteger      capacity;

@end

@implementation IDPRoom

@dynamic workers;
@dynamic workersCount;
@dynamic full;

#pragma mark -
#pragma mark Class Methods

+ (id)room {
    return [self roomWithCapacity:kIDPRoomDefaultCapacity];
}

+ (id)roomWithCapacity:(NSUInteger)capacity {
    return [[[self alloc] initWithCapacity:capacity] autorelease];
}

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    self.mutableWorkers = nil;
    
    [super dealloc];
}

- (id)init {
    return [self initWithCapacity:kIDPRoomDefaultCapacity];
}

- (id)initWithCapacity:(NSUInteger)capacity {
    self = [super init];
    
    self.mutableWorkers = [NSMutableArray new];
    self.capacity = capacity;
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods

- (NSUInteger)workersCount {
    return [self.mutableWorkers count];
}

- (BOOL)isFull {
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
    [self.mutableWorkers removeObject:worker];
}

@end
