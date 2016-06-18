//
//  NSMutableArray+IDPIndex.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/18/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSMutableArray+IDPIndex.h"

@implementation NSMutableArray (IDPIndex)

#pragma mark -
#pragma mark Public Methods

- (void)addUniformIndexWithLowerBound:(NSUInteger)lowerBound
                           upperBound:(NSUInteger)upperBound
{
    NSUInteger midPoint = lowerBound + (upperBound - lowerBound) / 2;
    [self addObject:[NSNumber numberWithUnsignedInteger:midPoint]];
    
    if (midPoint != lowerBound) {
        [self addUniformIndexWithLowerBound:lowerBound upperBound:midPoint - 1];
    }
    
    if (midPoint != upperBound) {
        [self addUniformIndexWithLowerBound:midPoint + 1 upperBound:upperBound];
    }
}

@end
