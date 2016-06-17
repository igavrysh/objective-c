//
//  IDPLinkedListSet.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPLinkedListSet.h"

#import "IDPLinkedListNode.h"

#import "NSObject+IDPObject.h"
#import "IDPConstants.h"

@interface IDPLinkedListSet ()
@property (nonatomic, retain) IDPLinkedListNode *head;
@property (nonatomic, assign) IDPLinkedListNode *tail;
@property (nonatomic, assign) NSUInteger        count;

- (void)addObject:(id<IDPComparison>)object;

@end

@implementation IDPLinkedListSet

#pragma mark
#pragma mark - Initializations and Deallocations

- (instancetype)initWithSet:(NSSet *)set {
    self = [super init];
    if (self) {
        for (id<IDPComparison> object in set) {
            [self addObject:object];
        }
    }
    return self;
}

#pragma mark
#pragma mark - Public Methods

- (NSUInteger)indexOfObject:(id<IDPComparison>)object {
    __block NSUInteger resultIndex = kIDPNotFound;
    
    [self enumerateObjectsUsingBlock:^(id<IDPComparison> blockObject, NSUInteger index, BOOL *stop) {
        if (NSOrderedSame == [blockObject compareToObject:object]) {
            resultIndex = index;
            *stop = YES;
        }
    }];
    
    return resultIndex;
}

- (id<IDPComparison>)objectAtIndexedSubscript:(NSUInteger)index {
    __block id<IDPComparison> resultObject = nil;
    
    [self enumerateObjectsUsingBlock:^(id<IDPComparison> blockObject, NSUInteger blockIndex, BOOL *stop) {
        if (blockIndex == index) {
            *stop = YES;
            resultObject = blockObject;
        }
    }];
    
    return resultObject;
}

- (BOOL)containsObject:(id<IDPComparison>)object {
    return kIDPNotFound != [self indexOfObject:object];
}

- (void)addObject:(id<IDPComparison>)object {
    IDPLinkedListNode *node= [IDPLinkedListNode nodeWithObject:object nextNode:self.head previousNode:nil];
                              
    self.head = node;
    if (self.count == 0) {
        self.tail = node;
    }
    
    self.count += 1;
}

- (id)getFirstObject {
    return self.head.object;
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id *)stackbuf
                                    count:(NSUInteger)resultLength
{
    state->mutationsPtr = (unsigned long *)self;
    
    IDPLinkedListNode *currentNode = (IDPLinkedListNode *)state->extra[0];
    if (!currentNode) {
        currentNode = self.head;
    }
    
    NSUInteger length = MIN(state->state + resultLength, [self count]);
    resultLength = length - state->state;
    
    if (0 != resultLength) {
        for (NSUInteger index = 0; index < resultLength; index++) {
            stackbuf[index] = currentNode.object;
            currentNode = currentNode.nextNode;
            state->extra[0] = (NSUInteger)currentNode;
        }
    }
    
    state->itemsPtr = stackbuf;
    
    state->state += resultLength;
    
    return resultLength;
}

@end
