//
//  IDPCarwash.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwash.h"

#import "NSObject+IDPObject.h"
#import "NSArray+IDPArrayEnumerator.h"

#import "IDPRandom.h"
#import "IDPCar.h"
#import "IDPRoom.h"
#import "IDPBuilding.h"
#import "IDPCarwasher.h"
#import "IDPAccountant.h"
#import "IDPDirector.h"
#import "IDPCarwashRoom.h"

static const NSUInteger kIDPProdRoomCapacity = 10;
static const NSUInteger kIDPAdminRoomCapacity = 3;
static const float      kIDPCarwashPrice = 4.99;

@interface IDPCarwash ()
@property (nonatomic, retain) IDPBuilding *prodBuilding;
@property (nonatomic, retain) IDPBuilding *adminBuilding;

@property (nonatomic, retain) NSMutableArray *washers;
@property (nonatomic, retain) NSMutableArray *accountants;
@property (nonatomic, retain) IDPDirector *director;

@property (nonatomic, retain) NSMutableArray *carsQueue;

- (void)initCarwashStructure;

- (IDPCar *)getCarFromQueue;

- (IDPCarwasher *)getRandomWasher;

- (IDPAccountant *)getRandomAccountant;

- (void)addCarwasher:(IDPCarwasher *)washer;
- (void)removeCarwasher:(IDPCarwasher *)washer;
- (void)removeAllCarwashers;

- (void)addAccountant:(IDPAccountant *)accountant;
- (void)removeAccountant:(IDPCarwasher *)accountant;
- (void)removeAllAccountants;

- (void)addDirector:(IDPDirector *)director;
- (void)removeDirector;

- (BOOL)addWorkerToBuildings:(IDPWorker *)worker;
- (void)removeWorkerFromBuildings:(IDPWorker *)worker;
- (IDPBuilding *)getBuildingForWorker:(IDPWorker *)worker;

@end

@implementation IDPCarwash

@dynamic emptyQueue;

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
        self.accountants = [NSMutableArray new];
        self.washers = [NSMutableArray new];
        
        [self initCarwashStructure];
    }
    
    return self;
}

- (void)initCarwashStructure {
    self.adminBuilding = [IDPBuilding new];
    [self.adminBuilding addRoom:[IDPRoom newWithInitBlock:^IDPRoom *(IDPRoom *room) {
        return [room initWithCapacity:kIDPAdminRoomCapacity];
    }]];
    [self addDirector:[IDPDirector object]];
    [self addAccountant:[IDPAccountant object]];
    
    self.prodBuilding = [IDPBuilding new];
    [self.prodBuilding addRoom:[IDPCarwashRoom newWithInitBlock:^IDPCarwashRoom *(IDPCarwashRoom *carwashRoom) {
        return [carwashRoom initWithCapacity:kIDPProdRoomCapacity];
    }]];
    [self addCarwasher:[IDPCarwasher object]];
}

#pragma mark -
#pragma mark Accessors Methods

- (BOOL)isEmptyQueue {
    return [self.carsQueue count] == 0;
}

#pragma mark -
#pragma mark Public Methods

- (void)addCarToQueue:(IDPCar *)car {
    if (!car) {
        return;
    }
    
    [self.carsQueue addObject:car];
}

- (IDPCar *)operate {
    if ([self.carsQueue count] == 0) {
        return nil;
    }
    
    IDPCar *car = [self getCarFromQueue];
    
    if (!car) {
        return nil;
    }
    
    IDPCarwasher *washer = [self getRandomWasher];
    
    [washer cleanCar:car forPrice:kIDPCarwashPrice];
    
    IDPAccountant *accountant = [self getRandomAccountant];
    
    [accountant receiveCashFromWorker:washer];
    
    [self.director receiveCashFromWorker:accountant];
    
    return car;
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

- (IDPCarwasher *)getRandomWasher {
    if ([self.washers count] == 0) {
        return nil;
    }
    
    return [self.washers objectAtIndex:IDPRandomUIntWithMaxValue([self.washers count] - 1)];
}

- (IDPAccountant *)getRandomAccountant {
    if ([self.accountants count] == 0) {
        return nil;
    }
    
     return [self.accountants objectAtIndex:IDPRandomUIntWithMaxValue([self.accountants count] - 1)];
}

- (void)addCarwasher:(IDPCarwasher *)washer {
    if (!washer) {
        return;
    }
    
    if ([self addWorkerToBuildings:washer]) {
        [self.washers addObject:washer];
    }
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
    
    if ([self addWorkerToBuildings:accountant]) {
        [self.accountants addObject:accountant];
    }
}

- (void)removeAccountant:(IDPCarwasher *)accountant {
    [self.washers removeObject:accountant];
}

- (void)removeAllAccountants {
    for (IDPAccountant *accountant in self.accountants) {
        [self removeWorkerFromBuildings:accountant];
        [self.accountants removeObject:accountant];
    }
}

- (void)addDirector:(IDPDirector *)director {
    if (self.director) {
        return;
    }
    
    if ([self addWorkerToBuildings:director]) {
        self.director = director;
    }
}

- (void)removeDirector {
    [self removeWorkerFromBuildings:self.director];
    self.director = nil;
}

- (BOOL)addWorkerToBuildings:(IDPWorker *)worker {
    IDPBuilding *building = [self getBuildingForWorker:worker];
    
    if (!building) {
        return NO;
    }
    
    return [building addWorkerToFirstNonFilledRoom:worker];
}

- (void)removeWorkerFromBuildings:(IDPWorker *)worker {
    IDPBuilding *building = [self getBuildingForWorker:worker];
    
    if (!building) {
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
