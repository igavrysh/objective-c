//
//  IDPAccountant.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPAccountant.h"

#import "IDPCarwasher.h"

@interface IDPAccountant ()

- (void)calculateProfit;

@end

@implementation IDPAccountant

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(IDPCarwasher *)washer {
    self.state = IDPWorkerBusy;
    
    [self receiveCashFromCashOwner:washer];
    washer.state = IDPWorkerFree;
    
    [self calculateProfit];
    
    self.state = IDPWorkerPending;
}

#pragma mark -
#pragma mark Private Methods

- (void)calculateProfit {
    NSLog(@"Cash is calculated");
}

#pragma mark -
#pragma mark Overloaded Methods

- (void)workerDidBecomePending:(IDPWorker *)carwasher {
    [self processObject:carwasher];
}

@end
