//
//  IDPBuilding.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPBuilding.h"

@interface IDPBuilding ()
@property (nonatomic, retain) NSMutableArray *rooms;

@end

@implementation IDPBuilding

#pragma mark -
#pragma mark Initializtions and Deallocations

- (id)init {
    self = [super init];
    if (self) {
        self.rooms = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods


#pragma mark -
#pragma mark Public Methods

- (void)addRoom:(IDPRoom *)room {
    if (room == nil) {
        return;
    }
    
    [self.rooms addObject:room];
}

- (void)removeRoom:(IDPRoom *)room {
    [self.rooms removeObject:room];
}

- (IDPAccountant *)findAccountant {
    // TODO
    return nil;
}
- (IDPDirector *)findDirector {
    // TODO
    return nil;
}

#pragma mark -
#pragma mark Private Methods


@end
