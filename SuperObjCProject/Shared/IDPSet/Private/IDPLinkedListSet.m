//
//  IDPLinkedListSet.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPLinkedListSet.h"

#import "IDPLinkedListNode.h"

@interface IDPLinkedListSet ()
@property (nonatomic, retain) IDPLinkedListNode *head;
@property (nonatomic, assign) IDPLinkedListNode *tail;
@property (nonatomic, assign) NSUInteger        count;

@end

@implementation IDPLinkedListSet

#pragma mark
#pragma mark - Public Methods

- (IDPComparisonId)objectAtIndexedSubscript:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    
    NSUInteger counter = 0;
    for (IDPComparisonId object in self) {
        if (counter == index) {
            return object;
        }
        
        counter++;
    }
    
    return nil;
}

- (BOOL)containsObject:(IDPComparisonId)object {
    NSUInteger counter = 0;
    for (IDPComparisonId innerObject in self) {
        if (object == innerObject) {
            return YES;
        }
        
        counter++;
    }
    
    return NO;
}

- (void)addObject:(IDPComparisonId)object {
    IDPLinkedListNode *node= [[IDPLinkedListNode alloc] initWithObject:object
                                                          previousNode:nil
                                                              nextNode:self.head];
    self.head = node;
    if (self.count == 0) {
        self.tail = node;
    }
    
    self.count += 1;
}

- (id)getFirstObject {
    return self.head.object;
}

- (IDPComparisonId)getObjectBeforeObject:(IDPComparisonId)object {
    return nil;
}

- (IDPComparisonId)getObjectAfterObject:(IDPComparisonId)object {
    return nil;
}

- (IDPComparisonId)removeFirstObject {
    return nil;
}

- (IDPComparisonId)removeObject:(IDPComparisonId)object {
    return nil;
}

- (IDPComparisonId)removeAllObjects {
    return nil;
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id *)stackbuf
                                    count:(NSUInteger)resultLength
{
    state->mutationsPtr = (unsigned long *)self;
    
    static IDPLinkedListNode *currentNode = nil;
    if (!state->state) {
        currentNode = self.head;
    }
    
    NSUInteger length = MIN(state->state + resultLength, [self count]);
    resultLength = length - state->state;
    
    if (0 != resultLength) {
        for (NSUInteger index = 0; index < resultLength; index++) {
            stackbuf[index] = currentNode.object;
            currentNode = currentNode.nextNode;
        }
    }
    
    state->itemsPtr = stackbuf;
    
    state->state += resultLength;
    
    return resultLength;
}

@end
