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
@property (nonatomic, readonly) NSUInteger count;

- (BOOL)containsObject:(id<IDPComparison>)object;
- (id<IDPComparison>)objectAtIndexedSubscript:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id<IDPComparison>)object;

- (id<IDPComparison>)getFirstObject;

@end
