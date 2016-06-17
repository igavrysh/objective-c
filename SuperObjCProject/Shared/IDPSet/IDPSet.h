//
//  IDPSet.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDPComparison;

@interface IDPSet : NSObject<NSFastEnumeration>

+ (instancetype)setWithSet:(NSSet *)set;

- (instancetype)initWithSet:(NSSet *)set;

// the method should be overriden
- (NSUInteger)count;

// the method should be overriden

- (id<IDPComparison>)objectAtIndexedSubscript:(NSUInteger)index;

- (NSSet *)set;

- (void)enumerateObjectsUsingSimpleBlock:(void(^)(id<IDPComparison>))block;
- (void)enumerateObjectsUsingBlock:(void(^)(id<IDPComparison> object, NSUInteger index, BOOL *stop))block;

@end
