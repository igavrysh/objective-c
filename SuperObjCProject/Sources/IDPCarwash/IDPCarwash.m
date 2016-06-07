//
//  IDPCarwash.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwash.h"

#import "IDPRandom.h"
#import "IDPCar.h"
#import "IDPRoom.h"
#import "IDPBuilding.h"
#import "IDPCarwasher.h"
#import "IDPAccountant.h"
#import "IDPDirector.h"
#import "IDPCarwashRoom.h"

#import "NSObject+IDPObject.h"
#import "NSArray+IDPArrayEnumerator.h"

static const NSUInteger kIDPProdRoomCapacity = 10;
static const NSUInteger kIDPAdminRoomCapacity = 3;
static const float      kIDPCarwashPrice = 4.99;

@interface IDPCarwash ()
@property (nonatomic, retain) IDPBuilding *productionBuilding;
@property (nonatomic, retain) IDPBuilding *administrativeBuilding;

@property (nonatomic, retain) NSMutableArray *washers;
@property (nonatomic, retain) NSMutableArray *accountants;
@property (nonatomic, retain) NSMutableArray *directors;

@property (nonatomic, retain) NSMutableArray *cars;

- (void)initCarwashStructure;

- (IDPCar *)nextCar;

- (IDPCarwasher *)freeWasher;
- (IDPAccountant *)freeAccountant;
- (IDPDirector *)freeDirector;

- (void)addCarwasher:(IDPCarwasher *)washer;
- (void)removeCarwasher:(IDPCarwasher *)washer;
- (void)removeCarwashers;

- (void)addAccountant:(IDPAccountant *)accountant;
- (void)removeAccountant:(IDPCarwasher *)accountant;
- (void)removeAccountants;

- (void)addDirector:(IDPDirector *)director;
- (void)removeDirector;

- (BOOL)addWorker:(IDPWorker *)worker toArray:(NSMutableArray *)array building:(IDPBuilding *)building;
- (void)removeWorker:(IDPWorker *)worker;
- (void)removeWorkersInArray:(NSMutableArray *)workers;
@end

@implementation IDPCarwash

@dynamic emptyQueue;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void) dealloc {
    [self removeCarwashers];
    [self removeAccountants];
    [self removeDirector];
    
    self.washers = nil;
    self.accountants = nil;
    self.directors = nil;
    
    self.productionBuilding = nil;
    self.administrativeBuilding = nil;
    
    self.cars = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.cars = [NSMutableArray new];
        self.accountants = [NSMutableArray new];
        self.washers = [NSMutableArray new];
        self.directors = [NSMutableArray new];
        
        [self initCarwashStructure];
    }
    
    return self;
}

- (void)initCarwashStructure {
    // Why I cannot use here new?
    IDPBuilding *administrativeBuilding = [IDPBuilding object];
    [administrativeBuilding addRoom:[IDPRoom roomWithCapacity:kIDPAdminRoomCapacity]];
    self.administrativeBuilding = administrativeBuilding;
    
    [self addDirector:[IDPDirector object]];
    [self addAccountant:[IDPAccountant object]];
    
    IDPBuilding *productionBuilding = [IDPBuilding object];
    [productionBuilding addRoom:[IDPCarwashRoom roomWithCapacity:kIDPProdRoomCapacity]];
    self.productionBuilding = productionBuilding;
    
    [self addCarwasher:[IDPCarwasher object]];
}

#pragma mark -
#pragma mark Accessors Methods

- (BOOL)isEmptyQueue {
    return [self.cars count] == 0;
}

#pragma mark -
#pragma mark Public Methods

- (void)addCar:(IDPCar *)car {
    if (!car) {
        return;
    }
    
    [self.cars addObject:car];
}

- (IDPCar *)operate {
    if ([self.cars count] == 0) {
        return nil;
    }
    
    IDPCar *car = [self nextCar];
    
    if (!car) {
        return nil;
    }
    
    IDPCarwasher *washer = [self freeWasher];
    [washer processObject:car];
    
    IDPAccountant *accountant = [self freeAccountant];
    [accountant processObject:washer];
    
    IDPDirector *director = [self freeDirector];
    [director processObject:accountant];
    
    return car;
}

#pragma mark -
#pragma mark Private Methods

- (IDPCar *)nextCar {
    if (0 == [self.cars count]) {
        return nil;
    }
    
    IDPCar *car = [[self.cars[0] retain] autorelease];
    
    [self.cars removeObjectAtIndex:0];
    
    return car;
}

- (IDPCarwasher *)freeWasher {
    return [self.washers objectAtRandomIndex];
}

- (IDPAccountant *)freeAccountant {
    return [self.accountants objectAtRandomIndex];
}

- (IDPDirector *)freeDirector {
    return self.directors[0];
}

- (void)addCarwasher:(IDPCarwasher *)washer {
    [self addWorker:washer toArray:self.washers building:self.productionBuilding];
}

- (void)removeCarwasher:(IDPCarwasher *)washer {
    [self removeWorker:washer];
}

- (void)removeCarwashers {
    [self removeWorkersInArray:self.washers];
}

- (void)addAccountant:(IDPAccountant *)accountant {
    [self addWorker:accountant toArray:self.accountants building:self.administrativeBuilding];
}

- (void)removeAccountant:(IDPCarwasher *)accountant {
    [self removeWorker:accountant];
}

- (void)removeAccountants {
    [self removeWorkersInArray:self.accountants];
}

- (void)addDirector:(IDPDirector *)director {
    if ([self.directors count]) {
        return;
    }
    
    [self addWorker:director toArray:self.directors building:self.administrativeBuilding];
}

- (void)removeDirector {
    if (![self.directors count]) {
        return;
    }
    
    [self removeWorker:self.directors[0]];
}

- (BOOL)addWorker:(IDPWorker *)worker toArray:(NSMutableArray *)array building:(IDPBuilding *)building {
    if ([building addWorker:worker]) {
        [array addObject:worker];
    }
    
    return NO;
}

- (void)removeWorker:(IDPWorker *)worker {
    if (!worker) {
        return;
    }
    
    [self.productionBuilding removeWorker:worker];
    [self.administrativeBuilding removeWorker:worker];
    
    [self.directors removeObject:worker];
    [self.washers removeObject:worker];
    [self.accountants removeObject:worker];
}

- (void)removeWorkersInArray:(NSMutableArray *)workers {
    for (IDPWorker *worker in workers) {
        [self removeWorker:worker];
    }
}

@end
