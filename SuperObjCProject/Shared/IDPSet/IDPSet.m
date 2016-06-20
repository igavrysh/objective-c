//
//  IDPSet.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPSet.h"

#import "IDPLinkedListSet.h"
#import "IDPBinaryTreeSet.h"
#import "IDPDynamicSet.h"

#import "NSObject+IDPObject.h"

@interface IDPSet ()

@end

@implementation IDPSet

#pragma mark -
#pragma mark Class methods

+ (instancetype)setWithSet:(NSSet *)set {
    return [[[IDPLinkedListSet alloc] initWithSet:set] autorelease];
}

+ (instancetype)linkedListSetWithSet:(NSSet *)set {
    return [[[IDPLinkedListSet alloc] initLinkedListSetWithSet:set] autorelease];
}

+ (instancetype)binaryTreeSetWithSet:(NSSet *)set {
    return [[[IDPBinaryTreeSet alloc] initBinrayTreeSetWithSet:set] autorelease];
}

+ (instancetype)dynamicIndexSet {
    return [IDPDynamicSet object];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithSet:(NSSet *)set {
    [self autorelease];
    
    return [self initLinkedListSetWithSet:set];
}

- (instancetype)initLinkedListSetWithSet:(NSSet *)set {
    [self release];
    
    return [[IDPLinkedListSet alloc] initWithSet:set];
}

- (instancetype)initBinrayTreeSetWithSet:(NSSet *)set {
    [self release];
    
    return [[IDPBinaryTreeSet alloc] initWithSet:set];
}

#pragma mark -
#pragma mark Public Methods

- (NSUInteger)indexOfObject:(id<IDPComparison>)object {
    __block NSUInteger resultIndex = NSNotFound;
    
    [self iterateObjectsWithBlock:^(id<IDPComparison> blockObject, NSUInteger index, BOOL *stop) {
        if (NSOrderedSame == [blockObject compareToObject:object]) {
            resultIndex = index;
            *stop = YES;
        }
    }];
    
    return resultIndex;
}

- (id)objectAtIndex:(NSUInteger)index {
    return self[index];
}

- (id<IDPComparison>)objectAtIndexedSubscript:(NSUInteger)index {
    __block id<IDPComparison> resultObject = nil;
    
    [self iterateObjectsWithBlock:^(id<IDPComparison> blockObject, NSUInteger blockIndex, BOOL *stop) {
        if (blockIndex == index) {
            *stop = YES;
            resultObject = blockObject;
        }
    }];
    
    return resultObject;
}

- (BOOL)containsObject:(id<IDPComparison>)object {
    return NSNotFound != [self indexOfObject:object];
}

- (id<IDPComparison>)firstObject {
    if ([self count] == 0) {
        return nil;
    }
    
    return self[0];
}

- (id<IDPComparison>)lastObject {
    NSUInteger objectsCount = [self count];
    if (objectsCount == 0) {
        return nil;
    }
    
    return self[objectsCount - 1];
}

- (NSSet *)set {
    __block NSMutableSet *set = [NSMutableSet object];
    
    [self performBlockWithEachObject:^(id<IDPComparison> object) {
        [set addObject:object];
    }];
    
    return [[set copy] autorelease];
}

- (void)performBlockWithEachObject:(IDPObjectBlock)block {
    if (!block) {
        return;
    }
    
    [self iterateObjectsWithBlock:^(id<IDPComparison> object, NSUInteger index, BOOL *stop) {
        block(object);
    }];
}

- (void)iterateObjectsWithBlock:(IDPArrayIteratrionBlock)block {
    if (!block) {
        return;
    }
    
    NSUInteger index = 0;
    BOOL stop = NO;
    for (id<IDPComparison> object in self) {
        block(object, index, &stop);
        
        if (stop) {
            break;
        }
        
        index++;
    }
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id *)stackbuf
                                    count:(NSUInteger)resultLength
{
    return [self countByEnumeratingWithState:state
                                     objects:stackbuf
                                       count:resultLength
                                       block:^(NSFastEnumerationState *state, id *stackbuf, NSUInteger resultLength)
    {
        if (0 != resultLength) {
            for (NSUInteger index = 0; index < resultLength; index++) {
                stackbuf[index] = self[index + state->state];
            }
        }
        
        state->itemsPtr = stackbuf;
    }];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id *)stackbuf
                                    count:(NSUInteger)resultLength
                                    block:(IDPEnumerationBlock)block
{
    if (!block) {
        return 0;
    }
    
    state->mutationsPtr = (unsigned long *)self;
    
    NSUInteger length = MIN(state->state + resultLength, [self count]);
    resultLength = length - state->state;
    
    block(state, stackbuf, resultLength);
    
    state->state += resultLength;
    
    return resultLength;
}


@end
