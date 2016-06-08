//
//  IDPCarwashTest.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/4/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwashTest.h"

#import "IDPCarwash.h"
#import "IDPCar.h"

#import "NSObject+IDPObject.h"

static const NSUInteger kIDPCarwashTestCarsCount = 25;

@interface IDPCarwashTest ()
@property (nonatomic, retain) IDPCarwash *carwash;

@end

@implementation IDPCarwashTest

#pragma mark -
#pragma mark Public Methods

- (void)execute {
    self.carwash = [IDPCarwash new];
    
    for (NSUInteger index = 0; index < kIDPCarwashTestCarsCount; index++) {
        IDPCar *car = [self.carwash operate:[IDPCar object]];
        NSLog(@"%@ is processed", car);
    }
    
    self.carwash = nil;
}

#pragma mark -
#pragma mark Private Methods

@end
