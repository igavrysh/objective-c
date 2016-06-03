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
@property (nonatomic)           IDPBuilding     *building;
@property (nonatomic, retain)   NSMutableArray  *workers;
@property (nonatomic, assign)   NSUInteger      capacity;

- (IDPWorker *)findWorkerOfClass:(Class) class;

@end

@implementation IDPRoom

#pragma mark -
#pragma mark Initializtions and Deallocations

- (id)init {
    self = [super init];
    if (self) {
        self.workers = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods

- (void)setBuilding:(IDPBuilding *)building {
    _building = building;
}

#pragma mark -
#pragma mark Public Methods

- (void)addWorker:(IDPWorker *)worker {
    if (self.capacity >= [self.workers count]) {
        return;
    }
    
    [self.workers addObject:worker];
}

- (IDPAccountant *)findAccountant {
    return (IDPAccountant *)[self findWorkerOfClass:[IDPAccountant class]];
}

- (IDPDirector *)findDirector {
    return (IDPDirector *)[self findWorkerOfClass:[IDPDirector class]];
}

#pragma mark -
#pragma mark Private Methods

- (IDPWorker *)findWorkerOfClass:(Class) class {
    for (IDPWorker *worker in self.workers) {
        if ([worker isKindOfClass:class]) {
            return worker;
        }
    }
    
    return nil;
}

@end
