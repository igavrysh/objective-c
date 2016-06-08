//
//  IDPCarwashRoom.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/3/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwashRoom.h"

@interface IDPCarwashRoom ()
@property (nonatomic, retain) NSMutableArray *mutableCars;

@end

@implementation IDPCarwashRoom

@dynamic cars;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void)dealloc {
    self.mutableCars = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    
    self.mutableCars = [[NSMutableArray alloc] init];
    
    return self;
}

#pragma mark -
#pragma mark Accessors Methods

- (NSArray *)cars {
    return [[self.mutableCars copy] autorelease];
}

#pragma mark -
#pragma mark Public Methods

- (void)addCar:(IDPCar *)car {
    if (nil == car) {
        return;
    }
    
    [self.mutableCars addObject:car];
}

- (void)removeCar:(IDPCar *)car {
    [self.mutableCars removeObject:car];
}


@end
