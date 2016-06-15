//
//  IDPLinkedList.m
//  SuperObjCProject
//
//  Created by Ievgen on 6/15/16.
//  Copyright © 2016 1mlndollarsasset. All rights reserved.
//

#import "IDPLinkedList.h"

#import "IDPLinkedListNode.h"

#import "NSObject+IDPObject.h"

@interface IDPLinkedList ()
@property (nonatomic, retain) IDPLinkedListNode *head;
@property (nonatomic, assign) IDPLinkedListNode *tail;
@property (nonatomic, assign) NSUInteger        count;

@end

@implementation IDPLinkedList

#pragma mark
#pragma mark - Public Methods

- (void)addObject:(id)object {
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

- (id)getObjectBeforeObject:(id)object {
    
}

- (id)getObjectAfterObject:(id)object {
    
}

- (id)removeFirstObject {
    
}

- (id)removeObject:(id)object {
    
}

- (id)removeAllObjects {
    
}

- (BOOL)containsObject:(id)object {
    
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
    
    if (0 != resultLength) {
        for (NSUInteger index = 0; index < resultLength; index++) {
            stackbuf[index] = self[index + state->state];
        }
    }
    
    state->state += resultLength;
    
    return resultLength;
}



@end
