//
//  IDPDirector.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPDirector.h"

#import "IDPAccountant.h"
#import "IDPRandom.h"

@interface IDPDirector ()

- (void)makeProfit;

@end

@implementation IDPDirector

#pragma mark -
#pragma mark Overloaded Methods

- (void)finishProcessing {
    self.state = IDPWorkerFree;
}

- (void)performWorkWithObject:(IDPAccountant *)accountant {
    [self receiveCashFromCashOwner:accountant];
    
    accountant.state = IDPWorkerFree;
    [self makeProfit];
}

#pragma mark -
#pragma mark Private Methods

- (void)makeProfit {
    sleep((unsigned int)IDPRandomUIntWithMinAndMaxValue(1, 3));
    
    [self log:@"profit is made"];
}


@end
