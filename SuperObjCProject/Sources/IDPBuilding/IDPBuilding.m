//
//  IDPBuilding.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPBuilding.h"

@interface IDPBuilding ()
@property (nonatomic, retain) NSMutableArray *mutableRooms;

@end

@implementation IDPBuilding

@dynamic rooms;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    self.mutableRooms = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.mutableRooms = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods

- (NSArray *)rooms {
    return [[self.mutableRooms copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods

- (void)addRoom:(IDPRoom *)room {
    if (nil == room) {
        return;
    }
    
    [self.mutableRooms addObject:room];
}

- (void)removeRoom:(IDPRoom *)room {
    [self.mutableRooms removeObject:room];
}

- (BOOL)addWorker:(IDPWorker *)worker toRoom:(IDPRoom *)room {
    if ([self.rooms containsObject:room]) {
        return [room addWorker:worker];
    }
    return NO;
}

- (BOOL)addWorkerToFirstNonFilledRoom:(IDPWorker *)worker {
    for (IDPRoom *room in self.rooms) {
        if (!room.isFilled) {
            return [room addWorker:worker];
        }
    }
    
    return NO;
}

- (void)removeWorker:(IDPWorker *)worker {
    for (IDPRoom *room in self.rooms) {
        [room removeWorker:worker];
    }
}

#pragma mark -
#pragma mark Private Methods


@end
