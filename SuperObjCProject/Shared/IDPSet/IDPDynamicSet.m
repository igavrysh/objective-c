//
//  IDPDynamicSet.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/20/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPDynamicSet.h"

@implementation IDPDynamicSet

#pragma mark -
#pragma mark Public Methods

- (id)objectAtIndex:(NSUInteger)index {
    return [self objectAtIndexedSubscript:index];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    NSUInteger squeredIndex = (NSUInteger)pow(index, 2.0);
    
    if ([self count] <= squeredIndex)   {
        return nil;
    }
    
    return [super objectAtIndex:squeredIndex];
}

@end
