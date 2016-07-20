//
//  IDPCarwashTest.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/4/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwashTest.h"

#import "IDPCarwashDispatcher.h"
#import "IDPCarwash.h"

#import "NSObject+IDPObject.h"

@interface IDPCarwashTest ()
@property (nonatomic, retain) IDPCarwashDispatcher *carwashDispatcher;

@end

@implementation IDPCarwashTest

#pragma mark -
#pragma mark Public Methods

- (void)execute {
    self.carwashDispatcher = [IDPCarwashDispatcher dispatcherWithCarwash:[IDPCarwash object]];
    
    [self.carwashDispatcher start];
    
    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:4]];
}

@end
