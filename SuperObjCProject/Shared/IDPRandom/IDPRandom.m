//
//  IDPRandom.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPRandom.h"

inline
IDPFloatRange IDPFloatRangeCreate(float value1, float value2) {
    IDPFloatRange range;
    range.minValue = MIN(value1, value2);
    range.maxValue = MAX(value1, value2);
    
    return range;
}

inline
IDPIntRange IDPIntRangeCreate(NSInteger value1, NSInteger value2) {
    IDPIntRange range;
    range.minValue = MIN(value1, value2);
    range.maxValue = MAX(value1, value2);
    
    return range;
}

inline
float IDPRandomFloatWithinRange(IDPFloatRange range) {
    return range.minValue + arc4random() / (float)UINT32_MAX * (range.maxValue - range.minValue);
}

inline
float IDPRandomFloatWithMinAndMaxValue(float value1, float value2) {
    return IDPRandomFloatWithinRange(IDPFloatRangeCreate(value1, value2));
}

inline
NSInteger IDPRandomIntWithinRange(IDPIntRange range) {
    return range.minValue + arc4random_uniform(range.maxValue - range.minValue);
}

inline
NSInteger IDPRandomIntWithMinAndMaxValue(NSInteger value1, NSInteger value2) {
    return IDPRandomIntWithinRange(IDPIntRangeCreate(value1, value2));
}

inline
NSUInteger IDPRandomUIntWithMaxValue(NSUInteger value) {
    return IDPRandomIntWithinRange(IDPIntRangeCreate(0, value));
}
