//
//  IDPLinkedListSet.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPSet.h"

#import "IDPComparison.h"

@interface IDPLinkedListSet : IDPSet
@property (nonatomic, assign, readonly) NSUInteger count;

- (BOOL)containsObject:(IDPComparisonId)object;
- (IDPComparisonId)objectAtIndexedSubscript:(NSUInteger)index;

- (void)addObject:(IDPComparisonId)object;

- (IDPComparisonId)getFirstObject;
- (IDPComparisonId)getObjectBeforeObject:(IDPComparisonId)object;
- (IDPComparisonId)getObjectAfterObject:(IDPComparisonId)object;

- (IDPComparisonId)removeFirstObject;
- (IDPComparisonId)removeObject:(IDPComparisonId)object;
- (IDPComparisonId)removeAllObjects;


@end
