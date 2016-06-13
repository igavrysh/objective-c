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
    [self makeProfit];
    [self receiveCashFromCashOwner:accountant];
}

#pragma mark -
#pragma mark Private Methods

- (void)makeProfit {
    NSLog(@"Profit is made");
}

@end
