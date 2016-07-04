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
    [self log:@"started receiving money form" withObject:accountant];
    
    [self receiveCashFromCashOwner:accountant];
    
    accountant.state = IDPWorkerFree;
    [self makeProfit];
}

#pragma mark -
#pragma mark Private Methods

- (void)makeProfit {
    [self log:@"profit is going to be made"];
    
    usleep((unsigned int) (1 * IDPRandomUIntWithMinAndMaxValue(1, 3)));
    
    //usleep(25);
    
    [self log:@"profit is made"];
}


@end
