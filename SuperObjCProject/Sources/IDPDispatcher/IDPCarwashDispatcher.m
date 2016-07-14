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

#import "NSObject+IDPObject.h"
#import "NSArray+IDPArrayEnumerator.h"

static const NSUInteger kIDPCarwashDispatcherCarsCount = 25;

@interface IDPCarwashDispatcher ()
@property (nonatomic, retain)   IDPCarwash  *carwash;
@property (nonatomic, retain)   NSArray     *cars;
@property (nonatomic, assign)   NSTimer     *timer;

- (void)start;
- (void)stop;
- (void)run:(NSTimer *)timer;

- (void)deliverCar;
- (IDPCar *)dirtyCar;

@end

@implementation IDPCarwashDispatcher

#pragma mark - 
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.carwash = nil;
    self.cars = nil;
    
    [self stop];
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    self.carwash = [IDPCarwash object];
    self.cars = [NSArray objectsWithCount:kIDPCarwashDispatcherCarsCount block:^id { return [IDPCar object]; }];
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)start {
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                      target:self
                                                    selector:@selector(run:)
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

- (void)stop {
    NSTimer *timer = self.timer;
    if (timer && [timer isValid]) {
        [timer invalidate];
    }
    
    self.timer = nil;
}

#pragma mark -
#pragma mark Private Methods

- (void)run:(NSTimer *)timer {
    [self deliverCar];
}

- (void)deliverCar {
    IDPCar *car = [self dirtyCar];
    if (car) {
        [self.carwash performSelectorInBackground:@selector(processCar:) withObject:car];
    } else {
        [self stop];
    }
}

- (IDPCar *)dirtyCar {
    return [[self.cars filteredArrayUsingBlock:^BOOL(IDPCar *car) { return car.isDirty; }] firstObject];
}

@end
