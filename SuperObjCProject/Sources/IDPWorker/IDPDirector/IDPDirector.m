//
//  IDPDirector.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPDirector.h"

#import "IDPAccountant.h"

@interface IDPDirector ()

- (void)makeProfit;

@end

@implementation IDPDirector

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(IDPAccountant *)accountant {
    self.state = IDPWorkerBusy;
    
    [self receiveCashFromCashOwner:accountant];
    
    accountant.state = IDPWorkerFree;
    [self makeProfit];
    
    self.state = IDPWorkerFree;
}

#pragma mark -
#pragma mark Private Methods

- (void)makeProfit {
    NSLog(@"Profit is made");
}

#pragma mark -
#pragma mark Overloaded Methods

- (void)workerDidBecomeFree:(IDPAccountant *)accountant {
}

- (void)workerDidBecomeBusy:(IDPAccountant *)accountant {
}

- (void)workerDidBecomePending:(IDPAccountant *)accountant {
    [self processObject:accountant];
    
}

@end
