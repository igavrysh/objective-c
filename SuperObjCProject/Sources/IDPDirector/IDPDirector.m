//
//  IDPDirector.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPDirector.h"

#import "IDPAccountant.h"

@implementation IDPDirector

#pragma mark -
#pragma mark Public Methods

- (void)processObject:(IDPAccountant *)accountant {
    [self doJob];
    [super receiveCashFromCashOperatingObject:accountant];
}

#pragma mark -
#pragma mark Private Methods

- (void)doJob {
    [self printMessage:@"Profit is made"];
}

@end
