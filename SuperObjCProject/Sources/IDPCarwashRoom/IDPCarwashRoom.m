//
//  IDPCarwashRoom.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/3/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwashRoom.h"

@implementation IDPCarwashRoom

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    self.cars = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)addCar:(IDPCar *)car {
    [self.cars addObject:car];
}


@end
