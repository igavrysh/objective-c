//
//  IDPRandom.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/2/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    float minValue;
    float maxValue;
} IDPFloatRange;

typedef struct {
    NSInteger minValue;
    NSInteger maxValue;
} IDPIntRange;

extern
IDPFloatRange IDPFloatRangeCreate(float value1, float value2);

extern
IDPIntRange IDPIntRangeCreate(NSInteger value1, NSInteger value2);

extern
float IDPRandomFloatWithinRange(IDPFloatRange range);

extern
float IDPRandomFloatWithMinAndMaxValue(float value1, float value2);

extern
NSInteger IDPRandomIntWithinRange(IDPIntRange range);

extern
NSInteger IDPRandomIntWithMinAndMaxValue(NSInteger value1, NSInteger value2);

extern
NSUInteger IDPRandomUIntWithMaxValue(NSUInteger limit);
