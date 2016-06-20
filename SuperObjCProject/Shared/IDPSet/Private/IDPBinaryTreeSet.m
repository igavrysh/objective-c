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
@property (nonatomic, assign) id                *objects;

- (void)allocateObjectsWithSet:(NSSet *)set;

- (void)addObjectsFromSet:(NSSet *)set;

- (void)addObject:(id<IDPComparison>)object;

- (IDPBinaryTreeNode *)nodeWithObject:(id<IDPComparison>)object
                                 node:(IDPBinaryTreeNode *)node;

- (void)addObjects:(id *)objects withIndicesRange:(NSRange)range;
- (void)addNode:(IDPBinaryTreeNode *)node
      toObjects:(id *)objects
withIndicesRange:(NSRange)range
        counter:(NSUInteger *)counter;

- (BOOL)containsObject:(id<IDPComparison>)object withNodeAsRoot:(IDPBinaryTreeNode *)node;

@end

@implementation IDPBinaryTreeSet

#pragma mark -
#pragma mark Class Methods

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.objects = NULL;
    
    [super dealloc];
}

- (instancetype)initWithSet:(NSSet *)set {
    self = [self init];
    [self allocateObjectsWithSet:set];
    [self addObjectsFromSet:set];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setObjects:(id *)objects {
    if (objects != _objects) {
        free(_objects);
        
        _objects = objects;
    }
}

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
        NSUInteger uIntIndex = [index unsignedIntegerValue];
        [self addObject:array[uIntIndex]];
        self.objects[uIntIndex] = array[uIntIndex];
    }
}

- (BOOL)containsObject:(id<IDPComparison>)object {
    return [self containsObject:object withNodeAsRoot:self.root];
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    
    return self.objects[index];
}

#pragma mark -
#pragma mark Private Methods

- (BOOL)containsObject:(id<IDPComparison>)object withNodeAsRoot:(IDPBinaryTreeNode *)node {
    if (!node) {
        return NO;
    }
    
    if (NSOrderedSame == [node.object compare:object]) {
        return YES;
    }
    
    BOOL leftNodeResult = [self containsObject:object withNodeAsRoot:node.leftChild];
    BOOL rightNodeResult = [self containsObject:object withNodeAsRoot:node.rightChild];
    
    return leftNodeResult | rightNodeResult;
}

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

- (void)allocateObjectsWithSet:(NSSet *)set {
    NSUInteger objectsCount = [set count];
    if (0 == objectsCount) {
        return;
    }
    
    self.objects = malloc(sizeof(self.objects) * objectsCount);
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)count1ByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id *)stackbuf
                                    count:(NSUInteger)resultLength
{
    return [self countByEnumeratingWithBlock:^(NSFastEnumerationState *state, id *stackbuf, NSUInteger resultLength) {
        [self addObjects:stackbuf withIndicesRange:NSMakeRange(state->state, resultLength)];
        
        state->itemsPtr = stackbuf;
    } state:state objects:stackbuf count:resultLength];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                          objects:(id *)stackbuf
                                            count:(NSUInteger)resultLength
{
    return [self countByEnumeratingWithBlock:^(NSFastEnumerationState *state, id *stackbuf, NSUInteger resultLength) {
        state->itemsPtr = &self.objects[state->state];
    } state:state objects:stackbuf count:resultLength];
}

@end
