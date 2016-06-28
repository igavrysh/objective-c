//
//  IDPCarwash.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwash.h"

#import "IDPRandom.h"
#import "IDPQueue.h"
#import "IDPCar.h"
#import "IDPCarwasher.h"
#import "IDPAccountant.h"
#import "IDPDirector.h"

#import "NSObject+IDPObject.h"
#import "NSArray+IDPArrayEnumerator.h"

const NSUInteger kIDPCarwashersCount = 10;

@interface IDPCarwash ()
@property (nonatomic, retain) NSMutableArray *carwashers;
@property (nonatomic, retain) NSMutableArray *accountants;
@property (nonatomic, retain) NSMutableArray *directors;

@property (nonatomic, retain) IDPQueue *carsQueue;

- (void)initCarwashStructure;

- (IDPCarwasher *)freeWasher;
- (IDPAccountant *)freeAccountant;
- (IDPDirector *)freeDirector;
@end

@implementation IDPCarwash

@dynamic queueEmpty;

#pragma mark -
#pragma mark Initializtions and Deallocations

- (void) dealloc {
    [self.carwashers removeAllObjects];
    [self.accountants removeAllObjects];
    [self.directors removeAllObjects];
    
    self.carwashers = nil;
    self.accountants = nil;
    self.directors = nil;
    
    self.carsQueue = nil;
    
    [super dealloc];
}

- (id)init {
    self = [super init];
    
    self.carsQueue = [IDPQueue object];
    self.accountants = [NSMutableArray object];
    self.carwashers = [NSMutableArray object];
    self.directors = [NSMutableArray object];
    
    [self initCarwashStructure];
    
    return self;
}

- (void)initCarwashStructure {
    IDPDirector *director = [IDPDirector object];
    IDPAccountant *accountant = [IDPAccountant object];
    
    self.carwashers = [[[NSArray objectsWithCount:kIDPCarwashersCount block:^id{
        IDPCarwasher *carwasher = [IDPCarwasher object];
        carwasher.delegate = accountant;
        
        return carwasher;
    }] mutableCopy] autorelease];
    
    accountant.delegate = director;
    [self.accountants addObject:accountant];
    [self.directors addObject:director];
}

#pragma mark -
#pragma mark Accessors Methods

- (BOOL)isQueueEmpty {
    return self.carsQueue.count == 0;
}

#pragma mark -
#pragma mark Public Methods

- (void)processCar:(IDPCar *)car {
    [self.carsQueue enqueue:car];
    
    while (![self isQueueEmpty]) {
        IDPCar *currentCar = [self.carsQueue dequeue];
        
        if (!currentCar) {
            return;
        }
        
        IDPCarwasher *washer = [self freeWasher];
        [washer processObject:currentCar];
    }
}

#pragma mark -
#pragma mark Private Methods

- (IDPCarwasher *)freeWasher {
    return [self.carwashers randomObject];
}

- (IDPAccountant *)freeAccountant {
    return [self.accountants randomObject];
}

- (IDPDirector *)freeDirector {
    return [self.directors randomObject];
}

@end
