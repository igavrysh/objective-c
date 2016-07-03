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
    [self log:@"started receiving money form" withObject:washer];
    [self receiveCashFromCashOwner:washer];
    
    [self calculateProfit];
}

#pragma mark -
#pragma mark Private Methods

- (void)calculateProfit {
    [self log:@"cash started calculating"];
    
    //usleep((unsigned int) (1 * IDPRandomUIntWithMinAndMaxValue(1, 3)));
    
    usleep(20);
    
    [self log:@"cash is calculated"];
}

@end
