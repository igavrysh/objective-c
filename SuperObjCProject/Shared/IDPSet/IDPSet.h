//
//  IDPSet.h
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IDPComparison.h"

typedef void(^IDPEnumerationBlock)(NSFastEnumerationState * state, id *stackbuf, NSUInteger resultLength);

@interface IDPSet : NSObject<NSFastEnumeration>
@property (nonatomic, assign) NSUInteger count;

+ (instancetype)setWithSet:(NSSet *)set;
+ (instancetype)linkedListSetWithSet:(NSSet *)set;
+ (instancetype)binaryTreeSetWithSet:(NSSet *)set;

- (NSSet *)set;

- (instancetype)initWithSet:(NSSet *)set;
- (instancetype)initLinkedListSetWithSet:(NSSet *)set;
- (instancetype)initBinrayTreeSetWithSet:(NSSet *)set;

- (BOOL)containsObject:(id<IDPComparison>)object;

// the method should be overriden
- (id)objectAtIndexedSubscript:(NSUInteger)index;

- (id)objectAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfObject:(id<IDPComparison>)object;

- (id<IDPComparison>)firstObject;
- (id<IDPComparison>)lastObject;

- (void)performBlockWithEachObject:(IDPProcessComparisonObject)block;
- (void)iterateObjectsWithBlock:(IDPProcessComparisonObjectWithIndexStop)block;

- (NSUInteger)countByEnumeratingWithBlock:(IDPEnumerationBlock)block
                                    state:(NSFastEnumerationState *)state
                                  objects:(id *)stackbuf
                                    count:(NSUInteger)resultLength;

@end
