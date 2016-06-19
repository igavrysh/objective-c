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

@interface IDPLinkedListSet ()
@property (nonatomic, retain) IDPLinkedListNode *head;
@property (nonatomic, assign) IDPLinkedListNode *tail;

- (void)addObject:(id<IDPComparison>)object;

@end

@implementation IDPLinkedListSet

#pragma mark
#pragma mark - Initializations and Deallocations

- (instancetype)initWithSet:(NSSet *)set {
    self = [super init];
    [self addObjectsFromSet:set];
    
    return self;
}

#pragma mark
#pragma mark - Public Methods

- (void)addObjectsFromSet:(NSSet *)set  {
    for (id<IDPComparison> object in set) {
        [self addObject:object];
    }
}

- (void)addObject:(id<IDPComparison>)object {
    IDPLinkedListNode *node= [IDPLinkedListNode nodeWithObject:object nextNode:self.head previousNode:nil];
                              
    self.head = node;
    if (self.count == 0) {
        self.tail = node;
    }
    
    self.count += 1;
}

- (id<IDPComparison>)getFirstObject {
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
        }
        
        state->extra[0] = (NSUInteger)currentNode;
    }
    
    state->itemsPtr = stackbuf;
    
    state->state += resultLength;
    
    return resultLength;
}

@end
