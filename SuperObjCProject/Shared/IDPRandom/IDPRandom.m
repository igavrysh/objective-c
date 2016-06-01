//
//  IDPRandom.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPRandom.h"

@implementation IDPRandom

+ (float)positiveFloatFrom:(float)lowerBound to:(float)upperBound {
    if (lowerBound < 0 || upperBound < 0 || lowerBound > upperBound) {
        return 0;
    }
    
    float result = lowerBound + arc4random_uniform(upperBound);
    
    return result < upperBound ? result + arc4random_uniform(100) / 100.0 : result;
}

+ (UInt8)uint8LimitedTo:(UInt8)upperBound {
    return arc4random_uniform(upperBound);
}

@end
