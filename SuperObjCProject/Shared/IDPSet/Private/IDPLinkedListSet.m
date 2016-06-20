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

- (void)addObjectsFromSet:(NSSet *)set;

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

- (id<IDPComparison>)getFirstObject {
    return self.head.object;
}

#pragma mark
#pragma mark - Private Methods

- (void)addObjectsFromSet:(NSSet *)set  {
    NSMutableArray *array = [[set allObjects] mutableCopy];
    [array sortUsingComparator:
     ^NSComparisonResult(id<IDPComparison> object1, id<IDPComparison> object2) {
         return [object1 compare:object2];
     }];
    
    for (id<IDPComparison> object in array) {
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

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id *)stackbuf
                                    count:(NSUInteger)resultLength
{
    return[self countByEnumeratingWithBlock:^(NSFastEnumerationState *state, id *stackbuf, NSUInteger resultLength) {
        IDPLinkedListNode *currentNode = (IDPLinkedListNode *)state->extra[0];
        if (!currentNode) {
            currentNode = self.head;
        }
        
        if (0 != resultLength) {
            for (NSUInteger index = 0; index < resultLength; index++) {
                stackbuf[index] = currentNode.object;
                currentNode = currentNode.nextNode;
            }
            
            state->extra[0] = (NSUInteger)currentNode;
        }
        
        state->itemsPtr = stackbuf;
    } state:state objects:stackbuf count:resultLength];
}

@end
