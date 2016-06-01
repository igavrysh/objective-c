//
//  IDPRandom.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/1/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPRandom : NSObject

+ (float)positiveFloatFrom:(float)lowerBound to:(float)upperBound;

+ (UInt8)uint8LimitedTo:(UInt8)upperBound;

@end
