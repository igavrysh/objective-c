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

- (void)startProcessingObject:(id<IDPCashOwner>)object {
    self.state = IDPWorkerBusy;
}

- (void)performWorkWithObject:(IDPCarwasher *)washer {
    [self receiveCashFromCashOwner:washer];
    washer.state = IDPWorkerFree;
    
    [self calculateProfit];
}

#pragma mark -
#pragma mark Private Methods

- (void)calculateProfit {
    sleep((unsigned int)IDPRandomUIntWithMinAndMaxValue(100, 200));
    
    NSLog(@"Cash is calculated");
}

#pragma mark -
#pragma mark Overloaded Methods

- (void)workerDidBecomePending:(IDPWorker *)carwasher {
    [self processObject:carwasher];
}

@end
