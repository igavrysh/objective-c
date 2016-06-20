//
//  NSMutableArray+IDPIndex.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/18/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "NSMutableArray+IDPIndex.h"

#import "NSObject+IDPObject.h"

@interface NSMutableArray (IDPIndex)

- (void)addUniformIndexWithLowerBound:(NSUInteger)lowerBound upperBound:(NSUInteger)upperBound;

@end

@implementation NSMutableArray (IDPIndex)

#pragma mark -
#pragma mark Public Methods

+ (NSMutableArray *)uniformIndexWithRange:(NSRange)indexRange {
    NSUInteger lowerBound = indexRange.location;
    NSUInteger upperBound = lowerBound + indexRange.length;
    
    return [NSMutableArray uniformIndexWithLowerBound:lowerBound upperBound:upperBound];
}

+ (NSMutableArray *)uniformIndexWithLowerBound:(NSUInteger)lowerBound
                                    upperBound:(NSUInteger)upperBound
{
    NSMutableArray *indices = [NSMutableArray object];
    [indices addUniformIndexWithLowerBound:lowerBound upperBound:upperBound];
    
    return indices;
}

#pragma mark -
#pragma mark Private Methods

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
