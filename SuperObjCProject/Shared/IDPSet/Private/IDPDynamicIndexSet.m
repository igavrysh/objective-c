//
//  IDPDynamicIndexSet.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/20/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPDynamicIndexSet.h"

@interface IDPDynamicIndexSet ()

@end

@implementation IDPDynamicIndexSet

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithObjectsCount:(NSUInteger)count {
    self = [super init];
    self.count = sqrt(count);
    
    return self;
    
}

#pragma mark -
#pragma mark Public Methods

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [NSNumber numberWithUnsignedInteger:(NSUInteger)pow(index, 2.0)];
}

@end
