//
//  IDPCarwashTest.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/4/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPCarwashTest.h"

#import "IDPCarwashDispatcher.h"

#import "NSObject+IDPObject.h"

@interface IDPCarwashTest ()
@property (nonatomic, retain) IDPCarwashDispatcher *carwashDispatcher;

@end

@implementation IDPCarwashTest

#pragma mark -
#pragma mark Public Methods

- (void)execute {
    self.carwashDispatcher = [IDPCarwashDispatcher object];
    
    [self.carwashDispatcher start];
    
    [[NSRunLoop mainRunLoop] run];
}

@end
