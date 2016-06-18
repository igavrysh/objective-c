//
//  IDPSet.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPComparison.h"

@interface IDPSet : NSObject<NSFastEnumeration>
@property (nonatomic, assign) NSUInteger count;

+ (instancetype)setWithSet:(NSSet *)set;

- (NSSet *)set;

- (instancetype)initWithSet:(NSSet *)set;

- (void)addObjectsFromSet:(NSSet *)set;

- (BOOL)containsObject:(id<IDPComparison>)object;

// the method should be overriden
- (id)objectAtIndexedSubscript:(NSUInteger)index;

- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id<IDPComparison>)object;

- (id<IDPComparison>)firstObject;
- (id<IDPComparison>)lastObject;

- (void)performBlockWithEachObject:(IDPProcessComparisonObject)block;
- (void)iterateObjectsWithBlock:(IDPProcessComparisonObjectWithIndexStop)block;

@end
