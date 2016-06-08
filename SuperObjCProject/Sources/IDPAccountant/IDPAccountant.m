//
//  IDPAccountant.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPAccountant.h"

#import "IDPCarwasher.h"

@implementation IDPAccountant

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(IDPCarwasher *)washer {
    [self doJob];
    [super receiveCashFromCashOperatingObject:washer];
}

#pragma mark -
#pragma mark Private Methods

- (void)doJob {
    [self printMessage:@"Cash is calculated"];
}

@end
