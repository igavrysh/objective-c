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
static const NSTimeInterval kIDPCarsDeliveryWaitTime = 0.5;

@interface IDPCarwashDispatcher ()
@property (nonatomic, retain)   IDPCarwash  *carwash;
@property (nonatomic, retain)   NSArray     *cars;
@property (nonatomic, assign)   NSTimer     *timer;
@property (nonatomic, assign, getter=isRunning)   BOOL    running;

- (void)start;
- (void)stop;
- (void)onTimer:(NSTimer *)timer;

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
#pragma mark Accessors

- (void)setTimer:(NSTimer *)timer {
    if (_timer == timer) {
        return;
    }
    
    if (_timer && [_timer isValid]) {
        self.running = NO;
        [_timer invalidate];
    }
    
    _timer = timer;
}

#pragma mark -
#pragma mark Public Methods

- (void)start {
    self.running = YES;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kIDPCarsDeliveryWaitTime
                                                  target:self
                                                selector:@selector(onTimer:)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stop {
    self.timer = nil;
}

#pragma mark -
#pragma mark Private Methods

- (void)onTimer:(NSTimer *)timer {
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
