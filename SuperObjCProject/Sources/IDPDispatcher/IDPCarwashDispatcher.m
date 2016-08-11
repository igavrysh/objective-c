//
//  IDPCarwashDispatcher.m
//  SuperObjCProject
//
//  Created by Ievgen on 7/13/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwashDispatcher.h"

#import "IDPCarwash.h"
#import "IDPCar.h"
#import "IDPGCDQueue.h"

#import "NSObject+IDPObject.h"
#import "NSArray+IDPArrayEnumerator.h"
#import "NSTimer+IDPExtensions.h"

static const NSUInteger kIDPCarwashDispatcherCarsCount  = 25;
static const NSUInteger kIDPCarsInBatch                 = 10;
static const NSTimeInterval kIDPCarsDeliveryWaitTime    = 0.5;

@interface IDPCarwashDispatcher ()
@property (nonatomic, retain)   IDPCarwash      *carwash;
@property (nonatomic, retain)   NSMutableArray  *cars;
@property (nonatomic, readonly) NSUInteger      carsDelivered;

- (NSArray *)dirtyCars;

@end

@implementation IDPCarwashDispatcher

@dynamic carsDelivered;
@dynamic running;

#pragma mark -
#pragma mark Class methods

+ (instancetype)dispatcherWithCarwash:(IDPCarwash *)carwash {
    return [[[self alloc] initWithCarwash:carwash] autorelease];
}

#pragma mark - 
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.carwash = nil;
    self.cars = nil;
    
    [super dealloc];
}

- (instancetype)initWithCarwash:(IDPCarwash *)carwash {
    self = [super init];
    
    self.carwash = carwash;
    self.cars = [NSMutableArray object];
    
    return self;
}


- (NSUInteger)carsDelivered {
    return [self.cars count];
}

#pragma mark -
#pragma mark Public Methods

- (void)deliverCars {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kIDPCarsDeliveryWaitTime * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        
        NSArray *cars = [self dirtyCars];
        if (cars) {
            [cars performBlockWithEachObject:^(IDPCar *car) {
                IDPAsyncPerformInBackgroundQueue(^{
                    [self.carwash processCar:car];
                    [self.cars addObject:car];
                });
            }];
            
            [self deliverCars];
        }
    });
}

- (NSArray *)dirtyCars {
    NSUInteger count = MIN(kIDPCarsInBatch, kIDPCarwashDispatcherCarsCount - self.carsDelivered);
    
    return [NSArray objectsWithCount:count block:^id { return [IDPCar object]; }];
}

@end
