//
//  IDPSet.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDPSet : NSObject<NSFastEnumeration>

+ (instancetype)setWithSet:(NSSet *)set;

- (instancetype)initWithSet:(NSSet *)set;

// the method should be overriden
- (NSUInteger)count;

// the method should be overriden
- (NSString *)stringAtIndex:(NSUInteger)index;

- (NSString *)objectAtIndexedSubscript:(NSUInteger)index;

- (NSString *)string;

@end
