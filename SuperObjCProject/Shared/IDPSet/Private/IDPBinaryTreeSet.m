//
//  IDPBinaryTreeSet.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPBinaryTreeSet.h"

#import "IDPBinaryTreeNode.h"
#import "IDPRange.h"

#import "NSObject+IDPObject.h"
#import "NSArray+IDPIndex.h"

@interface IDPBinaryTreeSet ()
@property (nonatomic, retain) IDPBinaryTreeNode *root;
//@property (nonatomic, assign) IDPBinaryTreeNode **nodes;

- (void)addObjectsFromSet:(NSSet *)set;

- (void)addObject:(id<IDPComparison>)object;

- (IDPBinaryTreeNode *)nodeWithObject:(id<IDPComparison>)object
                                 node:(IDPBinaryTreeNode *)node;

- (void)addObjects:(id *)objects withIndicesRange:(NSRange)range;
- (void)addNode:(IDPBinaryTreeNode *)node
      toObjects:(id *)objects
withIndicesRange:(NSRange)range
        counter:(NSUInteger *)counter;

@end

@implementation IDPBinaryTreeSet

#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithSet:(NSSet *)set {
    self = [self init];
    [self addObjectsFromSet:set];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

/*
- (void)setNodes:(IDPBinaryTreeNode **)nodes {
    
}
*/

#pragma mark -
#pragma mark Public Methods

- (void)addObjectsFromSet:(NSSet *)set {
    NSMutableArray *array = [[set allObjects] mutableCopy];
    [array sortUsingComparator:
     ^NSComparisonResult(id<IDPComparison> object1, id<IDPComparison> object2) {
         return [object1 compare:object2];
     }];
    
    NSArray *indexes = [NSArray arrayWithUniformIndexesCount:[set count]];
    for (NSNumber *index in indexes) {
        [self addObject:array[[index unsignedIntegerValue]]];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)addObject:(id<IDPComparison>)object{
    self.root = [self nodeWithObject:object node:self.root];
}

- (IDPBinaryTreeNode *)nodeWithObject:(id<IDPComparison>)object
                                 node:(IDPBinaryTreeNode *)node
{
    if (!node) {
        self.count += 1;
        return [IDPBinaryTreeNode nodeWithObject:object leftChild:nil rightChild:nil];
    }
    
    IDPBinaryTreeNode *leftChild = node.leftChild;
    IDPBinaryTreeNode *rightChild = node.rightChild;
    if (NSOrderedAscending == [object compare:node.object]) {
        node.leftChild = [self nodeWithObject:object node:leftChild];
    } else if (NSOrderedDescending == [object compare:node.object]) {
        node.rightChild = [self nodeWithObject:object node:rightChild];
    } else {
        node.object = object;
        return node;
    }
    
    return node;
}

- (void)addObjects:(id *)objects withIndicesRange:(NSRange)range {
    memset(objects, 0, sizeof(objects) * range.length);
    NSUInteger counter = 0;
    [self addNode:self.root toObjects:objects withIndicesRange:range counter:&counter];
}

- (void)addNode:(IDPBinaryTreeNode *)node
        toObjects:(id *)objects
withIndicesRange:(NSRange)range
        counter:(NSUInteger *)counter
{
    if (IDPRangeIsLowerToUIntegerNumber(range, *counter)) {
        return;
    }
    
    if (IDPRangeContainsUIntegerNumber(range, *counter)) {
        objects[*counter - range.location] = node.object;
    }
    
    *counter = *counter + 1;
    
    if (node.leftChild) {
        [self addNode:node.leftChild toObjects:objects withIndicesRange:range counter:counter];
    }
    
    if (node.rightChild) {
        [self addNode:node.rightChild toObjects:objects withIndicesRange:range counter:counter];
    }
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id *)stackbuf
                                    count:(NSUInteger)resultLength
{
    state->mutationsPtr = (unsigned long *)self;
    
    NSUInteger length = MIN(state->state + resultLength, [self count]);
    resultLength = length - state->state;
    
    [self addObjects:stackbuf withIndicesRange:NSMakeRange(state->state, resultLength)];
    
    state->itemsPtr = stackbuf;
    
    state->state += resultLength;
    
    return resultLength;
}

@end
