//
//  IDPBuilding.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPBuilding.h"

#import "NSArray+IDPArrayEnumerator.h"

@interface IDPBuilding ()
@property (nonatomic, retain) NSMutableArray *mutableRooms;

- (IDPRoom *)freeRoom;

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
    self.mutableRooms = [NSMutableArray new];
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods

- (NSArray *)rooms {
    return [[self.mutableRooms copy] autorelease];
}

- (void)setMutableRooms:(NSMutableArray *)mutableRooms {
    if (_mutableRooms != mutableRooms) {
        if (!mutableRooms) {
            [_mutableRooms performBlockWithEachObject:^(IDPRoom *room) {
                room.building = nil;
            }];
        }
        
        [_mutableRooms release];
        
        _mutableRooms = [mutableRooms retain];
    }
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

- (BOOL)addWorker:(IDPWorker *)worker {
    IDPRoom *room = [self freeRoom];
    if (room) {
        return [room addWorker:worker];
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

- (IDPRoom *)freeRoom {
    for (IDPRoom *room in self.rooms) {
        if (!room.isFull) {
            return room;
        }
    }
    
    return nil;
}

@end
