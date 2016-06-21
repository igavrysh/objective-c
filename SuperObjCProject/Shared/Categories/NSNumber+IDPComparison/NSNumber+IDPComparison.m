//
//  NSNumber+IDPComparison.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/20/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSNumber+IDPComparison.h"

@implementation NSNumber (IDPNumber)

#pragma mark -
#pragma mark Public methods

- (NSComparisonResult)compareToObject:(id)object {
    if ([self class] != [object class]) {
        return NSOrderedDescending;
    }
    
    return [self compare:object];
}

@end
