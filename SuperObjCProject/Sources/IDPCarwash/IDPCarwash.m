//
//  IDPCarwash.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwash.h"

#import "NSObject+IDPObject.h"

#import "IDPCar.h"
#import "IDPRoom.h"
#import "IDPBuilding.h"
#import "IDPCarwasher.h"
#import "IDPAccountant.h"
#import "IDPDirector.h"
#import "IDPCarwashRoom.h"

@interface IDPCarwash ()
@property (nonatomic, retain) IDPBuilding *prodBuilding;
@property (nonatomic, retain) IDPBuilding *adminBuilding;

@property (nonatomic, retain) NSMutableArray *washers;
@property (nonatomic, retain) NSMutableArray *accountants;
@property (nonatomic, retain) IDPDirector *director;

@property (nonatomic, retain) NSMutableArray *carsQueue;

- (void)initCarwashStructure;

- (IDPCar *)getCarFromQueue;

- (void)addCarwasher:(IDPCarwasher *)washer;
- (void)removeCarwasher:(IDPCarwasher *)washer;
- (void)removeAllCarwashers;

- (void)addAccountant:(IDPAccountant *)accountant;
- (void)removeAccountant:(IDPCarwasher *)accountant;
- (void)removeAllAccountants;

- (void)addDirector:(IDPDirector *)director;
- (void)removeDirector;

- (void)addWorkerToBuildings:(IDPWorker *)worker;
- (void)removeWorkerFromBuildings:(IDPWorker *)worker;
- (IDPBuilding *)getBuildingForWorker:(IDPWorker *)worker;
@end

@implementation IDPCarwash

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void) dealloc {
    [self removeAllCarwashers];
    [self removeAllAccountants];
    [self removeDirector];
    
    self.washers = nil;
    self.accountants = nil;
    self.director = nil;
    
    self.prodBuilding = nil;
    self.adminBuilding = nil;
    
    self.carsQueue = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.carsQueue = [NSMutableArray new];
        
        [self initCarwashStructure];
    }
    
    return self;
}

- (void)initCarwashStructure {
    self.adminBuilding = [IDPBuilding new];
    [self.adminBuilding addRoom:[IDPRoom new]];
    [self addDirector:[IDPDirector new]];
    [self addAccountant:[IDPAccountant new]];
    
    self.prodBuilding = [IDPBuilding new];
    [self.prodBuilding addRoom:[IDPCarwashRoom new]];
    [self addCarwasher:[IDPCarwasher new]];
}

#pragma mark -
#pragma mark Accessors Methods

#pragma mark -
#pragma mark Public Methods

- (void)addCarToQueue:(IDPCar *)car {
    if (!car) {
        return;
    }
    
    [self.carsQueue addObject:car];
}

- (IDPCar *)operate {
    return nil;
}

#pragma mark -
#pragma mark Private Methods

- (IDPCar *)getCarFromQueue {
    if (0 == [self.carsQueue count]) {
        return nil;
    }
    
    IDPCar *car = [self.carsQueue objectAtIndex:0];
    
    [self.carsQueue removeObjectAtIndex:0];
    
    return car;
}

- (void)addCarwasher:(IDPCarwasher *)washer {
    if (!washer) {
        return;
    }
    
    [self addWorkerToBuildings:washer];
    [self.washers addObject:washer];
}

- (void)removeCarwasher:(IDPCarwasher *)washer
{
    [self removeWorkerFromBuildings:washer];
    [self.washers removeObject:washer];
}

- (void)removeAllCarwashers {
    for (IDPCarwasher *washer in self.washers) {
        [self removeWorkerFromBuildings:washer];
        [self.washers removeObject:washer];
    }
}

- (void)addAccountant:(IDPAccountant *)accountant {
    if (!accountant) {
        return;
    }
    
    [self addWorkerToBuildings:accountant];
    [self.accountants addObject:accountant];
}

- (void)removeAccountant:(IDPCarwasher *)accountant {
    [self removeWorkerFromBuildings:accountant];
    [self.washers removeObject:accountant];
}

- (void)removeAllAccountants {
    for (IDPAccountant *accountant in self.accountants) {
        [self removeWorkerFromBuildings:accountant];
        [self.accountants removeObject:accountant];
    }
}

- (void)addDirector:(IDPDirector *)director {
    if (director) {
        return;
    }
    
    [self addWorkerToBuildings:director];
    self.director = director;
}

- (void)removeDirector {
    [self removeWorkerFromBuildings:self.director];
    self.director = nil;
}

- (void)addWorkerToBuildings:(IDPWorker *)worker {
    IDPBuilding *building = [self getBuildingForWorker:worker];
    
    if (nil == building) {
        return;
    }
    
    [building addWorkerToFirstNonFilledRoom:worker];
}

- (void)removeWorkerFromBuildings:(IDPWorker *)worker {
    IDPBuilding *building = [self getBuildingForWorker:worker];
    
    if (nil == building) {
        return;
    }
    
    [building removeWorker:worker];
}

- (IDPBuilding *)getBuildingForWorker:(IDPWorker *)worker {
    if ([worker isKindOfClass:[IDPAccountant class]]
        || [worker isKindOfClass:[IDPDirector class]] ) {
        return self.adminBuilding;
    }
    
    return self.prodBuilding;
}

@end
