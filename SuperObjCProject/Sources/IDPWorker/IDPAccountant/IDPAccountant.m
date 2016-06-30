//
//  IDPAccountant.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPAccountant.h"

#import "IDPCarwasher.h"
#import "IDPRandom.h"

@interface IDPAccountant ()

- (void)calculateProfit;

@end

@implementation IDPAccountant

#pragma mark -
#pragma mark Overloaded Methods

- (void)performWorkWithObject:(IDPCarwasher *)washer {
    NSLog(@"Accountant: %@ started processing carwasher: %@", self, washer);
    [self receiveCashFromCashOwner:washer];
    
    [self calculateProfit];
}

#pragma mark -
#pragma mark Private Methods

- (void)calculateProfit {
    sleep((unsigned int)IDPRandomUIntWithMinAndMaxValue(1, 3));
    
    NSLog(@"Cash is calculated");
}

#pragma mark -
#pragma mark Overloaded Methods

- (void)workerDidBecomePending:(IDPWorker *)carwasher {
    [self processObject:carwasher];
}

@end
