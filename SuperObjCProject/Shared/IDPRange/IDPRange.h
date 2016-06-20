//
//  IDPRange.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/19/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

static inline
BOOL IDPRangeContainsUIntegerNumber(NSRange range, NSUInteger number) {
    return range.location <= number && range.location + range.length >= number;
}

static inline
BOOL IDPRangeIsLowerToUIntegerNumber(NSRange range, NSUInteger number) {
    return (range.location + range.length) < number;
}

static inline
NSRange IDPMakeUIntegerRange(NSUInteger value1, NSUInteger value2) {
    NSUInteger minValue = MIN(value1, value2);
    NSUInteger maxValue = MAX(value1, value2);
    
    return NSMakeRange(minValue, maxValue - minValue + 1);
}
